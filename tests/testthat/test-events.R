library(dplyr, warn.conflicts = FALSE)
library(stringr)
fisdata:::clear_cache()

test_that("get_events_url() works with valid inputs", {
  expect_equal(
    get_events_url(),
    paste0("https://www.fis-ski.com/DB/general/calendar-results.html?",
           "eventselection=&place=&sectorcode=&seasoncode=&categorycode=&",
           "disciplinecode=&gendercode=&racedate=&racecodex=&nationcode=&",
           "seasonmonth=")
  )
  expect_equal(
    get_events_url(sector = "AL", season = 2025, month = 9),
    paste0("https://www.fis-ski.com/DB/general/calendar-results.html?",
           "eventselection=&place=&sectorcode=AL&seasoncode=2025&",
           "categorycode=&disciplinecode=&gendercode=&racedate=&racecodex=&",
           "nationcode=&seasonmonth=09-2024")
  )
  expect_equal(
    get_events_url(selection = "upcoming", category = "WC", gender = "F"),
    paste0("https://www.fis-ski.com/DB/general/calendar-results.html?",
           "eventselection=upcoming&place=&sectorcode=&seasoncode=&",
           "categorycode=WC&disciplinecode=&gendercode=W&racedate=&",
           "racecodex=&nationcode=&seasonmonth=")
  )
  expect_equal(
    get_events_url(date = "2025-02-01", gender = "M"),
    paste0("https://www.fis-ski.com/DB/general/calendar-results.html?",
           "eventselection=&place=&sectorcode=&seasoncode=2025&categorycode=&",
           "disciplinecode=&gendercode=M&racedate=01.02.2025&",
           "racecodex=&nationcode=&seasonmonth=")
  )
  expect_equal(
    get_events_url(place = "Kitzbühel", discipline = "DH",
                   season = 2022),
    paste0("https://www.fis-ski.com/DB/general/calendar-results.html?",
           "eventselection=&place=kitzbuehel&sectorcode=&seasoncode=2022&",
           "categorycode=&disciplinecode=DH&gendercode=&racedate=&",
           "racecodex=&nationcode=&seasonmonth=")
  )
})


test_that("get_events_url() works with inputs that must be matched", {
  expect_equal(
    get_events_url(sector = "alpine", season = 2025, month = 9),
    paste0("https://www.fis-ski.com/DB/general/calendar-results.html?",
           "eventselection=&place=&sectorcode=AL&seasoncode=2025&",
           "categorycode=&disciplinecode=&gendercode=&racedate=&racecodex=&",
           "nationcode=&seasonmonth=09-2024")
  )
  expect_equal(
    get_events_url(selection = "upcoming", category = "world cup",
                   gender = "F"),
    paste0("https://www.fis-ski.com/DB/general/calendar-results.html?",
           "eventselection=upcoming&place=&sectorcode=&seasoncode=&",
           "categorycode=WC&disciplinecode=&gendercode=W&racedate=&",
           "racecodex=&nationcode=&seasonmonth=")
  )
  expect_equal(
    get_events_url(place = "Kitzbühel", discipline = "downhill",
                   season = 2022, month = 1),
    paste0("https://www.fis-ski.com/DB/general/calendar-results.html?",
           "eventselection=&place=kitzbuehel&sectorcode=&seasoncode=2022&",
           "categorycode=&disciplinecode=DH&gendercode=&racedate=&",
           "racecodex=&nationcode=&seasonmonth=01-2022")
  )
})


test_that("get_events_url() handles month and season correctly", {
  get_month <- function(...) {
    str_extract(get_events_url(...), "seasonmonth=.*$")
  }

  # months in the second half of the year belong to the previous year
  expect_equal(get_month(season = 2025, month = 12), "seasonmonth=12-2024")
  expect_equal(get_month(season = 2025, month = 7), "seasonmonth=07-2024")
  expect_equal(get_month(season = 2025, month = 6), "seasonmonth=06-2025")
  expect_equal(get_month(season = 2025, month = 1), "seasonmonth=01-2025")

  # season and month may also be given as character
  expect_equal(get_month(season = "2025", month = 12), "seasonmonth=12-2024")
  expect_equal(get_month(season = 2025, month = "10"), "seasonmonth=10-2024")
  expect_equal(get_month(season = "2025", month = "3"), "seasonmonth=03-2025")

  # month is dropped if season is not given
  expect_equal(get_month(month = 12), "seasonmonth=")
  expect_equal(get_month(season = "", month = 3), "seasonmonth=")

  # month is dropped if date is given
  expect_equal(get_month(date = "2025-02-01", month = 12), "seasonmonth=")

  # seasonmonth is not used to filter for season only
  expect_equal(get_month(season = 2025), "seasonmonth=")
})


test_that("get_events_url() works with season from the defaults", {
  withr::defer(reset_fisdata_defaults())
  set_fisdata_defaults(season = 2025, verbose = FALSE)
  expect_equal(
    str_extract(get_events_url(season = fd_def("season"), month = 12),
                "seasonmonth=.*$"),
    "seasonmonth=12-2024"
  )
})


test_that("get_events_url() errors for invalid month or season", {
  expect_error(get_events_url(season = 2025, month = 13),
               "'month' must be an integer between 1 and 12")
  expect_error(get_events_url(season = 2025, month = 0),
               "'month' must be an integer between 1 and 12")
  expect_error(get_events_url(season = 2025, month = "Dec"),
               "'month' must be an integer between 1 and 12")
  expect_error(get_events_url(season = "abc"),
               "'season' must be a single integer")
  expect_error(get_events_url(season = "abc", month = 12),
               "'season' must be a single integer")
})


test_that("query_events() works with events from many sectors", {
  local_mocked_bindings(
    get_events_url = function(...) test_path("data", "events_20250201.html.gz"),
    # because dates in the current season are handled differently from other
    # dates, we also need to mock today() to make fisdata believe
    # that we are still in the season 2025/26
    today = function(...) as.Date("2025-04-01")
  )

  date <- as.Date("2025-02-01")
  events_20250201 <- query_events(date = date)

  expect_s3_class(events_20250201, "tbl_df")

  expected_names <- c("start_date", "end_date", "place", "nation", "sector",
                      "categories", "disciplines", "genders", "cancelled",
                      "event_id")
  expect_named(events_20250201, expected_names)

  expected_types <- rep("character", length(expected_names)) %>%
    replace(c(1, 2, 9), c("Date", "Date", "logical"))
  for (i in seq_along(expected_names)) {
     if (expected_types[i] == "Date") {
        expect_s3_class(events_20250201[[!!expected_names[i]]], expected_types[i])
      } else {
        expect_type(events_20250201[[!!expected_names[i]]], expected_types[i])
      }
  }

  expect_lte(max(events_20250201$start_date), date)
  expect_gte(min(events_20250201$end_date), date)
  expect_in(events_20250201$nation, nations$code)
  expect_in(events_20250201$sector, sectors$code)
  expect_match(events_20250201$categories, "^[A-Z]{2,5}( / [A-Z]{2,5})*$")
  expect_match(
    events_20250201$disciplines,
    "^([0-9]{1,2}x)?[A-Za-z0-9]{2,6}( / ([0-9]{1,2}x)?[A-Za-z0-9]{2,6})*$"
  )
  expect_in(events_20250201$genders, c("M", "W", "M / W"))
  expect_match(events_20250201$event_id, "^[0-9]+$")

  expect_equal(attr(events_20250201, "url"), get_events_url())

  expect_snapshot(print(events_20250201, width = Inf, n = Inf))
})


test_that("query_events() works when there is a live event", {
  local_mocked_bindings(
    get_events_url = function(...) test_path("data", "events_al_wc_live.html.gz")
  )
  events_live <- query_events(sector = "AL", category = "WC",
                              season = 2025, month = 2)
  expect_s3_class(events_live, "tbl_df")

  expected_names <- c("start_date", "end_date", "place", "nation", "sector",
                      "categories", "disciplines", "genders", "cancelled",
                      "event_id")
  expect_named(events_live, expected_names)

  expected_types <- rep("character", length(expected_names)) %>%
    replace(c(1, 2, 9), c("Date", "Date", "logical"))
  for (i in seq_along(expected_names)) {
     if (expected_types[i] == "Date") {
        expect_s3_class(events_live[[!!expected_names[i]]], expected_types[i])
      } else {
        expect_type(events_live[[!!expected_names[i]]], expected_types[i])
      }
  }

  expect_true(
    all(
      format(events_live$start_date, "%Y/%m") == "2025/02" |
        format(events_live$end_date, "%Y/%m") == "2025/02"
    )
  )
  expect_in(events_live$nation, nations$code)
  expect_in(events_live$sector, "AL")
  expect_match(events_live$categories, "^[A-Z]{2,5}( / [A-Z]{2,5})*$")
  expect_match(
    events_live$disciplines,
    "^([0-9]{1,2}x)?[A-Za-z0-9]{2,6}( / ([0-9]{1,2}x)?[A-Za-z0-9]{2,6})*$"
  )
  expect_in(events_live$genders, c("M", "W", "M / W"))
  expect_match(events_live$event_id, "^[0-9]+$")

  expect_equal(attr(events_live, "url"), get_events_url())

  expect_snapshot(print(events_live, width = Inf, n = Inf))
})


test_that("query_current_events() works", {
  local_mocked_bindings(
    get_events_url = function(...) test_path("data", "events_20250201.html.gz")
  )
  events_current <- query_current_events()
  expect_equal(events_current, query_events())

  expect_equal(attr(events_current, "url"), get_events_url())
})


test_that("query_events() works with empty results", {
  local_mocked_bindings(
    get_events_url = function(...) test_path("data", "events_empty.html.gz")
  )
  empty <- query_events(sector = "SB", place = "Wengen")
  expect_s3_class(empty, "tbl_df")
  expect_equal(nrow(empty), 0)

  expected_names <- c("start_date", "end_date", "place", "nation", "sector",
                      "categories", "disciplines", "genders", "cancelled",
                      "event_id")
  expect_named(empty, expected_names)

  expected_types <- rep("character", length(expected_names)) %>%
    replace(c(1, 2, 9), c("Date", "Date", "logical"))
  for (i in seq_along(expected_names)) {
     if (expected_types[i] == "Date") {
        expect_s3_class(empty[[!!expected_names[i]]], expected_types[i])
      } else {
        expect_type(empty[[!!expected_names[i]]], expected_types[i])
      }
  }

  expect_equal(attr(empty, "url"), get_events_url())
})

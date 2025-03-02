library(tibble)

test_that("get_competitions_url() works with valid inputs", {
  wengen_2025 <- tibble(sector = "AL", place = "Wengen", event_id = 55595)
  expect_equal(
    get_competitions_url(wengen_2025),
    paste0("https://www.fis-ski.com/DB/general/event-details.html?",
           "sectorcode=AL&eventid=55595")
  )
})


test_that("ensure_one_event() works", {
  events <- tibble(
    place = c("Wengen", "Flachau"),
    sector = "AL",
    event_id = c(55595, 55596)
  )
  expect_equal(ensure_one_event(events), events[1, ]) %>%
    expect_warning("Multiple events.*Wengen")
  expect_equal(ensure_one_event(events[1, ]), events[1, ]) %>%
    expect_silent()
  expect_error(ensure_one_event(events[integer(0), ]),
               "No event was passed")
})


test_that("query_competitions() works for an apline skiing event", {
  local_mocked_bindings(
    get_competitions_url = function(...) test_path("data", "competitions_wengen_2025.html.gz")
  )
  wengen_2025 <- tibble(sector = "AL", place = "Wengen", event_id = 55595)
  competitions <- query_competitions(wengen_2025)

  expect_s3_class(competitions, "tbl_df")

  expected_names <- c("place", "date", "time", "competition", "sector",
                      "category", "gender", "cancelled", "race_id")
  expect_named(competitions, expected_names)

  expected_types <- rep("character", 9) %>%
    replace(c(2, 8), c("Date", "logical"))
  for (i in seq_along(expected_types)) {
    if (expected_types[i] == "Date") {
        expect_s3_class(competitions[[expected_names[i]]], expected_types[i])
      } else {
        expect_type(competitions[[!!expected_names[i]]], expected_types[i])
      }
  }

  expect_in(
    competitions$date,
    seq(as.Date("2025-01-14"), as.Date("2025-01-19"), by = "1 day")
  )
  expect_match(na.omit(competitions$time), "^[01][0-9]:[0-5][0-9]$")
  expect_in(competitions$sector, "AL")
  expect_in(competitions$category, categories$code)
  expect_in(competitions$gender, "M")
  expect_match(competitions$race_id, "^[0-9]+$")

  expect_equal(attr(competitions, "url"), get_competitions_url())

  expect_snapshot(print(competitions, width = Inf, n = Inf))
})


test_that("query_competitions() works for a ski jumping event", {
  local_mocked_bindings(
    get_competitions_url = function(...) test_path("data", "competitions_lahti_2025.html.gz")
  )
  lahti_2025 <- tibble(sector = "JP", place = "Lahti", event_id = 55900)
  competitions <- query_competitions(lahti_2025)

  expect_s3_class(competitions, "tbl_df")

  expected_names <- c("place", "date", "time", "competition", "sector",
                      "category", "gender", "cancelled", "race_id")
  expect_named(competitions, expected_names)

  expected_types <- rep("character", 9) %>%
    replace(c(2, 8), c("Date", "logical"))
  for (i in seq_along(expected_types)) {
    if (expected_types[i] == "Date") {
        expect_s3_class(competitions[[expected_names[i]]], expected_types[i])
      } else {
        expect_type(competitions[[!!expected_names[i]]], expected_types[i])
      }
  }

  expect_in(
    competitions$date,
    seq(as.Date("2025-03-20"), as.Date("2025-03-23"), by = "1 day")
  )
  expect_match(na.omit(competitions$time), "^[01][0-9]:[0-5][0-9]$")
  expect_in(competitions$sector, "JP")
  expect_in(competitions$category, categories$code)
  expect_in(competitions$gender, c("M", "W"))
  expect_match(competitions$race_id, "^[0-9]+$")

  expect_equal(attr(competitions, "url"), get_competitions_url())

  expect_snapshot(print(competitions, width = Inf, n = Inf))
})


test_that("query_competitions() works for a cross-country event", {
  local_mocked_bindings(
    get_competitions_url = function(...) test_path("data", "competitions_engadin_2025.html.gz")
  )
  engadin_2025 <- tibble(sector = "CC", place = "Engadin", event_id = 55852)
  competitions <- query_competitions(engadin_2025)

  expect_s3_class(competitions, "tbl_df")

  expected_names <- c("place", "date", "time", "competition", "sector",
                      "category", "gender", "cancelled", "race_id")
  expect_named(competitions, expected_names)

  expected_types <- rep("character", 9) %>%
    replace(c(2, 8), c("Date", "logical"))
  for (i in seq_along(expected_types)) {
    if (expected_types[i] == "Date") {
        expect_s3_class(competitions[[expected_names[i]]], expected_types[i])
      } else {
        expect_type(competitions[[!!expected_names[i]]], expected_types[i])
      }
  }

  expect_in(
    competitions$date,
    seq(as.Date("2025-01-24"), as.Date("2025-01-26"), by = "1 day")
  )
  expect_match(na.omit(competitions$time), "^[01][0-9]:[0-5][0-9]$")
  expect_in(competitions$sector, "CC")
  expect_in(competitions$category, categories$code)
  expect_in(competitions$gender, c("A", "M", "W"))
  expect_match(competitions$race_id, "^[0-9]+$")

  expect_equal(attr(competitions, "url"), get_competitions_url())

  expect_snapshot(print(competitions, width = Inf, n = Inf))
})


test_that("query_competitions() works for empty result", {
  local_mocked_bindings(
    get_competitions_url = function(...) test_path("data", "competitions_empty.html.gz")
  )
  event <- tibble(sector = "AL", place = "Wengen", race_id = 35678943)
  empty <- query_competitions(event)

  expect_s3_class(empty, "tbl_df")
  expect_equal(nrow(empty), 0)

  expected_names <- c("place", "date", "time", "competition", "sector",
                      "category", "gender", "cancelled", "race_id")
  expect_named(empty, expected_names)

  expected_types <- rep("character", 9) %>%
    replace(c(2, 8), c("Date", "logical"))
  for (i in seq_along(expected_types)) {
    if (expected_types[i] == "Date") {
        expect_s3_class(empty[[expected_names[i]]], expected_types[i])
      } else {
        expect_type(empty[[!!expected_names[i]]], expected_types[i])
      }
  }

  expect_equal(attr(empty, "url"), get_competitions_url())
})

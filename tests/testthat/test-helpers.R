library(lubridate, warn.conflicts = FALSE)
library(dplyr, warn.conflicts = FALSE)
library(rvest)

test_that("show_url() works", {
  local_mocked_bindings(
    get_athletes_url = function(...) test_path("data", "athletes_cuche.html.gz")
  )
  cuche <- query_athletes()

  expect_equal(show_url(cuche), get_athletes_url())

  expect_equal(show_url(mtcars), NULL)
})


test_that("replace_special_chars() works", {
  expect_equal(
    replace_special_chars(
      c("Loïc", "Mélanie", "Žan", "Kostelić", "Štuhec", "Müller")
    ),
    c("loic", "melanie", "zan", "kostelic", "stuhec", "mueller")
  )
  expect_equal(
    replace_special_chars(
      c("à", "á", "å", "ä", "æ", "ç", "ć", "č", "ð", "é", "è", "ê", "ë", "ï",
        "ñ", "ø", "ó", "ő", "ö", "œ", "š", "ß", "ú", "ü", "ž")
    ),
    c("a", "a", "a", "ae", "ae", "c", "c", "c", "d", "e", "e", "e", "e", "i",
      "n", "o", "o", "o", "oe", "oe", "s", "ss", "u", "ue", "z")
  )
  expect_equal(
    replace_special_chars(
      toupper(
        c("à", "á", "å", "ä", "æ", "ç", "ć", "č", "ð", "é", "è", "ê", "ë", "ï",
          "ñ", "ø", "ó", "ő", "ö", "œ", "š", "ß", "ú", "ü", "ž")
      )
    ),
    c("a", "a", "a", "ae", "ae", "c", "c", "c", "d", "e", "e", "e", "e", "i",
      "n", "o", "o", "o", "oe", "oe", "s", "ss", "u", "ue", "z")
  )
  expect_equal(
    replace_special_chars(c("Von Allmen", "Von\tAllmen", "Von  Allmen")),
    rep("von%20%allmen", 3)
  )
})


test_that("format_birthdate() works", {
  expect_equal(
    format_birthdate(c("08-10-1997", "1974", "1987", "12-05-1993", NA)),
    c("1997-10-08", "1974", "1987", "1993-05-12", NA)
  )
})


test_that("parse_race_time() works", {
  expect_equal(
    parse_race_time(
      c("43.5", "1:24.78", "2:32:5.04", "+43.5", "-1:24.78", "+2:32:5.04",
        "-1:.4", "+.32", "-.67", "+0.00", "+.0", NA)
    ),
    as.period(
      c("43.5S", "1M 24.78S", "2H 32M 5.04S", "43.5S", "-1M 24.78S",
        "2H 32M 5.04S", "-1M 0.4S", "0.32S", "-0.67S", "0S", "0S", NA)
    )
  )
})


test_that("parse_number() works", {
  expect_equal(
    parse_number(
      c("5", "34.6", "5432.7", "1'423.5", "9'593", ".2", "0.3", "-.5",
        "-4.8", "-4'568.14", "DNS", NA)
    ),
    c(5, 34.6, 5432.7, 1423.5, 9593, .2, .3, -.5, -4.8, -4568.14, NA, NA)
  )
})


test_that("standardise_colnames() works", {
  expect_equal(
    standardise_colnames(
      c("abc", "ABC", "Run 1", "Diff. Time", " % . Run_ _.2 /__*", "FIS points")
    ),
    c("abc", "abc", "run1", "diff_time", "run2", "fis_points")
  )
})


test_that("parse_gender_list() works", {
  expect_equal(
    parse_gender_list(c("AL\nW\nM", "AL\nW", "AL\nM", "AL\nW\nM")),
    c("M / W", "W", "M", "M / W")
  )
})


test_that("get_half_of_the_year_at_date() works", {
  expect_equal(get_half_of_the_year_at_date(as.Date("2023-03-07")), c(2023, 1))
  expect_equal(get_half_of_the_year_at_date(as.Date("2020-06-30")), c(2020, 1))
  expect_equal(get_half_of_the_year_at_date(as.Date("2021-11-07")), c(2021, 2))
  expect_equal(get_half_of_the_year_at_date(as.Date("2020-07-01")), c(2020, 2))
})


test_that("get_season_at_date() works", {
  expect_equal(get_season_at_date(as.Date("2025-04-06")), 2025)
  expect_equal(get_season_at_date(as.Date("2024-10-15")), 2025)
})


test_that("parse_event_dates() works", {
  test_dates <- c(
    # date ranges with year
    "28 Dec-\n06 Jan 2024", "20 Jan-\n01 Feb 2024", "18-20 Oct 2023",
    "30 Oct 2023",
    # date ranges without year
    "28 Dec-\n06 Jan", "20 Jan-\n01 Feb", "18-20 Oct", "30 Oct")

  # test during the first half of the year
  local_mocked_bindings(
    get_half_of_the_year_at_date = function(x) c(2025, 1)
  )

  expected <- tibble(
    start_date = as.Date(
      c("2023-12-28", "2024-01-20", "2023-10-18", "2023-10-30",
        "2024-12-28", "2025-01-20", "2024-10-18", "2024-10-30")
    ),
    end_date = as.Date(
      c("2024-01-06", "2024-02-01", "2023-10-20", "2023-10-30",
        "2025-01-06", "2025-02-01", "2024-10-20", "2024-10-30")
    )
  )
  expect_equal(parse_event_dates(test_dates), expected)

  # test during the second half of the year
  local_mocked_bindings(
    get_half_of_the_year_at_date = function(x) c(2024, 2)
  )
  expect_equal(parse_event_dates(test_dates), expected)
})


test_that("parse_event_details() works", {
  event_details <- c("TRA • FIS\n8xDH 4xSG", "FWTP\n2xSB 2xSK",
                     "EC • QUA\n8xPSL", "NJR\n4xSL")
  expected <- tibble(
    categories = c("TRA / FIS", "FWTP", "EC / QUA", "NJR"),
    disciplines = c("8xDH / 4xSG", "2xSB / 2xSK", "8xPSL", "4xSL")
  )
  expect_equal(parse_event_details(event_details), expected)
})


test_that("parse_event_details() works for an empty string", {
  event_details <- c("TRA • FIS\n8xDH 4xSG", "")
  expected <- tibble(
    categories = c("TRA / FIS", ""),
    disciplines = c("8xDH / 4xSG", "")
  )
  expect_equal(parse_event_details(event_details), expected)
})


test_that("is_cancelled() works", {
  html <- read_html(test_path("data", "events_20250201.html.gz"))
  expect_equal(which(is_cancelled(html)), c(17, 25, 38, 42, 46, 62))
})

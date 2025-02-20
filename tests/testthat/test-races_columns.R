library(rvest, warn.conflicts = FALSE)
library(lubridate, warn.conflicts = FALSE)
library(dplyr, warn.conflicts = FALSE)

test_that("get_race_column_names() works for expected names", {
  html <- read_html(test_path("data", "race_al_wc_dh.html.gz"))
  expect_equal(
    get_race_column_names(html),
    c("rank", "bib", "fis_code", "name", "brand", "birth_year", "nation",
      "time", "diff_time", "fis_points", "cup_points")
  )

  html <- read_html(test_path("data", "race_al_wc_gs.html.gz"))
  expect_equal(
    get_race_column_names(html),
    c("rank", "bib", "fis_code", "name", "brand", "birth_year", "nation",
      "run1", "run2", "total_time", "diff_time", "fis_points", "cup_points")
  )
})


test_that("get_race_column_names() works for unexpected names", {
  html <- read_html(test_path("data", "race_al_special_headers.html.gz"))
  expect_warning(
    expect_equal(
      get_race_column_names(html),
      c("rank", "bib", "fis_code", "something_other", "birth_year",
      "title1", "time", "diff_other", "fis_points", "cup_points")
    ),
    "fields unknown to fisdata"
  )
})


test_that("process_race_column() creates a column with NA of the right type", {
  data <- tibble(x = 1)
  expect_equal(process_race_column("new_col", data), NA_character_)
  expect_equal(process_race_column("rank", data), NA_integer_)
  expect_equal(process_race_column("cup_points", data), NA_real_)
  expect_equal(process_race_column("fis_points", data), NA_real_)
  expect_equal(process_race_column("time", data), hm(NA_character_))
  expect_equal(process_race_column("diff_time", data), hm(NA_character_))
  expect_equal(process_race_column("name", data), NA_character_)
})

library(stringr)
library(lubridate, warn.conflicts = FALSE)
library(tibble)
library(glue)

fd_opts <- paste0(
  "fisdata_",
  c("sector", "season", "gender", "category", "discipline", "active_only")
)

test_that("initial setup of options works", {
  opts <- options()
  # check that all options exist
  expect_setequal(str_subset(names(opts), "^fisdata_"), fd_opts)
  # check that they are all set to the appropriate values
  expect_in(opts[fd_opts[1:5]], "")
  expect_in(opts[fd_opts[6]], FALSE)
})


test_that("set_fisdata_defaults() works with valid inputs", {
  set_fisdata_defaults(sector = "AL")
  expect_equal(getOption("fisdata_sector"), "AL")

  set_fisdata_defaults(season = 2024)
  expect_equal(getOption("fisdata_season"), "2024")

  set_fisdata_defaults(season = "2020")
  expect_equal(getOption("fisdata_season"), "2020")

  set_fisdata_defaults(season = 2022.5)
  expect_equal(getOption("fisdata_season"), "2022")

  set_fisdata_defaults(gender = "M")
  expect_equal(getOption("fisdata_gender"), "M")

  set_fisdata_defaults(gender = "w")
  expect_equal(getOption("fisdata_gender"), "W")

  set_fisdata_defaults(gender = "F")
  expect_equal(getOption("fisdata_gender"), "W")

  set_fisdata_defaults(category = "WC")
  expect_equal(getOption("fisdata_category"), "WC")

  set_fisdata_defaults(category = "wsc")
  expect_equal(getOption("fisdata_category"), "WSC")

  set_fisdata_defaults(discipline = "gs")
  expect_equal(getOption("fisdata_discipline"), "GS")
})


test_that("set_fisdata_defaults() works with \"\"", {
  set_fisdata_defaults(sector = "")
  expect_equal(getOption("fisdata_sector"), "")

  set_fisdata_defaults(season = "")
  expect_equal(getOption("fisdata_season"), "")

  set_fisdata_defaults(gender = "")
  expect_equal(getOption("fisdata_gender"), "")

  set_fisdata_defaults(category = "")
  expect_equal(getOption("fisdata_category"), "")

  set_fisdata_defaults(discipline = "")
  expect_equal(getOption("fisdata_discipline"), "")
})


test_that("set_fisdata_defaults() works with reset = TRUE", {
  set_fisdata_defaults(sector = "CC", season = 2024, gender = "M",
                       category = "WC", discipline = "DH")
  set_fisdata_defaults(sector = "JP", reset = TRUE)
  expect_equal(getOption("fisdata_sector"), "JP")
  other_opts <- paste0("fisdata_",
                       c("season", "gender", "category", "discipline"))
  expect_in(options()[other_opts], "")
})


test_that("reset_fisdata_defaults() works", {
  set_fisdata_defaults(sector = "CC", season = 2024, gender = "M",
                       category = "WC", discipline = "DH", active_only = TRUE)
  reset_fisdata_defaults()
  opts <- options()
  expect_in(opts[fd_opts[1:5]], "")
  expect_in(opts[fd_opts[6]], FALSE)
})


test_that("set_fisdata_defaults() works with invalid inputs", {
  set_fisdata_defaults(sector = "CC", season = 2024, gender = "M",
                       category = "WC", discipline = "DH")

  expect_warning(set_fisdata_defaults(gender = "U"),
                 "'U' is not a valid gender")
  expect_equal(getOption("fisdata_gender"), "M")

  expect_warning(set_fisdata_defaults(season = "43A5"),
                 "'43A5' is not a valid season")
  expect_equal(getOption("fisdata_season"), "2024")

  expect_warning(set_fisdata_defaults(season = 1934),
                 "'1934' is not a valid season")
  expect_equal(getOption("fisdata_season"), "2024")

  in2years <- year(today()) + 2
  expect_warning(set_fisdata_defaults(season = in2years),
                 glue("'{in2years}' is not a valid season"))
  expect_equal(getOption("fisdata_season"), "2024")

  expect_warning(set_fisdata_defaults(active_only = "no"),
                 "'no' is not valid for active_only")
  expect_equal(getOption("fisdata_active_only"), FALSE)
})


test_that("set_fisdata_defaults() works with inputs that must be matched", {
  set_fisdata_defaults(sector = "para al")
  expect_equal(getOption("fisdata_sector"), "PAL")

  set_fisdata_defaults(category = "olympics")
  expect_equal(getOption("fisdata_category"), "OWG")

  set_fisdata_defaults(discipline = "bigair")
  expect_equal(getOption("fisdata_discipline"), "BA")
})


test_that("get_fisdata_defaults() works", {
  set_fisdata_defaults(sector = "CC", season = 2024, gender = "M",
                       category = "WC", discipline = "DH", active_only = TRUE)
  expect_equal(
    get_fisdata_defaults(),
    tibble(sector = "CC", season = "2024", gender = "M",
      category = "WC", discipline = "DH", active_only = TRUE)
  )

  reset_fisdata_defaults()
  expect_equal(
    get_fisdata_defaults(),
    tibble(sector = "", season = "", gender = "",
           category = "", discipline = "", active_only = FALSE)
  )
})


test_that("fd_def() works", {
  reset_fisdata_defaults()
  expect_equal(fd_def("sector"), "")
  expect_equal(fd_def("season"), "")
  expect_equal(fd_def("gender"), "")
  expect_equal(fd_def("category"), "")
  expect_equal(fd_def("discipline"), "")
  expect_equal(fd_def("active_only"), FALSE)

  set_fisdata_defaults(sector = "CC", season = 2024, gender = "M",
                       category = "WC", discipline = "DH", active_only = TRUE)
  expect_equal(fd_def("sector"), "CC")
  expect_equal(fd_def("season"), "2024")
  expect_equal(fd_def("gender"), "M")
  expect_equal(fd_def("category"), "WC")
  expect_equal(fd_def("discipline"), "DH")
  expect_equal(fd_def("active_only"), TRUE)

  expect_error(fd_def("badvalue"))
})


# reset all defaults to their initial state
reset_fisdata_defaults()


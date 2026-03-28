library(stringr)
library(lubridate, warn.conflicts = FALSE)
library(tibble)
library(glue)
library(withr)
library(jsonlite)

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


test_that('set_fisdata_defaults() works with ""', {
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
  set_fisdata_defaults(sector = "AL", season = 2024, gender = "M",
                       category = "WC", discipline = "DH", active_only = TRUE)
  set_fisdata_defaults(sector = "JP", reset = TRUE)
  expect_equal(getOption("fisdata_sector"), "JP")
  other_opts <- paste0("fisdata_",
                       c("season", "gender", "category", "discipline"))
  expect_in(options()[other_opts], "")
  expect_equal(getOption("fisdata_active_only"), FALSE)
})


test_that("set_fisdata_defaults() produces output", {
  expect_silent(
    set_fisdata_defaults(sector = "AL", season = 2024, gender = "M",
                         category = "WC", discipline = "DH", active_only = TRUE,
                         verbose = FALSE)
  )
  set_fisdata_defaults(sector = "AL", season = 2024, gender = "M",
                       category = "WC", discipline = "DH", active_only = TRUE,
                       verbose = TRUE) %>%
    expect_message("'sector'.*AL.*Alpine Skiing") %>%
    expect_message("'season'.*'2024'") %>%
    expect_message("'gender'.*'M'") %>%
    expect_message("'category'.*'WC'.*World Cup") %>%
    expect_message("'discipline'.*'DH'.*Downhill") %>%
    expect_message("'active_only'.*'TRUE'")
  expect_message(
    set_fisdata_defaults(reset = TRUE, verbose = TRUE),
    "All defaults have been reset to ''"
  )
  expect_message(
    set_fisdata_defaults(sector = "", verbose = TRUE),
    "'sector'.*set to ''"
  )
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

  set_fisdata_defaults(discipline = "bigair", sector = "Snowboard")
  expect_equal(getOption("fisdata_discipline"), "BA")
})


test_that("get_fisdata_defaults() works", {
  set_fisdata_defaults(sector = "AL", season = 2024, gender = "M",
                       category = "WC", discipline = "DH", active_only = TRUE)
  expect_equal(
    get_fisdata_defaults(),
    tibble(sector = "AL", season = "2024", gender = "M",
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

  set_fisdata_defaults(sector = "AL", season = 2024, gender = "M",
                       category = "WC", discipline = "DH", active_only = TRUE)
  expect_equal(fd_def("sector"), "AL")
  expect_equal(fd_def("season"), "2024")
  expect_equal(fd_def("gender"), "M")
  expect_equal(fd_def("category"), "WC")
  expect_equal(fd_def("discipline"), "DH")
  expect_equal(fd_def("active_only"), TRUE)

  expect_error(fd_def("badvalue"))
})


test_that("write_current_fisdata_defaults() works", {
  reset_fisdata_defaults()
  set_fisdata_defaults(sector = "AL", gender = "F", category = "WC")
  ref <- toJSON(
    list(sector = "AL", season = "", gender = "W", category = "WC",
         discipline = "", active_only = FALSE),
    auto_unbox = TRUE,
    pretty = TRUE
  )
  local_file("fisdata.json")
  expect_equal(write_current_fisdata_defaults("fisdata.json"), ref)
  expect_true(file.exists("fisdata.json"))
  expect_equal(paste(readLines("fisdata.json"), collapse = "\n"), ref,
               ignore_attr = TRUE)
})


test_that("write_current_fisdata_defaults() handles existing file", {
  local_file("fisdata.json")
  write_current_fisdata_defaults("fisdata.json")
  expect_error(write_current_fisdata_defaults("fisdata.json"),
               "The file fisdata.json exists.")
  expect_silent(write_current_fisdata_defaults("fisdata.json", overwrite = TRUE))
})


test_that("write_fisdata_defaults() works", {
  ref <- toJSON(
    list(sector = "CC", season = "", gender = "M", category = "WC",
         discipline = "", active_only = FALSE),
    auto_unbox = TRUE,
    pretty = TRUE
  )
  local_file("fisdata.json")
  expect_equal(
    write_fisdata_defaults("fisdata.json", sector = "CC", gender = "M", category = "WC"),
    ref
  )
  expect_true(file.exists("fisdata.json"))
  expect_equal(paste(readLines("fisdata.json"), collapse = "\n"), ref,
               ignore_attr = TRUE)
})


test_that("write_fisdata_defaults() handles existing file", {
  local_file("fisdata.json")
  write_fisdata_defaults("fisdata.json", sector = "CC", gender = "M")
  expect_error(write_fisdata_defaults("fisdata.json", sector = "CC", gender = "M"),
               "The file fisdata.json exists.")
  expect_silent(write_current_fisdata_defaults("fisdata.json", overwrite = TRUE))
})


test_that("write_fisdata_defaults() rejects NULL as default", {
  local_file("fisdata.json")
  expect_error(write_fisdata_defaults("fisdata.json", sector = "CC", discipline = NULL),
               "Defaults must no be NULL.*NULL: discipline")
  expect_false(file.exists("fisdata.json"))
})


test_that("read_fisdata_defaults() reads defaults without applying them", {
  local_file("fisdata.json")
  write_fisdata_defaults("fisdata.json", sector = "AL", season = "2024", gender = "W", 
                 category = "WC", discipline = "SL", active_only = TRUE)
  reset_fisdata_defaults()

  expect_equal(
    read_fisdata_defaults("fisdata.json", apply = FALSE, verbose = FALSE),
    tibble(sector = "AL", season = "2024", gender = "W", category = "WC",
           discipline = "SL", active_only = TRUE)
  )
  expect_equal(
    get_fisdata_defaults(),
    tibble(sector = "", season = "", gender = "",
           category = "", discipline = "", active_only = FALSE)
  )
})


test_that("read_fisdata_defaults() applies defaults", {
  local_file("fisdata.json")
  write_fisdata_defaults("fisdata.json", sector = "CC", season = "2025", gender = "M", 
                 category = "WC", discipline = "SP", active_only = TRUE)
  reset_fisdata_defaults()

  expect_equal(
    read_fisdata_defaults("fisdata.json", verbose = FALSE),
    tibble(sector = "CC", season = "2025", gender = "M",
           category = "WC", discipline = "SP", active_only = TRUE)
  )
  expect_equal(
    get_fisdata_defaults(),
    tibble(sector = "CC", season = "2025", gender = "M",
           category = "WC", discipline = "SP", active_only = TRUE)
  )
})


test_that("read_fisdata_defaults() handles invalid files", {
  local_file("fisdata.json")

  expect_error(read_fisdata_defaults("fisdata.json"), "does not exist")

  writeLines("{", "fisdata.json")
  expect_error(read_fisdata_defaults("fisdata.json"), "Failed to parse")

  writeLines(
    toJSON(
      list(sector = "AL", season = "2024", gender = "W", category = "WC",
           discipline = "SL"),
      auto_unbox = TRUE
    ),
    "fisdata.json"
  )
  expect_error(read_fisdata_defaults("fisdata.json"), "Some defaults have no value set: active_only")

  writeLines(
    toJSON(
      list(sector = c("AL", "CC"), season = "1940", gender = "W", category = "WC",
           discipline = "SL", active_only = TRUE),
      auto_unbox = TRUE
    ),
    "fisdata.json"
  )
  expect_error(read_fisdata_defaults("fisdata.json"), "contents.*not valid")

  writeLines(
    toJSON(
      list(sector = "AL", season = "1940", gender = "W", category = "WC",
           discipline = "SL", active_only = TRUE),
      auto_unbox = TRUE
    ),
    "fisdata.json"
  )
  expect_error(read_fisdata_defaults("fisdata.json"), "'1940' is not a valid season")
})


test_that("read_fisdata_defaults() creates output in the appropriate situations", {
  local_file("fisdata.json")
  write_fisdata_defaults("fisdata.json", sector = "CC", season = "2025", gender = "M", 
                 category = "WC", discipline = "SP", active_only = TRUE)
  
  expect_silent(read_fisdata_defaults("fisdata.json", apply = FALSE, verbose = FALSE))
  expect_silent(read_fisdata_defaults("fisdata.json", apply = TRUE, verbose = FALSE))
  read_fisdata_defaults("fisdata.json", apply = FALSE, verbose = TRUE) %>% 
    expect_message("contains the following defaults") %>% 
    expect_output("tibble.*sector +season +gender +category")
  read_fisdata_defaults("fisdata.json", apply = TRUE, verbose = TRUE) %>%
    expect_message("sector.*CC.*Cross-Country") %>%
    expect_message("season.*2025") %>%
    expect_message("gender.*M") %>%
    expect_message("category.*WC.*World Cup") %>%
    expect_message("discipline.*SP") %>%
    expect_message("active_only.*'TRUE'")
})

reset_fisdata_defaults()

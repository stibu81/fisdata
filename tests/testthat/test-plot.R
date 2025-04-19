library(vdiffr)
library(dplyr, warn.conflicts = FALSE)
library(stringr)

results <- tribble(
~athlete,        ~date, ~age,           ~place, ~nation, ~category,    ~discipline, ~rank, ~cup_points,
    "OM", "2020-12-20", 23.2,     "Alta Badia",   "ITA",      "WC", "Giant Slalom",    4L,          50,
    "OM", "2019-01-12", 21.3,      "Adelboden",   "SUI",      "WC", "Giant Slalom",   10L,          26,
    "OM", "2018-03-17", 20.4,            "Are",   "SWE",      "WC", "Giant Slalom",   15L,          16,
    "OM", "2022-03-12", 24.4,  "Kranjska Gora",   "SLO",      "WC", "Giant Slalom",    2L,          80,
    "OM", "2022-03-13", 24.4,  "Kranjska Gora",   "SLO",      "WC", "Giant Slalom",    3L,          60,
    "OM", "2021-03-13", 23.4,  "Kranjska Gora",   "SLO",      "WC", "Giant Slalom",    1L,         100,
    "OM", "2021-02-28", 23.4,         "Bansko",   "BUL",      "WC", "Giant Slalom",    2L,          80,
    "OM", "2023-01-07", 25.2,      "Adelboden",   "SUI",      "WC", "Giant Slalom",    1L,         100,
    "KH", "2021-01-26", 26.6,     "Schladming",   "AUT",      "WC",       "Slalom",   11L,          24,
    "KH", "2019-03-17", 24.7,         "Soldeu",   "AND",      "WC",       "Slalom",    5L,          45,
    "KH", "2016-12-11", 22.4,    "Val d'Isère",   "FRA",      "WC",       "Slalom",    1L,         100,
    "KH", "2020-01-12", 25.5,      "Adelboden",   "SUI",      "WC",       "Slalom",    2L,          80,
    "KH", "2016-01-17", 21.5,         "Wengen",   "SUI",      "WC",       "Slalom",    1L,         100,
    "KH", "2018-12-08", 24.4,    "Val d'Isere",   "FRA",      "WC", "Giant Slalom",    2L,          80,
    "KH", "2014-10-26", 20.3,        "Soelden",   "AUT",      "WC", "Giant Slalom",    NA,          NA,
    "KH", "2021-02-28", 26.7,         "Bansko",   "BUL",      "WC", "Giant Slalom",    9L,          29,
    "KH", "2020-12-07", 26.4, "Santa Caterina",   "ITA",      "WC", "Giant Slalom",   12L,          22,
    "KH", "2021-01-09", 26.5,      "Adelboden",   "SUI",      "WC", "Giant Slalom",   27L,           4,
    "HM", "2019-01-26", 29.9,     "Kitzbuehel",   "AUT",      "WC",       "Slalom",    2L,          80,
    "HM", "2014-03-09", 25.0,  "Kranjska Gora",   "SLO",      "WC",       "Slalom",    5L,          45,
    "HM", "2008-12-22", 19.8,     "Alta Badia",   "ITA",      "WC",       "Slalom",    7L,          36,
    "HM", "2011-01-09", 21.9,      "Adelboden",   "SUI",      "WC",       "Slalom",    2L,          80,
    "HM", "2008-01-20", 18.9,     "Kitzbuehel",   "AUT",      "WC",       "Slalom",    NA,          NA,
    "HM", "2012-02-26", 23.0,  "Crans Montana",   "SUI",      "WC", "Giant Slalom",    2L,          80,
    "HM", "2017-12-03", 28.8,   "Beaver Creek",   "USA",      "WC", "Giant Slalom",    1L,         100,
    "HM", "2018-03-03", 29.0,  "Kranjska Gora",   "SLO",      "WC", "Giant Slalom",    1L,         100,
    "HM", "2014-12-21", 25.8,     "Alta Badia",   "ITA",      "WC", "Giant Slalom",    1L,         100,
    "HM", "2011-12-04", 22.8,   "Beaver Creek",   "USA",      "WC", "Giant Slalom",    1L,         100,
    "OM", "2025-02-14", 27.4,       "Saalbach",   "AUT",     "WSC", "Giant Slalom",    4L,          NA,
    "OM", "2021-02-19", 23.4,        "Cortina",   "ITA",     "WSC", "Giant Slalom",    NA,          NA,
    "KH", "2017-02-19", 22.6,     "St. Moritz",   "SUI",     "WSC",       "Slalom",    4L,          NA,
    "KH", "2013-02-17", 18.6,     "Schladming",   "AUT",     "WSC",       "Slalom",    NA,          NA,
    "KH", "2019-02-15", 24.6,            "Are",   "SWE",     "WSC", "Giant Slalom",    1L,          NA,
    "KH", "2021-02-19", 26.6,        "Cortina",   "ITA",     "WSC", "Giant Slalom",    9L,          NA,
    "HM", "2013-02-17", 24.0,     "Schladming",   "AUT",     "WSC",       "Slalom",    1L,          NA,
    "HM", "2019-02-17", 30.0,            "Are",   "SWE",     "WSC",       "Slalom",    1L,          NA,
    "HM", "2019-02-15", 30.0,            "Are",   "SWE",     "WSC", "Giant Slalom",    2L,          NA,
    "HM", "2013-02-15", 24.0,     "Schladming",   "AUT",     "WSC", "Giant Slalom",    2L,          NA
  ) %>%
  # replace abbreviations by the full values
  mutate(
    athlete = str_replace_all(athlete,
                              c("OM" = "Odermatt Marco",
                                "KH" = "Kristoffersen Henrik",
                                "HM" = "Hirscher Marcel")),
    category = str_replace_all(category,
                               c("WC" = "World Cup",
                                 "WSC" = "World Championship"))
  ) %>%
  mutate(date = as.Date(date)) %>%
  mutate(sector = "AL", .after = "nation") %>%
  mutate(fis_points = 0, .after = "rank") %>%
  mutate(race_id = as.character(1:n()), .after = last_col())


test_that("plot_rank_summary() works", {
  expect_doppelganger(
    "plot_rank_summary() with default settings",
    plot_rank_summary(results, interactive = FALSE)
  )
  expect_doppelganger(
    "plot_rank_summary() by category",
    plot_rank_summary(results, by = "category", interactive = FALSE)
  )
  expect_doppelganger(
    "plot_rank_summary() by discipline",
    plot_rank_summary(results, by = "discipline", interactive = FALSE)
  )
  expect_doppelganger(
    "plot_rank_summary() without grouping",
    plot_rank_summary(results, by = NA, interactive = FALSE)
  )
  expect_doppelganger(
    "plot_rank_summary() for different positions",
    plot_rank_summary(results, pos = c(1, 5, 10, 20), interactive = FALSE)
  )
})


test_that("plot_rank_summary() errors work", {
  results <- tibble(
    athlete = paste("Athlete", 1:10)
  )
  expect_error(
    plot_rank_summary(results),
    "Only up to 9 athletes are supported, you provided 10"
  )
})


test_that("plot_results_summary() works", {
  expect_doppelganger(
    "plot_results_summary() with default settings",
    plot_results_summary(results, interactive = FALSE)
  )
  expect_doppelganger(
    "plot_results_summary() by category",
    plot_results_summary(results, by = "category", interactive = FALSE)
  )
  expect_doppelganger(
    "plot_results_summary() by discipline",
    plot_results_summary(results, by = "discipline", interactive = FALSE)
  )

  expect_doppelganger(
    "plot_results_summary() for races",
    plot_results_summary(results, variable = "races", interactive = FALSE)
  )
  expect_doppelganger(
    "plot_results_summary() for victories",
    plot_results_summary(results, variable = "victories", interactive = FALSE)
  )
  expect_doppelganger(
    "plot_results_summary() for podiums",
    plot_results_summary(results, variable = "podiums", interactive = FALSE)
  )
  expect_doppelganger(
    "plot_results_summary() for dnf",
    plot_results_summary(results, variable = "dnf", interactive = FALSE)
  )

  expect_doppelganger(
    "plot_results_summary() for a given position",
    plot_results_summary(results, variable = "position", pos = 2,
                         interactive = FALSE)
  )
  expect_doppelganger(
    "plot_results_summary() for a range of positions",
    plot_results_summary(results, variable = "top", pos = 4,
                         interactive = FALSE)
  )

  expect_doppelganger(
    "plot_results_summary() for points with realtive scale",
    plot_results_summary(results, variable = "points", relative = TRUE,
                         interactive = FALSE)
  )
  expect_doppelganger(
    "plot_results_summary() for podiums with realtive scale",
    plot_results_summary(results, variable = "podiums", relative = TRUE,
                         interactive = FALSE)
  )
  expect_doppelganger(
    "plot_results_summary() for races should ignore realtive scale",
    plot_results_summary(results, variable = "races", relative = TRUE,
                         interactive = FALSE)
  )
})


test_that("plot_results_summary() errors work", {
  results <- tibble(
    athlete = paste("Athlete", 1:10)
  )
  expect_error(
    plot_results_summary(results),
    "Only up to 9 athletes are supported, you provided 10"
  )
})


test_that("plot_ranks_over_time() works", {
  expect_doppelganger(
    "plot_ranks_over_time() with defaults for a single athlete",
    results %>%
      filter(athlete == "Hirscher Marcel") %>%
      plot_ranks_over_time(interactive = FALSE)
  )
  expect_doppelganger(
    "plot_ranks_over_time() by athlete",
    results %>%
      plot_ranks_over_time(by = "athlete", interactive = FALSE)
  )
  expect_doppelganger(
    "plot_ranks_over_time() by category for a single athlete",
    results %>%
      filter(athlete == "Hirscher Marcel") %>%
      plot_ranks_over_time(by = "category", interactive = FALSE)
  )
  expect_doppelganger(
    "plot_ranks_over_time() by discipline for a single athlete",
    results %>%
      filter(athlete == "Hirscher Marcel") %>%
      plot_ranks_over_time(by = "discipline", interactive = FALSE)
  )
  expect_doppelganger(
    "plot_ranks_over_time() without grouping for a single athlete",
      results %>%
        filter(athlete == "Hirscher Marcel") %>%
        plot_ranks_over_time(by = c(), interactive = FALSE)
  )
  expect_doppelganger(
    "plot_ranks_over_time() for different positions",
    plot_ranks_over_time(results, by = "athlete", pos = c(1, 5, 10, 20),
                         interactive = FALSE)
  )

  # Needs more! age, cumulative, bars
  expect_doppelganger(
    "plot_ranks_over_time() by athlete with age on the x-asix",
    results %>%
      plot_ranks_over_time(by = "athlete", time = "age", interactive = FALSE)
  )
  expect_doppelganger(
    "plot_ranks_over_time() by athlete with cumulative counts",
    results %>%
      plot_ranks_over_time(by = "athlete", cumulative = TRUE,
                           interactive = FALSE)
  )
  expect_doppelganger(
    "plot_ranks_over_time() by athlete as a bar plot",
    results %>%
      plot_ranks_over_time(by = "athlete", type = "bars", interactive = FALSE)
  )
})


test_that("plot_ranks_over_time() errors work", {
  results <- tibble(
    athlete = paste("Athlete", 1:10)
  )
  expect_error(
    plot_ranks_over_time(results),
    "Multiple athletes are only supported when by = 'athlete'"
  )
  expect_error(
    plot_ranks_over_time(results, by = "athlete"),
    "Only up to 9 athletes are supported, you provided 10"
  )
})

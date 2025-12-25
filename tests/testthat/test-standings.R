library(tibble)
library(stringr)
fisdata:::clear_cache()

test_that("get_standings_url() works with valid inputs", {
  expect_equal(
    get_standings_url(sector = "AL"),
    paste0("https://www.fis-ski.com/DB/general/cup-standings.html?",
           "sectorcode=AL&seasoncode=&cupcode=&gendercode=")
  )
  expect_equal(
    get_standings_url(sector = "JP", season = 2023,
                     category = "WC", gender = "W"),
    paste0("https://www.fis-ski.com/DB/general/cup-standings.html?",
           "sectorcode=JP&seasoncode=2023&cupcode=WC&gendercode=W")
  )
  expect_equal(
    get_standings_url(sector = "AL", category = "WC", type = "start-list"),
    paste0("https://www.fis-ski.com/DB/general/cup-standings.html?",
           "sectorcode=AL&seasoncode=&cupcode=WCSL&gendercode=")
  )
  expect_equal(
    get_standings_url(sector = "AL", category = "WC", type = "nations"),
    paste0("https://www.fis-ski.com/DB/general/cup-standings.html?",
           "sectorcode=AL&seasoncode=&cupcode=NC-WC&gendercode=")
  )
  expect_equal(
    get_standings_url(sector = "AL", category = "WC",
                      gender = "A", type = "nations"),
    paste0("https://www.fis-ski.com/DB/general/cup-standings.html?",
           "sectorcode=AL&seasoncode=&cupcode=NC-WC&gendercode=A")
  )
})


test_that("get_standings_url() works with inputs that must be matched", {
  expect_equal(
    get_standings_url(sector = "jumping", season = 2023,
                     category = "Wcup", gender = "W"),
    paste0("https://www.fis-ski.com/DB/general/cup-standings.html?",
           "sectorcode=JP&seasoncode=2023&cupcode=WC&gendercode=W")
  )
  expect_equal(
    get_standings_url(sector = "alpine", category = "wrldcp",
                      type = "nations"),
    paste0("https://www.fis-ski.com/DB/general/cup-standings.html?",
           "sectorcode=AL&seasoncode=&cupcode=NC-WC&gendercode=")
  )
})


test_that("get_standings_url() errors work", {
  expect_error(
    get_standings_url(),
    "'sector' must not be empty."
  )
  expect_error(
    get_standings_url(sector = "AL", gender = "A"),
    "gender 'A' is only supported for nations cups."
  )
})


test_that("query_standings() works for alpine world cup", {
  local_mocked_bindings(
    get_standings_url = function(...) test_path("data", "standings_wc_al_2025.html.gz")
  )
  wc_al_2025 <- query_standings(sector = "AL")

  expect_s3_class(wc_al_2025, "tbl_df")

  expected_names <- c("sector", "athlete", "brand", "nation",
                      paste(rep(c("all", "dh", "gs", "sg", "sl"), each = 2),
                            rep(c("rank", "points"), 4),
                            sep = "_"),
                      "competitor_id")
  expect_named(wc_al_2025, expected_names)

  expected_types <- c(rep("character", 4), rep("integer", 10), "character")
  for (i in seq_along(expected_names)) {
    expect_type(wc_al_2025[[!!expected_names[i]]], expected_types[i])
  }

  expect_in(wc_al_2025$sector, "AL")
  expect_in(wc_al_2025$nation, nations$code)
  for (col in str_subset(expected_names, "_rank$")) {
    expect_in(wc_al_2025[[!!col]], c(NA_integer_, 1:nrow(wc_al_2025)))
  }
  for (col in str_subset(expected_names, "_points$")) {
    expect_in(
      wc_al_2025[[!!col]],
      c(NA_integer_, 1:max(wc_al_2025[[!!col]], na.rm = TRUE))
    )
  }

  expect_equal(attr(wc_al_2025, "url"), get_standings_url())

  expect_snapshot(print(wc_al_2025, width = Inf, n = Inf))
})


test_that("query_standings() works for nations cup", {
  local_mocked_bindings(
    get_standings_url = function(...) test_path("data", "standings_wc_al_2025_nations.html.gz")
  )
  wc_al_2025_nations <- query_standings(sector = "AL", type = "nations")

  expect_s3_class(wc_al_2025_nations, "tbl_df")

  expected_names <- c("sector", "athlete", "nation",
                      paste(rep(c("all", "gs", "sl", "dh", "sg"), each = 2),
                            rep(c("rank", "points"), 4),
                            sep = "_"))
  expect_named(wc_al_2025_nations, expected_names)

  expected_types <- c(rep("character", 3), rep("integer", 10))
  for (i in seq_along(expected_names)) {
    expect_type(wc_al_2025_nations[[!!expected_names[i]]], expected_types[i])
  }

  expect_in(wc_al_2025_nations$sector, "AL")
  expect_in(wc_al_2025_nations$nation, nations$code)
  for (col in str_subset(expected_names, "_rank$")) {
    expect_in(wc_al_2025_nations[[!!col]], c(NA_integer_, 1:nrow(wc_al_2025_nations)))
  }
  for (col in str_subset(expected_names, "_points$")) {
    expect_in(
      wc_al_2025_nations[[!!col]],
      c(NA_integer_, 1:max(wc_al_2025_nations[[!!col]], na.rm = TRUE))
    )
  }

  expect_equal(attr(wc_al_2025_nations, "url"), get_standings_url())

  expect_snapshot(print(wc_al_2025_nations, width = Inf, n = Inf))
})


test_that("query_standings() works for empty result", {
  local_mocked_bindings(
    get_standings_url = function(...) test_path("data", "standings_empty.html.gz")
  )
  empty <- query_standings(sector = "AL", season = 2050)

  expect_s3_class(empty, "tbl_df")
  expect_equal(nrow(empty), 0)

  expected_names <- c("sector", "athlete", "brand", "nation", "competitor_id")
  expect_named(empty, expected_names)

  expected_types <- rep("character", 5)
  for (i in seq_along(expected_names)) {
    expect_type(empty[[!!expected_names[i]]], expected_types[i])
  }

  expect_equal(attr(empty, "url"), get_standings_url())
})


test_that("get_athlete_standings_url() works with valid inputs", {
  odermatt <- tibble(
      name = "Odermatt Marco",
      sector = "AL",
      competitor_id = "190231"
    )
  expect_equal(
    get_athlete_standings_url(athlete = odermatt),
    paste0("https://www.fis-ski.com/DB/general/athlete-biography.html?",
           "sectorcode=AL&competitorid=190231&type=cups&cupcode=")
  )
  expect_equal(
    get_athlete_standings_url(athlete = odermatt,
                              category = "WC",
                              type = "start-list"),
    paste0("https://www.fis-ski.com/DB/general/athlete-biography.html?",
           "sectorcode=AL&competitorid=190231&type=cups&cupcode=WCSL")
  )
})


test_that("get_standings_url() errors work", {
  odermatt <- tibble(
      name = "Odermatt Marco",
      sector = "AL",
      competitor_id = "190231"
    )
  expect_error(
    get_athlete_standings_url(athlete = odermatt, type = "nations"),
    "type = 'nations' is not supported for athlete standings"
  )
})


test_that("query_standings() works for alpine skiing athlete", {
  local_mocked_bindings(
    get_athlete_standings_url = function(...) test_path("data", "athlete_standings_odermatt.html.gz")
  )
  odermatt <- tibble(
      name = "Odermatt Marco",
      sector = "AL",
      competitor_id = "190231"
    )
  standings_odermatt <- query_standings(athlete = odermatt)

  expect_s3_class(standings_odermatt, "tbl_df")

  expected_names <- c("athlete", "sector", "category", "season",
                      paste(rep(c("all", "dh", "gs", "sg", "ac"), each = 2),
                            rep(c("rank", "points"), 4),
                            sep = "_"))
  expect_named(standings_odermatt, expected_names)

  expected_types <- c(rep("character", 3), rep("integer", 11))
  for (i in seq_along(expected_names)) {
    expect_type(standings_odermatt[[!!expected_names[i]]], expected_types[i])
  }

  expect_in(standings_odermatt$athlete, "Odermatt Marco")
  expect_in(standings_odermatt$sector, "AL")
  expect_in(standings_odermatt$category, "WC")
  expect_equal(standings_odermatt$season, 2025:2017)
  for (col in str_subset(expected_names, "_(rank|points)$")) {
    expect_in(
      standings_odermatt[[!!col]],
      c(NA_integer_, 1:max(standings_odermatt[[!!col]], na.rm = TRUE)))
  }

  expect_equal(attr(standings_odermatt, "url"), get_athlete_standings_url())

  expect_snapshot(print(standings_odermatt, width = Inf, n = Inf))
})


test_that("query_standings() with athlete works for empty result", {
  local_mocked_bindings(
    get_athlete_standings_url = function(...) test_path("data", "athlete_standings_empty.html.gz")
  )
  odermatt <- tibble(
      name = "Odermatt Marco",
      sector = "AL",
      competitor_id = "190231"
    )
  empty <- query_standings(athlete = odermatt)

  expect_s3_class(empty, "tbl_df")
  expect_equal(nrow(empty), 0)

  expected_names <- c("athlete", "sector", "category", "season")
  expect_named(empty, expected_names)

  expected_types <- c(rep("character", 3), "integer")
  for (i in seq_along(expected_names)) {
    expect_type(empty[[!!expected_names[i]]], expected_types[i])
  }

  expect_equal(attr(empty, "url"), get_athlete_standings_url())
})


test_that("query_standings() with athlete in first position works", {
  local_mocked_bindings(
    get_athlete_standings_url = function(...) test_path("data", "athlete_standings_odermatt.html.gz")
  )
  odermatt <- tibble(
      name = "Odermatt Marco",
      sector = "AL",
      competitor_id = "190231"
    )
  standings_odermatt <- query_standings(odermatt)
  expect_equal(standings_odermatt, query_standings(athlete = odermatt))
})

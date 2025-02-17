library(dplyr, warn.conflicts = FALSE)

test_that("get_races_url() works with valid inputs", {
  cuche <- tibble(name = "Cuche Didier",
                  sector = "AL",
                  race_id = "59312")
  expect_equal(
    get_races_url(cuche),
    paste0("https://www.fis-ski.com/DB/general/results.html?sectorcode=AL",
           "&raceid=59312")
  )
})


test_that("ensure_one_result() works", {
  cuche2 <- tibble(name = "Cuche Didier",
                  sector = "AL",
                  place = "Kitzbuehel",
                  discipline = c("Downhill", "Super G"),
                  race_id = c("59312", "59311"))
  expect_equal(ensure_one_result(cuche2), cuche2[1, ]) %>%
    expect_warning("Multiple results.*Downhill, Kitzbuehel")
  expect_equal(ensure_one_result(cuche2[1, ]), cuche2[1, ]) %>%
    expect_silent()
  expect_error(ensure_one_result(cuche2[integer(0), ]),
               "No result was passed")
})


test_that("query_race() works for an alpline skiing world cup race", {
  local_mocked_bindings(
    get_races_url = function(...) test_path("data", "race_al_wc_dh.html.gz")
  )
  result <- tibble(athlete = "Odermatt Marco",
                   place = "Wengen",
                   sector = "AL",
                   race_id = "122808")
  wengen_dh <- query_race(result)

  expect_s3_class(wengen_dh, "tbl_df")

  expected_names <- c("rank", "bib", "fis_code", "name", "brand",
                      "birth_year", "nation", "time", "diff_time",
                      "fis_points", "cup_points")
  expect_named(wengen_dh, expected_names)

  expected_types <- c("integer", "integer", "character", "character",
                      "character", "integer", "character",
                      "Period", "Period", "double", "double")
  for (i in seq_along(expected_types)) {
    if (expected_types[i] == "Period") {
      expect_s4_class(wengen_dh[[expected_names[i]]], expected_types[i])
    } else {
      expect_type(wengen_dh[[expected_names[i]]], expected_types[i])
    }
  }

  expect_in(wengen_dh$rank, 1:nrow(wengen_dh))
  expect_in(diff(wengen_dh$rank), 0:2)
  expect_in(wengen_dh$bib, 1:max(wengen_dh$bib))
  expect_match(wengen_dh$fis_code, "^\\d+$")
  expect_in(wengen_dh$birth_year, 1900:2100)
  expect_in(wengen_dh$nation, nations$code)
  expect_gte(min(wengen_dh$time), 0)
  expect_gte(min(wengen_dh$diff_time), 0)
  expect_lte(
    max(
      abs(wengen_dh$time[-1] - wengen_dh$time[1] - wengen_dh$diff_time[-1])
    ),
    1e-12
  )
  expect_gte(min(wengen_dh$fis_points), 0)
  expect_gte(min(diff(wengen_dh$fis_points)), 0)
  expect_in(wengen_dh$cup_points, 0:100)
  expect_in(-diff(wengen_dh$cup_points), 0:20)

  expect_equal(attr(wengen_dh, "url"), get_races_url())

  expect_snapshot(print(wengen_dh, width = Inf, n = Inf))
})


test_that(
  "query_race() works for an alpline skiing world championships race",
  {
    local_mocked_bindings(
      get_races_url = function(...) test_path("data", "race_al_wsc_dh.html.gz")
    )
    result <- tibble(athlete = "Odermatt Marco",
                     place = "Courchevel Meribel",
                     sector = "AL",
                     race_id = "114189")
    wsc_dh <- query_race(result)

    expect_s3_class(wsc_dh, "tbl_df")

    expected_names <- c("rank", "bib", "fis_code", "name", "brand",
                        "birth_year", "nation", "time", "diff_time",
                        "fis_points", "cup_points")
    expect_named(wsc_dh, expected_names)

    expected_types <- c("integer", "integer", "character", "character",
                        "character", "integer", "character",
                        "Period", "Period", "double", "double")
    for (i in seq_along(expected_types)) {
      if (expected_types[i] == "Period") {
        expect_s4_class(wsc_dh[[expected_names[i]]], expected_types[i])
      } else {
        expect_type(wsc_dh[[expected_names[i]]], expected_types[i])
      }
    }

    expect_in(wsc_dh$rank, 1:nrow(wsc_dh))
    expect_in(diff(wsc_dh$rank), 0:2)
    expect_in(wsc_dh$bib, 1:max(wsc_dh$bib))
    expect_match(wsc_dh$fis_code, "^\\d+$")
    expect_in(wsc_dh$birth_year, 1900:2100)
    expect_in(wsc_dh$nation, nations$code)
    expect_gte(min(wsc_dh$time), 0)
    expect_gte(min(wsc_dh$diff_time), 0)
    expect_lte(
      max(
        abs(wsc_dh$time[-1] - wsc_dh$time[1] - wsc_dh$diff_time[-1])
      ),
      1e-12
    )
    expect_gte(min(wsc_dh$fis_points), 0)
    expect_gte(min(diff(wsc_dh$fis_points)), 0)
    expect_in(wsc_dh$cup_points, NA_real_)

    expect_equal(attr(wsc_dh, "url"), get_races_url())

    expect_snapshot(print(wsc_dh, width = Inf, n = Inf))
  }
)


test_that("query_race() works for an alpline skiing world cup race", {
  local_mocked_bindings(
    get_races_url = function(...) test_path("data", "race_al_tra.html.gz")
  )
  result <- tibble(athlete = "Odermatt Marco",
                   place = "Wengen",
                   sector = "AL",
                   race_id = "122805")
  wengen_training <- query_race(result)

  expect_s3_class(wengen_training, "tbl_df")

  expected_names <- c("rank", "bib", "fis_code", "name", "brand",
                      "birth_year", "nation", "time", "diff_time",
                      "fis_points", "cup_points")
  expect_named(wengen_training, expected_names)

  expected_types <- c("integer", "integer", "character", "character",
                      "character", "integer", "character",
                      "Period", "Period", "double", "double")
  for (i in seq_along(expected_types)) {
    if (expected_types[i] == "Period") {
      expect_s4_class(wengen_training[[expected_names[i]]], expected_types[i])
    } else {
      expect_type(wengen_training[[expected_names[i]]], expected_types[i])
    }
  }

  expect_in(wengen_training$rank, 1:nrow(wengen_training))
  expect_in(diff(wengen_training$rank), 0:2)
  expect_in(wengen_training$bib, 1:max(wengen_training$bib))
  expect_match(wengen_training$fis_code, "^\\d+$")
  expect_in(wengen_training$birth_year, 1900:2100)
  expect_in(wengen_training$nation, nations$code)
  expect_gte(min(wengen_training$time), 0)
  expect_gte(min(wengen_training$diff_time), 0)
  expect_lte(
    max(
      abs(wengen_training$time[-1] - wengen_training$time[1] - wengen_training$diff_time[-1])
    ),
    1e-12
  )
  expect_in(wengen_training$fis_points, NA_real_)
  expect_in(wengen_training$cup_points, NA_real_)

  expect_equal(attr(wengen_training, "url"), get_races_url())

  expect_snapshot(print(wengen_training, width = Inf, n = Inf))
})


test_that("query_race() works for empty result", {
  local_mocked_bindings(
    get_races_url = function(...) test_path("data", "race_empty.html.gz")
  )
  result <- tibble(athlete = "Odermatt Marco",
                   sector = "AL",
                   race_id = "")
  empty <- query_race(result)

  expect_s3_class(empty, "tbl_df")

  expected_names <- c("rank", "bib", "fis_code", "name", "brand",
                      "birth_year", "nation", "time", "diff_time",
                      "fis_points", "cup_points")
  expect_named(empty, expected_names)

  expected_types <- c("integer", "integer", "character", "character",
                      "character", "integer", "character",
                      "Period", "Period", "double", "double")
  for (i in seq_along(expected_types)) {
    if (expected_types[i] == "Period") {
      expect_s4_class(empty[[expected_names[i]]], expected_types[i])
    } else {
      expect_type(empty[[expected_names[i]]], expected_types[i])
    }
  }

  expect_equal(attr(empty, "url"), get_races_url())
})


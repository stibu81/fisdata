library(dplyr, warn.conflicts = FALSE)
library(withr)

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


test_that("query_race() works for an alpine skiing world cup race", {
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
  "query_race() works for an alpine skiing world cup race with 2 runs",
  # a race with two runs has different columns than a race with 1 run
  {
    local_mocked_bindings(
      get_races_url = function(...) test_path("data", "race_al_wc_gs.html.gz")
    )
    result <- tibble(athlete = "Odermatt Marco",
                     place = "Adelboden",
                     sector = "AL",
                     race_id = "122802")
    chuenis_gs <- query_race(result)

    expect_s3_class(chuenis_gs, "tbl_df")

    expected_names <- c("rank", "bib", "fis_code", "name", "brand",
                        "birth_year", "nation", "run1", "run2", "total_time",
                        "diff_time", "fis_points", "cup_points")
    expect_named(chuenis_gs, expected_names)

    expected_types <- c("integer", "integer", "character", "character",
                        "character", "integer", "character",
                        rep("Period", 4), "double", "double")
    for (i in seq_along(expected_types)) {
      if (expected_types[i] == "Period") {
        expect_s4_class(chuenis_gs[[expected_names[i]]], expected_types[i])
      } else {
        expect_type(chuenis_gs[[expected_names[i]]], expected_types[i])
      }
    }

    expect_in(chuenis_gs$rank, 1:nrow(chuenis_gs))
    expect_in(diff(chuenis_gs$rank), 0:3)
    expect_in(chuenis_gs$bib, 1:max(chuenis_gs$bib))
    expect_match(chuenis_gs$fis_code, "^\\d+$")
    expect_in(chuenis_gs$birth_year, 1900:2100)
    expect_in(chuenis_gs$nation, nations$code)
    expect_gte(min(chuenis_gs$run1), 0)
    expect_gte(min(chuenis_gs$run2), 0)
    expect_equal(chuenis_gs$run1 + chuenis_gs$run2, chuenis_gs$total_time)
    expect_gte(min(chuenis_gs$diff_time), 0)
    expect_lte(
      max(
        abs(chuenis_gs$total_time[-1] - chuenis_gs$total_time[1] -
              chuenis_gs$diff_time[-1])
      ),
      1e-12
    )
    expect_gte(min(chuenis_gs$fis_points), 0)
    expect_gte(min(diff(chuenis_gs$fis_points)), 0)
    expect_in(chuenis_gs$cup_points, 0:100)
    expect_in(-diff(chuenis_gs$cup_points), 0:20)

    expect_equal(attr(chuenis_gs, "url"), get_races_url())

    expect_snapshot(print(chuenis_gs, width = Inf, n = Inf))
  }
)


test_that("query_race() works for an alpine skiing parallel race", {
  # parallel races have no time columns
  local_mocked_bindings(
    get_races_url = function(...) test_path("data", "race_al_wc_par.html.gz")
  )
  result <- tibble(athlete = "Meillard Loic",
                   place = "Chamonix",
                   sector = "AL",
                   race_id = "100149")
  chamonix_par <- query_race(result)

  expect_s3_class(chamonix_par, "tbl_df")

  expected_names <- c("rank", "bib", "fis_code", "name",
                      "birth_year", "nation", "cup_points")
  expect_named(chamonix_par, expected_names)

  expected_types <- c("integer", "integer", "character", "character",
                      "integer", "character", "double")
  for (i in seq_along(expected_types)) {
    expect_type(chamonix_par[[expected_names[i]]], expected_types[i])
  }

  expect_in(chamonix_par$rank, 1:nrow(chamonix_par))
  expect_in(diff(chamonix_par$rank), 0:2)
  expect_in(chamonix_par$bib, 1:max(chamonix_par$bib))
  expect_match(chamonix_par$fis_code, "^\\d+$")
  expect_in(chamonix_par$birth_year, 1900:2100)
  expect_in(chamonix_par$nation, nations$code)
  expect_in(chamonix_par$cup_points, 0:100)
  expect_in(-diff(chamonix_par$cup_points), 0:20)

  expect_equal(attr(chamonix_par, "url"), get_races_url())

  expect_snapshot(print(chamonix_par, width = Inf, n = Inf))
})


test_that(
  "query_race() works for an alpine skiing world championships race",
  # brand and cup_points are missing for world cup races
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

    expected_names <- c("rank", "bib", "fis_code", "name",
                        "birth_year", "nation", "time", "diff_time",
                        "fis_points")
    expect_named(wsc_dh, expected_names)

    expected_types <- c("integer", "integer", "character",
                        "character", "integer", "character",
                        "Period", "Period", "double")
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

    expect_equal(attr(wsc_dh, "url"), get_races_url())

    expect_snapshot(print(wsc_dh, width = Inf, n = Inf))
  }
)


test_that("query_race() works for an alpine skiing downhill training", {
  # fis_points and cup_points are missing for a training
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
                      "birth_year", "nation", "time", "diff_time")
  expect_named(wengen_training, expected_names)

  expected_types <- c("integer", "integer", "character", "character",
                      "character", "integer", "character",
                      "Period", "Period")
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
      abs(wengen_training$time[-1] - wengen_training$time[1] -
            wengen_training$diff_time[-1])
    ),
    1e-12
  )

  expect_equal(attr(wengen_training, "url"), get_races_url())

  expect_snapshot(print(wengen_training, width = Inf, n = Inf))
})


test_that("query_race() works for a cross-country world cup race", {
  # similar to AL, brand and cup_points are missing, times over 1 hour
  local_mocked_bindings(
    get_races_url = function(...) test_path("data", "race_cc_50km.html.gz")
  )
  result <- tibble(athlete = "Cologna Dario",
                   place = "Oslo",
                   sector = "CC",
                   race_id = "29847")
  oslo_cc <- query_race(result)

  expect_s3_class(oslo_cc, "tbl_df")

  expected_names <- c("rank", "bib", "fis_code", "name", "birth_year",
                      "nation", "time", "diff_time", "fis_points")
  expect_named(oslo_cc, expected_names)

  expected_types <- c("integer", "integer", "character", "character",
                      "integer", "character",
                      "Period", "Period", "double")
  for (i in seq_along(expected_types)) {
    if (expected_types[i] == "Period") {
      expect_s4_class(oslo_cc[[expected_names[i]]], expected_types[i])
    } else {
      expect_type(oslo_cc[[expected_names[i]]], expected_types[i])
    }
  }

  expect_in(oslo_cc$rank, 1:nrow(oslo_cc))
  expect_in(diff(oslo_cc$rank), 0:2)
  expect_in(oslo_cc$bib, 1:max(oslo_cc$bib))
  expect_match(oslo_cc$fis_code, "^\\d+$")
  expect_in(oslo_cc$birth_year, 1900:2100)
  expect_in(oslo_cc$nation, nations$code)
  expect_gte(min(oslo_cc$time), 0)
  expect_gte(min(oslo_cc$diff_time), 0)
  expect_lte(
    max(
      abs(
        # for some reason, this fails when not converted to numeric.
        # Some Periods are of the form "1M -60S"
        as.numeric(oslo_cc$time[-1] - oslo_cc$time[1] -
              oslo_cc$diff_time[-1])
      )
    ),
    1e-12
  )

  expect_equal(attr(oslo_cc, "url"), get_races_url())

  expect_snapshot(print(oslo_cc, width = Inf, n = Inf))
})


test_that("query_race() works for a telemark world cup race", {
  # similar to AL, brand and cup_points are missing
  local_mocked_bindings(
    get_races_url = function(...) test_path("data", "race_tm_classic.html.gz")
  )
  result <- tibble(athlete = "Matter Stefan",
                   place = "Samoens",
                   sector = "TM",
                   race_id = "1225")
  samoens_tm <- query_race(result)

  expect_s3_class(samoens_tm, "tbl_df")

  expected_names <- c("rank", "bib", "fis_code", "name", "birth_year",
                      "nation", "time", "diff_time", "fis_points")
  expect_named(samoens_tm, expected_names)

  expected_types <- c("integer", "integer", "character", "character",
                      "integer", "character",
                      "Period", "Period", "double")
  for (i in seq_along(expected_types)) {
    if (expected_types[i] == "Period") {
      expect_s4_class(samoens_tm[[expected_names[i]]], expected_types[i])
    } else {
      expect_type(samoens_tm[[expected_names[i]]], expected_types[i])
    }
  }

  expect_in(samoens_tm$rank, 1:nrow(samoens_tm))
  expect_in(diff(samoens_tm$rank), 0:2)
  expect_in(samoens_tm$bib, 1:max(samoens_tm$bib))
  expect_match(samoens_tm$fis_code, "^\\d+$")
  expect_in(samoens_tm$birth_year, 1900:2100)
  expect_in(samoens_tm$nation, nations$code)
  expect_gte(min(samoens_tm$time), 0)
  expect_gte(min(samoens_tm$diff_time), 0)
  expect_lte(
    max(
      abs(samoens_tm$time[-1] - samoens_tm$time[1] - samoens_tm$diff_time[-1])
    ),
    1e-12
  )

  expect_equal(attr(samoens_tm, "url"), get_races_url())

  expect_snapshot(print(samoens_tm, width = Inf, n = Inf))
})


test_that("query_race() works for a ski jumping event", {
  # ski jumping uses points, not times
  local_mocked_bindings(
    get_races_url = function(...) test_path("data", "race_jp.html.gz")
  )
  result <- tibble(athlete = "Ammann Simon",
                   place = "Vancouver",
                   sector = "JP",
                   race_id = "2838")
  vancouver_jp <- query_race(result)

  expect_s3_class(vancouver_jp, "tbl_df")

  expected_names <- c("rank", "bib", "fis_code", "name", "birth_year",
                      "nation", "total_points", "diff_points")
  expect_named(vancouver_jp, expected_names)

  expected_types <- c("integer", "integer", "character", "character",
                      "integer", "character", "double", "double")
  for (i in seq_along(expected_types)) {
    expect_type(vancouver_jp[[expected_names[i]]], expected_types[i])
  }

  expect_in(vancouver_jp$rank, 1:nrow(vancouver_jp))
  expect_in(diff(vancouver_jp$rank), 0:2)
  expect_in(vancouver_jp$bib, 1:max(vancouver_jp$bib))
  expect_match(vancouver_jp$fis_code, "^\\d+$")
  expect_in(vancouver_jp$birth_year, 1900:2100)
  expect_in(vancouver_jp$nation, nations$code)
  expect_gte(min(vancouver_jp$total_points), 0)
  expect_lte(min(vancouver_jp$diff_points), 0)

  expect_lte(
    max(
      abs(vancouver_jp$total_points[-1] - vancouver_jp$total_points[1] -
            vancouver_jp$diff_points[-1])
    ),
    1e-12
  )

  expect_equal(attr(vancouver_jp, "url"), get_races_url())

  expect_snapshot(print(vancouver_jp, width = Inf, n = Inf))
})


test_that("query_race() works for a snowbard halfpipe event", {
  # snowboard uses points, not time. The column is named "score", not "points"
  local_mocked_bindings(
    get_races_url = function(...) test_path("data", "race_sb_hp.html.gz")
  )
  result <- tibble(athlete = "Burgener Patrick",
                   place = "Laax",
                   sector = "SB",
                   race_id = "22735")
  laax_sb <- query_race(result)

  expect_s3_class(laax_sb, "tbl_df")

  expected_names <- c("rank", "bib", "fis_code", "name", "birth_year",
                      "nation", "score", "fis_points", "cup_points")
  expect_named(laax_sb, expected_names)

  expected_types <- c("integer", "integer", "character", "character",
                      "integer", "character", "double", "double", "double")
  for (i in seq_along(expected_types)) {
    expect_type(laax_sb[[expected_names[i]]], expected_types[i])
  }

  expect_in(laax_sb$rank, 1:nrow(laax_sb))
  expect_in(diff(laax_sb$rank), 0:2)
  expect_in(laax_sb$bib, 1:max(laax_sb$bib))
  expect_match(laax_sb$fis_code, "^\\d+$")
  expect_in(laax_sb$birth_year, 1900:2100)
  expect_in(laax_sb$nation, nations$code)
  expect_gte(min(laax_sb$score), 0)
  # because there is a qualification and a final run, there is a single point
  # in the ranking, where the score jups up to a higher value. In all other
  # cases, score should decrease from one rank to the next.
  expect_lte(max(sort(diff(laax_sb$score), decreasing = TRUE)[-1]), 0)

  expect_equal(attr(laax_sb, "url"), get_races_url())

  # score is given with four significant digits => make sure all digits are
  # printed to the snapshot
  local_options(list(pillar.sigfig = 4))

  expect_snapshot(print(laax_sb, width = Inf, n = Inf))
})


test_that("query_race() works for a freestyle ski cross event", {
  # similar to AL, brand and diff_time missing, time is called qual_time
  local_mocked_bindings(
    get_races_url = function(...) test_path("data", "race_fs_cross.html.gz")
  )
  result <- tibble(athlete = "Smith Fanny",
                   place = "Craigleith",
                   sector = "FS",
                   race_id = "15223")
  craigleith_sc <- query_race(result)

  expect_s3_class(craigleith_sc, "tbl_df")

  expected_names <- c("rank", "bib", "fis_code", "name", "birth_year",
                      "nation", "qual_time", "fis_points", "cup_points")
  expect_named(craigleith_sc, expected_names)

  expected_types <- c("integer", "integer", "character", "character",
                      "integer", "character",
                      "Period", "double", "double")
  for (i in seq_along(expected_types)) {
    if (expected_types[i] == "Period") {
      expect_s4_class(craigleith_sc[[expected_names[i]]], expected_types[i])
    } else {
      expect_type(craigleith_sc[[expected_names[i]]], expected_types[i])
    }
  }

  expect_in(craigleith_sc$rank, 1:nrow(craigleith_sc))
  expect_in(diff(craigleith_sc$rank), 1)
  expect_in(craigleith_sc$bib, 1:max(craigleith_sc$bib))
  expect_match(craigleith_sc$fis_code, "^\\d+$")
  expect_in(craigleith_sc$birth_year, 1900:2100)
  expect_in(craigleith_sc$nation, nations$code)
  expect_gte(min(craigleith_sc$qual_time), 0)
  expect_in(craigleith_sc$fis_points, (1:100) * 10)
  expect_in(craigleith_sc$cup_points, 1:100)

  expect_equal(attr(craigleith_sc, "url"), get_races_url())

  expect_snapshot(print(craigleith_sc, width = Inf, n = Inf))
})


test_that("query_race() works for a nordic combined world cup race", {
  # similar to AL, brand missing, additional columns for ski jump
  local_mocked_bindings(
    get_races_url = function(...) test_path("data", "race_nk_wc.html.gz")
  )
  result <- tibble(athlete = "Hagen Ida Marie",
                   place = "Lillehammer",
                   sector = "NK",
                   race_id = "3345")
  lillehammer_nk <- query_race(result)

  expect_s3_class(lillehammer_nk, "tbl_df")

  expected_names <- c("rank", "bib", "fis_code", "name", "birth_year", "nation",
                      "distance", "points", "jump_rank", "time", "diff_time")
  expect_named(lillehammer_nk, expected_names)

  expected_types <- c("integer", "integer", "character", "character", "integer",
                      "character", "double", "double", "integer",
                      "Period", "Period")
  for (i in seq_along(expected_types)) {
    if (expected_types[i] == "Period") {
      expect_s4_class(lillehammer_nk[[expected_names[i]]], expected_types[i])
    } else {
      expect_type(lillehammer_nk[[expected_names[i]]], expected_types[i])
    }
  }

  expect_in(lillehammer_nk$rank, 1:nrow(lillehammer_nk))
  expect_in(diff(lillehammer_nk$rank), 1)
  expect_in(lillehammer_nk$bib, 1:max(lillehammer_nk$bib))
  expect_match(lillehammer_nk$fis_code, "^\\d+$")
  expect_in(lillehammer_nk$birth_year, 1900:2100)
  expect_in(lillehammer_nk$nation, nations$code)
  expect_gt(max(lillehammer_nk$distance), 0)
  expect_gt(max(lillehammer_nk$distance), 0)
  expect_in(lillehammer_nk$jump_rank, 1:max(lillehammer_nk$jump_rank))
  expect_gte(min(lillehammer_nk$time), 0)
  expect_gte(min(lillehammer_nk$diff_time), 0)
  expect_lte(
    max(
      abs(
        # for some reason, this fails when not converted to numeric.
        # Some Periods are of the form "1M -60S"
        as.numeric(lillehammer_nk$time[-1] - lillehammer_nk$time[1] -
              lillehammer_nk$diff_time[-1])
      )
    ),
    1e-12
  )

  expect_equal(attr(lillehammer_nk, "url"), get_races_url())

  # score is given with four significant digits => make sure all digits are
  # printed to the snapshot
  local_options(list(pillar.sigfig = 4))

  expect_snapshot(print(lillehammer_nk, width = Inf, n = Inf))
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

  expected_names <- c("rank", "bib", "fis_code", "name",
                      "birth_year", "nation")
  expect_named(empty, expected_names)

  expected_types <- c("integer", "integer", "character",
                      "character", "integer", "character")
  for (i in seq_along(expected_types)) {
    expect_type(empty[[expected_names[i]]], expected_types[i])
  }

  expect_equal(attr(empty, "url"), get_races_url())
})

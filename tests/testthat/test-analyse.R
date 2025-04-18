library(dplyr, warn.conflicts = FALSE)
library(stringr)

# create a data frame with some results from Didier Cuche.
cuche_res <- tribble(
         ~date,         ~place,  ~nation,             ~category, ~discipline, ~rank, ~cup_points,
  "2009-01-24",   "Kitzbuehel",    "AUT",           "World Cup",  "Downhill",    4L,          50,
  "2009-02-04",  "Val d'Isère",    "FRA", "World Championships",   "Super G",    1L,          NA,
  "2009-02-07",  "Val d'Isère",    "FRA", "World Championships",  "Downhill",    2L,          NA,
  "2009-03-07",    "Kvitfjell",    "NOR",           "World Cup",  "Downhill",   13L,          20,
  "2009-12-18",  "Val Gardena",    "ITA",           "World Cup",   "Super G",    NA,          NA,
  "2010-03-06",    "Kvitfjell",    "NOR",           "World Cup",  "Downhill",    1L,         100,
  "2010-12-04", "Beaver Creek",    "USA",           "World Cup",   "Super G",    3L,          60,
  "2011-01-21",   "Kitzbuehel",    "AUT",           "World Cup",   "Super G",    4L,          50,
  "2011-02-09",     "Garmisch",    "GER", "World Championships",   "Super G",    4L,          NA,
  "2011-02-12",     "Garmisch",    "GER", "World Championships",  "Downhill",    2L,          NA,
  "2011-03-11",    "Kvitfjell",    "NOR",           "World Cup",  "Downhill",    5L,          45,
  "2011-03-12",    "Kvitfjell",    "NOR",           "World Cup",  "Downhill",    7L,          36,
  "2011-12-29",       "Bormio",    "ITA",           "World Cup",  "Downhill",    8L,          32,
  "2012-02-11",        "Sochi",    "RUS",           "World Cup",  "Downhill",   12L,          22
  ) %>%
  mutate(date = as.Date(date)) %>%
  mutate(age = compute_age_at_date(date, tibble(birthdate = "1974")),
         .after = "date") %>%
  mutate(athlete = "Cuche Didier", .before = 1) %>%
  mutate(sector = "AL", .after = "nation") %>%
  mutate(fis_points = 0, .after = "rank") %>%
  mutate(race_id = as.character(1:n()), .after = last_col())


test_that("summarise_results() works with default settings", {
    cuche_sum <- summarise_results(cuche_res)

    expect_s3_class(cuche_sum, "tbl_df")

    expected_names <- c("athlete", "season", "category", "discipline", "podiums",
                        paste0("pos", 1:3), paste0("top", c(5, 10, 20, 30)),
                        "dnf", "races", "cup_points")
    expect_named(cuche_sum, expected_names)

    expected_types <- c("character", "integer", "character", "character",
                        rep("integer", 10), "double")
    for (i in seq_along(expected_names)) {
      expect_type(cuche_sum[[!!expected_names[i]]], expected_types[i])
    }

    expect_in(cuche_sum$athlete, "Cuche Didier")
    expect_in(cuche_sum$season, 2009:2012)
    expect_in(cuche_sum$category, c("World Cup", "World Championships"))
    expect_in(cuche_sum$discipline, c("Downhill", "Super G"))
    expect_equal(cuche_sum$podiums, rowSums(select(cuche_sum, pos1:pos3)))
    expect_equal(rowSums(select(cuche_sum, pos1:dnf)), cuche_sum$races)

    expect_snapshot(print(cuche_sum, width = Inf, n = Inf))
})


test_that("summarise_results() works with different values for show_pos", {
  cuche_sum <- summarise_results(cuche_res, show_pos = c())
  expect_setequal(str_subset(names(cuche_sum), "^(pos|top)"), character(0))
  cuche_sum <- summarise_results(cuche_res, show_pos = FALSE)
  expect_setequal(str_subset(names(cuche_sum), "^(pos|top)"), character(0))

  cuche_sum <- summarise_results(cuche_res, show_pos = 1)
  expect_setequal(str_subset(names(cuche_sum), "^(pos|top)"), "pos1")
  cuche_sum <- summarise_results(cuche_res, show_pos = 2)
  expect_setequal(str_subset(names(cuche_sum), "^(pos|top)"), "top2")

  cuche_sum <- summarise_results(cuche_res, show_pos = c(3, 4, 5, 10, 63))
  expect_setequal(str_subset(names(cuche_sum), "^(pos|top)"),
                  c("top3", "pos4", "pos5", "top10", "top63"))
  cuche_sum <- summarise_results(cuche_res, show_pos = c(10, 3, 5, 63, 4))
  expect_setequal(str_subset(names(cuche_sum), "^(pos|top)"),
                  c("top3", "pos4", "pos5", "top10", "top63"))

  suppressWarnings(
    cuche_sum <- summarise_results(cuche_res, show_pos = c(1:3, 1:3))
  )
  expect_setequal(str_subset(names(cuche_sum), "^(pos|top)"),
                  paste0("pos", 1:3))
})


test_that("messages in summarise_results() work", {
  expect_warning(summarise_results(cuche_res, show_pos = c(1, 2, 1, 3)),
                 "Duplicated values in show_pos are removed")
  expect_error(summarise_results(cuche_res, show_pos = c(1, 2.5)),
                 "show_pos must be a vector of integer values")
  expect_error(summarise_results(cuche_res, show_pos = c(1, "a")),
                 "show_pos must be a vector of integer values")
  # "a", "c", "d" match "age", "category", "discipline", respectively.
  expect_error(summarise_results(cuche_res, by = c("a", "b", "c", "d", "e")),
               "Invalid grouping variables: 'b' and 'e'")
})


test_that("summarise_results() works with different groupings", {
  grp_cols <- c("season", "age", "category", "discipline", "place", "nation")

  cuche_no_grp <- summarise_results(cuche_res, by = c(), show_pos = FALSE)
  expect_named(cuche_no_grp[1], "athlete")
  expect_false(any(grp_cols %in% names(cuche_no_grp)))

  for (grp_col in grp_cols) {
    cuche_grp <- summarise_results(cuche_res, by = grp_col, show_pos = FALSE)
    expect_named(cuche_grp[1:2], c("athlete", grp_col))
    expect_false(any(setdiff(grp_cols, grp_col) %in% names(cuche_grp)))
  }

  expect_named(
    summarise_results(cuche_res, by = rev(grp_cols), show_pos = FALSE) %>%
      select(1:(length(grp_cols) + 1)),
    c("athlete", rev(grp_cols))
  )

  expect_named(
    summarise_results(cuche_res, by = c("d", "n", "c"), show_pos = FALSE)[1:4],
    c("athlete", "discipline", "nation", "category")
  )
})


test_that("summarise_results() works with age", {
  cuche_sum <- summarise_results(cuche_res, by = c("season", "age"),
                                 show_pos = c())
  expect_named(
    cuche_sum,
    c("athlete", "season", "age", "podiums", "dnf", "races", "cup_points")
  )
  # the age should be the age at the beginning of the season. Since the variable
  # "season" conrresponds to the year where the season ends, we have to subtract
  # one.
  expect_equal(cuche_sum$age, (cuche_sum$season - 1) - 1974)
})


test_that("check error in summarise_results() when age is missing", {
  expect_error(
    summarise_results(cuche_res %>% select(-age), by = "age"),
    "column 'age' is not present"
  )
})


test_that("summarise_results() works with different summaries", {
  base_names <- c("athlete", "season", "category", "discipline")

  expect_named(
    summarise_results(cuche_res, show_pos = FALSE, show_dnf = FALSE,
                      show_victories = FALSE, show_podiums = FALSE,
                      show_races = FALSE, show_points = FALSE),
    base_names
  )
  expect_named(
    summarise_results(cuche_res, show_pos = FALSE, show_dnf = TRUE,
                      show_victories = FALSE, show_podiums = FALSE,
                      show_races = FALSE, show_points = FALSE),
    c(base_names, "dnf")
  )
  expect_named(
    summarise_results(cuche_res, show_pos = FALSE, show_dnf = FALSE,
                      show_victories = TRUE, show_podiums = FALSE,
                      show_races = FALSE, show_points = FALSE),
    c(base_names, "victories")
  )
  expect_named(
    summarise_results(cuche_res, show_pos = FALSE, show_dnf = FALSE,
                      show_victories = FALSE, show_podiums = TRUE,
                      show_races = FALSE, show_points = FALSE),
    c(base_names, "podiums")
  )
  expect_named(
    summarise_results(cuche_res, show_pos = FALSE, show_dnf = FALSE,
                      show_victories = FALSE, show_podiums = FALSE,
                      show_races = TRUE, show_points = FALSE),
    c(base_names, "races")
  )
  expect_named(
    summarise_results(cuche_res, show_pos = FALSE, show_dnf = FALSE,
                      show_victories = FALSE, show_podiums = FALSE,
                      show_races = FALSE, show_points = TRUE),
    c(base_names, "cup_points")
  )
})


test_that("summarise_results() works with relative results", {
  cuche_sum <- summarise_results(cuche_res, show_victories = TRUE,
                                 add_relative = TRUE)

    expect_s3_class(cuche_sum, "tbl_df")

    expected_names <- c(
      "athlete", "season", "category", "discipline",
      "victories", "victories_rel", "podiums", "podiums_rel",
      paste0(
        rep(
          c(paste0("pos", 1:3), paste0("top", c(5, 10, 20, 30))),
          each = 2
        ),
        c("", "_rel")
      ),
      "dnf", "dnf_rel", "races", "cup_points", "cup_points_rel"
    )
    expect_named(cuche_sum, expected_names)

    expected_types <- c("character", "integer", "character", "character",
                        rep(c("integer", "double"), 11), "double", "double")
    for (i in seq_along(expected_names)) {
      expect_type(cuche_sum[[!!expected_names[i]]], expected_types[i])
    }

    cuche_sum_no_rel <- summarise_results(cuche_res)
    expect_equal(cuche_sum[names(cuche_sum_no_rel)], cuche_sum_no_rel)
    for (rel_col in str_subset(names(cuche_sum), "_rel$")) {
      expect_equal(cuche_sum[[!!rel_col]],
                   cuche_sum[[!!str_remove(rel_col, "_rel$")]] / cuche_sum$races
                   )
    }
})


test_that("summarise_results() works with different relative summaries", {
  base_names <- c("athlete", "season", "category", "discipline")

  expect_named(
    summarise_results(cuche_res, show_pos = FALSE, show_dnf = FALSE,
                      show_podiums = FALSE, show_races = FALSE,
                      show_points = FALSE, add_relative = TRUE),
    base_names
  )
  expect_named(
    summarise_results(cuche_res, show_pos = FALSE, show_dnf = FALSE,
                      show_podiums = TRUE, show_races = FALSE,
                      show_points = FALSE, add_relative = TRUE),
    c(base_names, "podiums", "podiums_rel")
  )
  expect_named(
    summarise_results(cuche_res, show_pos = FALSE, show_dnf = FALSE,
                      show_podiums = FALSE, show_races = TRUE,
                      show_points = FALSE, add_relative = TRUE),
    c(base_names, "races")
  )
})


test_that(
  "summarise_results() gives consistent results for equivalent summaries",
  {
    expect_equal(
      summarise_results(cuche_res, show_pos = FALSE, show_victories = TRUE)$victories,
      summarise_results(cuche_res, show_pos = 1)$pos1
    )
    expect_equal(
      summarise_results(cuche_res, show_pos = FALSE)$podiums,
      summarise_results(cuche_res, show_pos = 3, show_victories = TRUE)$top3
    )
  }
)


test_that("get_debuts() works with default settings", {
  local_mocked_bindings(
    query_results = function(...) cuche_res
  )
  cuche <- tibble(name = "Cuche Didier", birthdate = "1974")
  debuts <- get_debuts(cuche)

  expect_s3_class(debuts, "tbl_df")

  expected_names <- c("athlete", "date", "age", "place", "nation", "sector",
                      "category", "discipline", "rank", "fis_points",
                      "cup_points", "race_id")
  expect_named(debuts, expected_names)

  expected_types <- rep("character", 12) %>%
    replace(c(2:3, 9:11), c("Date", "double", "integer", "double", "double"))
  for (i in seq_along(expected_names)) {
    if (expected_types[i] == "Date") {
      expect_s3_class(debuts[[!!expected_names[i]]], expected_types[i])
    } else {
      expect_type(debuts[[!!expected_names[i]]], expected_types[i])
    }
  }

  expect_in(debuts$athlete, "Cuche Didier")
  expect_true(all(between(debuts$age, 10, 40)))
  expect_in(debuts$nation, nations$code)
  expect_in(debuts$sector, "AL")
  expect_in(debuts$category, c("World Cup", "World Championships"))
  expect_in(debuts$discipline, c("Downhill", "Super G"))
  expect_in(debuts$rank, c(0:100, NA_integer_))
  expect_in(na.omit(debuts$cup_points), 0:100)
  expect_match(debuts$race_id, "^\\d+$")

  expect_snapshot(print(debuts, width = Inf, n = Inf))
})


test_that("get_debuts() works with different groupings", {
  local_mocked_bindings(
    query_results = function(...) cuche_res
  )
  cuche <- tibble(name = "Cuche Didier", birthdate = "1974")
  grp_cols <- c("category", "discipline")

  debuts_no_grp <- get_debuts(cuche, by = c())
  expect_equal(nrow(debuts_no_grp), 1)
  expect_equal(debuts_no_grp$date, min(cuche_res$date))

  debuts_by_category <- get_debuts(cuche, by = "category")
  expect_equal(nrow(debuts_by_category), 2)
  expect_setequal(debuts_by_category$category, cuche_res$category)

  debuts_by_discipline <- get_debuts(cuche, by = "discipline")
  expect_equal(nrow(debuts_by_discipline), 2)
  expect_setequal(debuts_by_discipline$discipline, cuche_res$discipline)
})


test_that("get_debuts() works for all types", {
  local_mocked_bindings(
    query_results = function(...) cuche_res
  )
  cuche <- tibble(name = "Cuche Didier", birthdate = "1974")

  debuts_podium <- get_debuts(cuche, type = "podium")
  expect_in(debuts_podium$rank, 1:3)

  debuts_victory <- get_debuts(cuche, type = "victory")
  expect_in(debuts_victory$rank, 1L)
})

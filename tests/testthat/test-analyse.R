library(dplyr, warn.conflicts = FALSE)
library(stringr)

# create a data frame with some results from Didier Cuche. Some irrelevant
# columns are omitted.
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
  mutate(athlete = "Cuche Didier", .before = 1) %>%
  mutate(sector = "AL", .after = "place") %>%
  mutate(race_id = 1:n(), .after = last_col())


test_that("summarise_results() works with default settings", {
    cuche_sum <- summarise_results(cuche_res)

    expect_s3_class(cuche_sum, "tbl_df")

    expected_names <- c("athlete", "season", "category", "discipline", "podium",
                        paste0("pos", 1:3), paste0("top", c(5, 10, 20, 30)),
                        "dnf", "n_races", "cup_points")
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
    expect_equal(cuche_sum$podium, rowSums(select(cuche_sum, pos1:pos3)))
    expect_equal(rowSums(select(cuche_sum, pos1:dnf)), cuche_sum$n_races)

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
  expect_error(summarise_results(cuche_res, by = c("a", "b", "c", "d")),
               "Invalid grouping variables: 'a' and 'b'")
})


test_that("summarise_results() works with different groupings", {
  grp_cols <- c("season", "category", "discipline", "place", "nation")

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


test_that("summarise_results() works with different summaries", {
  base_names <- c("athlete", "season", "category", "discipline")

  expect_named(
    summarise_results(cuche_res, show_pos = FALSE, show_dnf = FALSE,
                      show_podiums = FALSE, show_n_races = FALSE,
                      show_points = FALSE),
    base_names
  )
  expect_named(
    summarise_results(cuche_res, show_pos = FALSE, show_dnf = TRUE,
                      show_podiums = FALSE, show_n_races = FALSE,
                      show_points = FALSE),
    c(base_names, "dnf")
  )
  expect_named(
    summarise_results(cuche_res, show_pos = FALSE, show_dnf = FALSE,
                      show_podiums = TRUE, show_n_races = FALSE,
                      show_points = FALSE),
    c(base_names, "podium")
  )
  expect_named(
    summarise_results(cuche_res, show_pos = FALSE, show_dnf = FALSE,
                      show_podiums = FALSE, show_n_races = TRUE,
                      show_points = FALSE),
    c(base_names, "n_races")
  )
  expect_named(
    summarise_results(cuche_res, show_pos = FALSE, show_dnf = FALSE,
                      show_podiums = FALSE, show_n_races = FALSE,
                      show_points = TRUE),
    c(base_names, "cup_points")
  )
})


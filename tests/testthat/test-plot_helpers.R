library(dplyr, warn.conflicts = FALSE)
library(stringr)
library(ggplot2)

test_that("create_darkened_colour_sequence() works", {
  red <- "#FF0000"
  col_seq <- create_darkened_colour_sequence(red, 5)
  expect_length(col_seq, 5)
  expect_equal(col_seq[1], red)
  expect_equal(col_seq, c("#FF0000", "#D20505", "#A70303", "#7F0000", "#590000"))

  purple <- "#A020F0"
  col_seq <- create_darkened_colour_sequence(purple, 9)
  expect_length(col_seq, 9)
  expect_equal(col_seq[1], purple)
  expect_equal(col_seq, c("#A020F0", "#9410E0", "#8804CF", "#7A01BB", "#6D00A7",
                          "#5F0193", "#530081", "#46006F", "#3A005C"))

  cyan <- "#00FFFF"
  expect_equal(create_darkened_colour_sequence(cyan, 1), cyan)
})


test_that("create_athlete_pos_colour_scale() works", {
  athletes <- c("Odermatt Marco", "Kristoffersen Henrik", "Meillard Loic")
  positions <- paste0("top", 1:3)
  df_ap <- tibble(
    athlete = rep(athletes, each = length(positions)),
    position = rep(positions, times = length(athletes))
  )
  col_scale <- create_athlete_pos_colour_scale(df_ap$athlete, df_ap$position)
  expect_length(col_scale, length(athletes) * length(positions))
  expect_equal(sum(duplicated(names(col_scale))), 0)
  expect_equal(
    col_scale[str_detect(names(col_scale), positions[1])],
    cb_pal_set1[seq_along(athletes)],
    ignore_attr = "names"
  )

  expect_snapshot(col_scale)
})


test_that("fis_plot() works for static plot", {
  p <- mtcars %>%
    ggplot(aes(x = disp, y = mpg, colour = factor(cyl))) +
    geom_point()
  expect_s3_class(fis_plot(p, interactive = FALSE), "gg")
  expect_equal(fis_plot(p, interactive = FALSE), p)
  expect_equal(fis_plot(p, interactive = FALSE, width = 10, height = 8), p)
})


test_that("fis_plot() works for interactive plot", {
  p <- mtcars %>%
    ggplot(aes(x = disp, y = mpg, colour = factor(cyl))) +
    geom_point()
  ip <- fis_plot(p, interactive = TRUE)
  expect_s3_class(ip, "girafe")
  expect_equal(ip$x$ratio, 6/5)
  expect_match(
    ip$x$settings$tooltip$css,
    paste0("padding:5px;color:white;border-radius:5px;text-align:left;",
           "font-family:sans-serif")
  )
  expect_equal(ip$x$settings$tooltip$opacity, 1)
  expect_equal(ip$x$settings$tooltip$use_fill, TRUE)
  expect_equal(ip$x$settings$zoom[c("min", "max")], list(min = 1, max = 5))

  ip <- fis_plot(p, interactive = TRUE, width = 10, height = 6)
  expect_s3_class(ip, "girafe")
  expect_equal(ip$x$ratio, 10/6)
})


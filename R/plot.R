#' Plot summary of one or more athlete's results
#'
#' @param results a tibble with the results of one or more athletes. The tibble
#'  for one athlete can be created with [query_results()] and the tibble for
#'  multiple athletes can be combined with [dplyr::bind_rows()].
#' @param by variables to groups the plot by. Possible values are "category"
#'  (on rows) and "discipline" (on columns). Values are partially matched.
#'  Set this value to an empty vector (`c()`) or `NA` to create a plot with
#'  a single facet.
#' @param pos numeric that controls the summary of ranks. It has a slightly
#'  different meaning for `plot_rank_summary()` and `plot_results_summary()`:
#'  * `plot_rank_summary()`: one or multiple break points for the ranks to
#'    summarise. The plot will then show the
#'    counts for the number of ranks that are at least as good as each break
#'    point and worse than the next better break point.
#'  * `plot_results_summary()`: the position to show in the plot. Depending
#'    on  the value of "variable", the plot will show the number of times
#'    exactly this rank (variable = "position") or a rank at least as good
#'    (variable = "top") was achieved.
#' @param interactive logical indicating whether an interactive plot (with
#'  ggiraph) should be returned. If `FALSE`, a static ggplot is returned that
#'  can be turned into an interactive plot with [ggiraph::girafe()].
#' @param width,height dimensions for the interactive plot in inches, passed on
#'  to [ggiraph::girafe()]. The default values are 6 and 5 inches, respectively.
#'
#' @rdname plot_results
#' @export

plot_rank_summary <- function(results,
                              by = c("category", "discipline"),
                              pos = 1:3,
                              interactive = TRUE,
                              width = NULL,
                              height = NULL) {

  by <- match_groupings(by, c("category", "discipline"))

  plot_data <- results %>%
    prepare_rank_plot_data(by = by, pos = pos)

  col_scales <- create_athlete_pos_colour_scale(
    plot_data$athlete, plot_data$position
  )

  p <- plot_data %>%
    dplyr::mutate(
      fill = interaction(.data$athlete, .data$position, sep = "_"),
      tooltip = glue::glue(
        "athlete: {.data$athlete}
         position: {.data$position}
         count: {.data$count}"
      )
    ) %>%
    ggplot2::ggplot(
      ggplot2::aes(
        x = .data$athlete,
        y = .data$count,
        fill = .data$fill,
        # without explicit group aesthetic, the stacking order of the bars
        # is wrong.
        group = .data$fill
      )
    ) +
    ggiraph::geom_col_interactive(
      ggplot2::aes(tooltip = .data$tooltip,
                   data_id = .data$position),
      position = "stack"
    ) +
    ggplot2::facet_grid(
      rows = if ("category" %in% by) dplyr::vars(.data$category),
      cols = if ("discipline" %in% by) dplyr::vars(.data$discipline),
      scales = "free_y"
    ) +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)
    ) +
    ggplot2::labs(x = NULL)

  p <- p %>% add_col_scale_and_legend(col_scales)

  fis_plot(p, interactive, width, height)
}


#' @param variable character giving the variable to plot on the y-axis. For
#'  "position" and "top", the value of the argument "pos" is also relevant:
#'  for "position", the plot will show the number of times  exactly the rank
#'  given by "pos" was achieved, for "top" the number of times a rank at least
#'  as good as "pos" was achieved.
#' @param relative use relative scale for points, victories, podiums or dnf?
#' @rdname plot_results
#' @export

plot_results_summary <- function(results,
                                 by = c("category", "discipline"),
                                 variable = c("points", "races", "victories",
                                              "podiums", "dnf",
                                              "position", "top"),
                                 pos = 1,
                                 relative = FALSE,
                                 interactive = TRUE,
                                 width = NULL,
                                 height = NULL) {

  variable <- match.arg(variable)

  # up to 9 athletes are supported. Abort if there are more.
  n_athletes <- dplyr::n_distinct(results$athlete)
  if (n_athletes > 9) {
    cli::cli_abort("Only up to 9 athletes are supported, you provided
                   {n_athletes}.")
  }

  by <- match_groupings(by, c("category", "discipline"))

  # some variables need special preparation
  use_pos <- c()
  if (variable == "points") {
    variable <- "cup_points"
  } else if (variable == "top") {
    use_pos <- pos
    variable <- paste0(if (pos == 1) "pos" else "top", pos)
  } else if (variable == "position") {
    use_pos <- c(pos - 1, pos)
    variable <- paste0("pos", pos)
  }

  plot_data <- results %>%
    summarise_results(by = by, show_pos = use_pos, show_victories = TRUE,
                      add_relative = TRUE)

  cols <- cb_pal_set1[1:n_athletes]
  names(cols) <- unique(plot_data$athlete)

  # prepare variable name and title for the y-axis
  y_var <- if (relative && variable != "races") {
    paste0(variable, "_rel")
  } else {
    variable
  }
  y_title <- dplyr::case_when(
    y_var == "cup_points_rel" ~ "cup points per race",
    .default = stringr::str_replace_all(variable, "_", " ")
  )

  p <- plot_data %>%
    dplyr::mutate(
      tooltip = glue::glue(
        "athlete: {.data$athlete}
         races: {.data$races}
         cup points: {format(.data$cup_points, big.mark = \"'\")}
         per race: {round(.data$cup_points_rel)}
         victories: {.data$victories} ({(round(100 * .data$victories_rel, 1))}%)
         podiums: {.data$podiums} ({(round(100 * .data$podiums_rel, 1))}%)
         dnf: {.data$dnf} ({(round(100 * .data$dnf_rel, 1))}%)"
      )
    ) %>%
    ggplot2::ggplot(
      ggplot2::aes(
        x = .data$athlete,
        y = .data[[y_var]],
        fill = .data$athlete
      )
    ) +
    ggiraph::geom_col_interactive(
      ggplot2::aes(tooltip = .data$tooltip,
                   data_id = .data$athlete)
    ) +
    ggplot2::facet_grid(
      rows = if ("category" %in% by) dplyr::vars(.data$category),
      cols = if ("discipline" %in% by) dplyr::vars(.data$discipline),
      scales = "free_y"
    ) +
    ggplot2::scale_fill_manual(values = cols, guide = "none") +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)
    ) +
    ggplot2::labs(x = NULL, y = y_title)

  # add percent y-scale where it makes sense
  if (relative && !variable %in% c("cup_points", "races")) {
    p <- p + ggplot2::scale_y_continuous(labels = scales::label_percent())
  }

  fis_plot(p, interactive, width, height)
}


#' Plot athlete's results over time
#'
#' Plot the results of one or several athletes over time.
#'
#' @inheritParams plot_rank_summary
#' @param by variable to groups the plot by. Possible values are "discipline",
#'  "category", and "athlete". Values are partially matched.
#'  Set this value to an empty vector (`c()`) or `NA` to create a plot with
#'  a single facet.
#' @param pos numeric that controls the summary of ranks. Indicate one or
#'  multiple break points for the ranks to summarise. The plot will then show
#'  the counts for the number of ranks that are at least as good as each break
#'  point and worse than the next better break point.
#' @param type character giving the type of the plot. Use "lines" for a lines
#'  plot with points and "bars" for a bar plot.
#' @param time the variable to use for the x-axis. Possible values are
#'  "season" and "age". The function uses the age at the beginning of the
#'  season for the entire season.
#' @param cumulative should cumulative counts be plotted?
#'
#' @rdname plot_results_over_time
#' @export

plot_ranks_over_time <- function(results,
                                 by = c("discipline", "category", "athlete"),
                                 time = c("season", "age"),
                                 pos = 1:3,
                                 type = c("lines", "bars"),
                                 cumulative = FALSE,
                                 interactive = TRUE,
                                 width = NULL,
                                 height = NULL) {

  if (length(by) > 0 || isTRUE(is.na(by))) {
    by <- match.arg(by)
  }
  time <- match.arg(time)
  type <- match.arg(type)

  # if there is no faceting by athlete, only accept a single athlete.
  n_athletes <- dplyr::n_distinct(results$athlete)
  if (!"athlete" %in% by && n_athletes > 1) {
    cli::cli_abort("Multiple athletes are only supported when
                   by = 'athlete'.")
  }
  # up to 9 athletes are supported. Abort if there are more.
  if (n_athletes > 9) {
    cli::cli_abort("Only up to 9 athletes are supported, you provided
                   {n_athletes}.")
  }

  grp_by <- c("season", "age", by) %>%
    # remove athlete from the grouping, since prepare_rank_plot_data()
    # always groups by athlete
    setdiff("athlete")

  plot_data <- results %>%
    prepare_rank_plot_data(by = grp_by, pos = pos, cumulative = cumulative)

  col_scales <- create_athlete_pos_colour_scale(
    plot_data$athlete, plot_data$position
  )

  p <- plot_data %>%
    dplyr::mutate(
      colour = interaction(.data$athlete, .data$position, sep = "_"),
      tooltip = glue::glue(
        "athlete: {.data$athlete}
         season: {.data$season}
         age: {.data$age}
         position: {.data$position}
         {if (cumulative) 'cumulative ' else ''}count: {.data$count}"
      )
    ) %>%
    ggplot2::ggplot(
      ggplot2::aes(
        x = .data[[time]],
        y = .data$count
      )
    ) +
    ggplot2::facet_grid(
      rows = if (length(by) > 0) dplyr::vars(.data[[by]]),
      scales = "free_y"
    ) +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)
    ) +
    ggplot2::labs(x = time,
                  y = paste(if (cumulative) "cumulative", "count"))

  # add the geoms
  if (type == "lines") {
    p <- p +
      ggplot2::geom_line(
        ggplot2::aes(colour = .data$colour)
      ) +
      ggiraph::geom_point_interactive(
        ggplot2::aes(
          colour = .data$colour,
          tooltip = .data$tooltip,
          data_id = interaction(.data$position, .data[[time]], sep = "_")
        ),
        size = 2
      )
  } else {
    p <- p +
      ggiraph::geom_col_interactive(
        ggplot2::aes(
          fill = .data$colour,
          tooltip = .data$tooltip,
          data_id = interaction(.data$position, .data[[time]], sep = "_")
        ),
        position = "stack"
      )
  }

  p <- p %>% add_col_scale_and_legend(col_scales)

  fis_plot(p, interactive, width, height)
}

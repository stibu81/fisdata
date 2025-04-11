#' Plot summary of one or more athlete's results
#'
#' @param results a tibble with the results of one or more athletes. The tibble
#'  for one athlete can be created with [query_results()] and the tibble for
#'  multiple athletes can be combined with [dplyr::bind_rows()].
#' @param by variables to groups the plots by. Possible values are "category"
#'  (on rows) and "discipline" (on columns). Values are partially matched.
#'  Set this value to an empty vector (`c()`) or `NA` to create a plot with
#'  a single facet.
#' @param pos numeric that controls the summary of ranks. Indicate the
#'  break points for the ranks to summarise. The plot will then show the
#'  counts for the number of ranks that are at least as good as each break
#'  point and worse then the next better break point.
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

  # up to 9 athletes are supported. Abort if there are more.
  n_athletes <- dplyr::n_distinct(results$athlete)
  if (n_athletes > 9) {
    cli::cli_abort("Only up to 9 athletes are supported, you provided
                   {n_athletes}.")
  }

  by <- match_groupings(by, c("category", "discipline"))

  plot_data <- results %>%
    summarise_results(by = by, show_pos = pos) %>%
    dplyr::select(
      "athlete", dplyr::all_of(by), dplyr::matches("^(pos|top)")
    ) %>%
    dplyr::mutate(
      n_results = rowSums(dplyr::pick(dplyr::matches("^(pos|top)")))
    ) %>%
    dplyr::filter(.data$n_results > 0) %>%
    tidyr::pivot_longer(dplyr::matches("^(pos|top)"),
                        names_to = "position",
                        values_to = "count") %>%
    dplyr::mutate(
      athlete = factor(.data$athlete, levels = unique(.data$athlete)),
      position = factor(.data$position, levels = unique(.data$position))
    )

  cols <- create_athlete_pos_colour_scale(plot_data$athlete, plot_data$position)

  # use monochrome colours for the legend
  n_pos <- length(levels(plot_data$position))
  cols_legend <- create_darkend_colour_sequence(grDevices::grey(0.7), n_pos)
  names(cols_legend) <- levels(plot_data$position)

  # in addition, we need to plot some data that uses all the values for the
  # the legend.
  data_legend <- dplyr::tibble(
    athlete = plot_data$athlete[1],
    count = 0,
    position = factor(names(cols_legend), levels = names(cols_legend)),
    fill = .data$position,
    discipline = if ("discipline" %in% by) plot_data$discipline[1],
    category = if ("category" %in% by) plot_data$category[1]
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
        fill = .data$fill
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
    ggplot2::scale_fill_manual(values = cols, guide = "none") +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)
    ) +
    ggplot2::labs(x = NULL) +
    ggnewscale::new_scale_fill() +
    ggplot2::geom_col(
      data = data_legend,
      ggplot2::aes(fill = .data$position),
      alpha = 0
    ) +
    ggplot2::scale_fill_manual(
      values = cols_legend,
      guide = ggplot2::guide_legend(override.aes = list(alpha = 1))
    )

  fis_plot(p, interactive, width, height)
}

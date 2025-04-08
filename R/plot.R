#' Plot summary of one or more athlete's results
#'
#' @export

plot_results_summary <- function(results,
                                 by = c("category", "discipline"),
                                 pos = 1:3) {

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
                        values_to = "count")

  cols <- create_athlete_pos_colour_scale(plot_data$athlete, plot_data$position)

  # for the legend, we only want to show each position once in the colour of the
  # first athlete => extract these colours and name them only by the position
  n_pos <- dplyr::n_distinct(plot_data$position)
  cols_legend <- cols[1:n_pos]
  names(cols_legend) <- stringr::str_remove(names(cols_legend), "^[^_]+_")
  cols_legend <- colorspace::darken(grDevices::grey(0.7),
                                    seq(0, 0.5, length.out = n_pos))
  names(cols_legend) <- unique(plot_data$position)

  # in addition, we need to plot some data that uses all the values for the
  # the legend.
  data_legend <- dplyr::tibble(
    athlete = plot_data$athlete[1],
    count = 0,
    position = names(cols_legend),
    discipline = if ("discipline" %in% by) plot_data$discipline[1],
    category = if ("category" %in% by) plot_data$category[1]
  )

  plot_data %>%
    ggplot2::ggplot(
      ggplot2::aes(
        x = .data[["athlete"]],
        y = .data[["count"]],
        fill = paste(.data[["athlete"]], .data[["position"]], sep = "_"))
    ) +
    ggplot2::geom_col(position = "stack") +
    ggplot2::facet_grid(
      rows = if ("category" %in% by) dplyr::vars(.data[["category"]]),
      cols = if ("discipline" %in% by) dplyr::vars(.data[["discipline"]]),
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
      ggplot2::aes(fill = .data[["position"]]),
      alpha = 0
    ) +
    ggplot2::scale_fill_manual(
      values = cols_legend,
      guide = ggplot2::guide_legend(override.aes = list(alpha = 1))
    )
}

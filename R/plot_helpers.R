# colour palettes from ColorBrewer
cb_pal_set1 <- c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",
                 "#FFFF33", "#A65628", "#F781BF", "#999999")

# create an athlete-position-colour-scale
# also return a scale that can be used for the legend: it is monochrome if there
# are multiple athletes and coloured, if there is only one.

create_athlete_pos_colour_scale <- function(athletes, positions) {

  athletes <- unique(athletes)
  positions <- unique(positions)
  n_athletes <- length(athletes)
  n_pos <- length(positions)

  # actual colour scale
  base_colours <- cb_pal_set1[1:n_athletes]
  cols <- purrr::map(
      base_colours,
      \(x) create_darkened_colour_sequence(x, n_pos)
    ) %>%
    unlist()
  names(cols) <- paste(rep(unique(athletes), each = n_pos),
                       rep(positions, times = n_athletes),
                       sep = "_")

  # scale for the legend
  if (n_athletes == 1) {
    legend <- cols
  } else {
    legend <- create_darkened_colour_sequence(grDevices::grey(0.7), n_pos)
  }
  names(legend) <- positions

  list(cols = cols, legend = legend)
}


create_darkened_colour_sequence <- function(colour, n) {
  dark_max <- if (n <= 3) 0.5 else 0.7
  colorspace::darken(colour, seq(0, dark_max, length.out = n))
}


# helper function that creates an interactive ggiraph plot with the
# appropriate settings

fis_plot <- function(p, interactive, width = NULL, height = NULL) {

  if (!interactive) {
    return(p)
  }

  ggiraph::girafe(
    ggobj = p,
    width_svg = width,
    height_svg = height,
    options = list(
      ggiraph::opts_zoom(max = 5),
      ggiraph::opts_tooltip(
        # for some reason, when I don't set the font family here, a serif
        # font is used.
        css = paste0("padding:5px;color:white;",
                     "border-radius:5px;text-align:left;",
                     "font-family:sans-serif"),
        use_fill = TRUE,
        opacity = 1
      )
    )
  )
}


# prepare data for plot_rank_summary() and plot_ranks_by_season()

prepare_rank_plot_data <- function(results,
                                   by = c("category", "discipline"),
                                   pos = 1:3,
                                   cumulative = FALSE,
                                   error_call = rlang::caller_env()) {

  # up to 9 athletes are supported. Abort if there are more.
  n_athletes <- dplyr::n_distinct(results$athlete)
  if (n_athletes > 9) {
    cli::cli_abort("Only up to 9 athletes are supported, you provided
                   {n_athletes}.")
  }

  results %>%
    summarise_results(by = by, show_pos = pos, cumulative = cumulative) %>%
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
}


# function to add a colour/fill scale with a manual legend.

add_col_scale_and_legend <- function(plot,
                                     col_scales) {

  # determine the appropriate scale from the type of geom used in the plot
  scale <- if (inherits(plot$layers[[1]]$geom, "GeomBar")) "fill" else "colour"

  # we need to plot some data that uses all the values for the the legend
  data_legend <- plot$data %>%
    dplyr::slice_head(n = 1, by = "position") %>%
    dplyr::mutate("{scale}" := .data$position, count = 0)

  # select functions based on the scale
  if (scale == "colour") {
    new_scale <- ggnewscale::new_scale_colour
    legend_geom <- ggplot2::geom_point
    col_fill_scale <- ggplot2::scale_colour_manual
  } else {
    new_scale <- ggnewscale::new_scale_fill
    legend_geom <- ggplot2::geom_col
    col_fill_scale <- ggplot2::scale_fill_manual
  }

  plot +
    col_fill_scale(values = col_scales$cols, guide = "none") +
    new_scale() +
    legend_geom(
      data = data_legend,
      ggplot2::aes(fill = if (scale == "fill") .data$position,
                   colour = if (scale == "colour") .data$position),
      alpha = 0
    ) +
    col_fill_scale(
      "position",
      values = col_scales$legend,
      guide = ggplot2::guide_legend(override.aes = list(alpha = 1))
    )
}


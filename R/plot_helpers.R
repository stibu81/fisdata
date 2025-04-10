# colour palettes from ColorBrewer
cb_pal_set1 <- c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",
                 "#FFFF33", "#A65628", "#F781BF", "#999999")

# create an athlete-position-colour-scale

create_athlete_pos_colour_scale <- function(athletes, positions) {

  athletes <- unique(athletes)
  positions <- unique(positions)
  n_athletes <- length(athletes)
  n_pos <- length(positions)

  base_colours <- cb_pal_set1[1:n_athletes]
  cols <- purrr::map(
      base_colours,
      \(x) create_darkend_colour_sequence(x, n_pos)
    ) %>%
    unlist()
  names(cols) <- paste(rep(unique(athletes), each = n_pos),
                       rep(positions, times = n_athletes),
                       sep = "_")
  cols
}


create_darkend_colour_sequence <- function(colour, n) {
  dark_max <- if (n <= 3) 0.5 else 0.7
  colorspace::darken(colour, seq(0, dark_max, length.out = n))
}


# helper function that creates an interactive ggiraph plot with the
# appropriate settings

fis_plot <- function(p, interactive, width, height) {

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
        # for some reason, when I don't set the font family her, a serif
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

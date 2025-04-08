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
      \(x) colorspace::darken(x, seq(0, 0.5, length.out = n_pos))
    ) %>%
    unlist()
  names(cols) <- paste(rep(unique(athletes), each = n_pos),
                       rep(positions, times = n_athletes),
                       sep = "_")
  cols
}



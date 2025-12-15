# Plot athlete's results over time

Plot the results of one or several athletes over time.

## Usage

``` r
plot_ranks_over_time(
  results,
  by = c("discipline", "category", "athlete"),
  time = c("season", "age"),
  pos = 1:3,
  type = c("lines", "bars"),
  cumulative = FALSE,
  interactive = TRUE,
  width = NULL,
  height = NULL
)

plot_results_over_time(
  results,
  by = c("category", "discipline"),
  variable = c("points", "races", "victories", "podiums", "dnf", "position", "top"),
  time = c("season", "age"),
  pos = 1,
  type = c("lines", "bars"),
  relative = FALSE,
  cumulative = FALSE,
  interactive = TRUE,
  width = NULL,
  height = NULL
)
```

## Arguments

- results:

  a tibble with the results of one or more athletes. The tibble for one
  athlete can be created with
  [`query_results()`](https://stibu81.github.io/fisdata/reference/query_results.md)
  and the tibble for multiple athletes can be combined with
  [`dplyr::bind_rows()`](https://dplyr.tidyverse.org/reference/bind_rows.html).

- by:

  variable to groups the plot by. Possible values are "discipline",
  "category", and "athlete". Values are partially matched. Set this
  value to an empty vector ([`c()`](https://rdrr.io/r/base/c.html)) or
  `NA` to create a plot with a single facet.

- time:

  the variable to use for the x-axis. Possible values are "season" and
  "age". The function uses the age at the beginning of the season for
  the entire season.

- pos:

  numeric that controls the summary of ranks. Indicate one or multiple
  break points for the ranks to summarise. The plot will then show the
  counts for the number of ranks that are at least as good as each break
  point and worse than the next better break point.

- type:

  character giving the type of the plot. Use "lines" for a lines plot
  with points and "bars" for a bar plot.

- cumulative:

  should cumulative counts be plotted?

- interactive:

  logical indicating whether an interactive plot (with ggiraph) should
  be returned. If `FALSE`, a static ggplot is returned that can be
  turned into an interactive plot with
  [`ggiraph::girafe()`](https://davidgohel.github.io/ggiraph/reference/girafe.html).

- width, height:

  dimensions for the interactive plot in inches, passed on to
  [`ggiraph::girafe()`](https://davidgohel.github.io/ggiraph/reference/girafe.html).
  The default values are 6 and 5 inches, respectively.

- variable:

  character giving the variable to plot on the y-axis. For "position"
  and "top", the value of the argument "pos" is also relevant: for
  "position", the plot will show the number of times exactly the rank
  given by "pos" was achieved, for "top" the number of times a rank at
  least as good as "pos" was achieved.

- relative:

  use relative scale for points, victories, podiums or dnf?

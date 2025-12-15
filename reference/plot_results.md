# Plot summary of one or more athlete's results

Plot summary of one or more athlete's results

## Usage

``` r
plot_rank_summary(
  results,
  by = c("category", "discipline"),
  pos = 1:3,
  interactive = TRUE,
  width = NULL,
  height = NULL
)

plot_results_summary(
  results,
  by = c("category", "discipline"),
  variable = c("points", "races", "victories", "podiums", "dnf", "position", "top"),
  pos = 1,
  relative = FALSE,
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

  variables to groups the plot by. Possible values are "category" (on
  rows) and "discipline" (on columns). Values are partially matched. Set
  this value to an empty vector ([`c()`](https://rdrr.io/r/base/c.html))
  or `NA` to create a plot with a single facet.

- pos:

  numeric that controls the summary of ranks. It has a slightly
  different meaning for `plot_rank_summary()` and
  `plot_results_summary()`:

  - `plot_rank_summary()`: one or multiple break points for the ranks to
    summarise. The plot will then show the counts for the number of
    ranks that are at least as good as each break point and worse than
    the next better break point.

  - `plot_results_summary()`: the position to show in the plot.
    Depending on the value of "variable", the plot will show the number
    of times exactly this rank (variable = "position") or a rank at
    least as good (variable = "top") was achieved.

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

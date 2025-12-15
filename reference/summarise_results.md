# Summarise athlete's results

Summarise the results of an athlete as they are returned by
[`query_results()`](https://stibu81.github.io/fisdata/reference/query_results.md).

## Usage

``` r
summarise_results(
  results,
  by = c("season", "category", "discipline"),
  show_pos = c(1, 2, 3, 5, 10, 20, 30),
  show_dnf = TRUE,
  show_victories = FALSE,
  show_podiums = TRUE,
  show_races = TRUE,
  show_points = TRUE,
  add_relative = FALSE,
  cumulative = FALSE
)
```

## Arguments

- results:

  athlete's results as returned by
  [`query_results()`](https://stibu81.github.io/fisdata/reference/query_results.md).
  The function can also handle the results from multiple athletes that
  are combined into a single tibble with
  [`dplyr::bind_rows()`](https://dplyr.tidyverse.org/reference/bind_rows.html).

- by:

  variables to groups the results by. Possible values are "season",
  "age", "category", "discipline", "place", and "nation". Values are
  partially matched. In addition, the function always groups by athlete.
  Set this value to an empty vector
  ([`c()`](https://rdrr.io/r/base/c.html)) or `NA` to summarise without
  additional grouping (i.e., only by athlete).

- show_pos:

  numeric that controls the summary of ranks. Indicate the break points
  for the ranks to summarise. The function will then return counts for
  the number of ranks that are at least as good as each break point and
  worse then the next better break point. Set this value to an empty
  vector ([`c()`](https://rdrr.io/r/base/c.html)) or `FALSE` to not
  include the position summaries.

- show_dnf:

  logical, should the races where the athlete did not finish be counted?

- show_victories:

  logical, should the count of victories (rank 1) be returned?

- show_podiums:

  logical, should the count of podiums (ranks 1 to 3) be returned?

- show_races:

  logical, should the number of races be returned?

- show_points:

  logical, should the sum of the cup points be returned?

- add_relative:

  add relative values, i.e., the value divided by the number of races,
  for all summary columns except "races".

- cumulative:

  should a cumulative sum over time be used for all summary variables.
  This has no effect, if not at least one of "season" or "age" is used
  in `by`.

## Value

a `tibble` which always contains `athlete` as its first column. In
addition, it contains the grouping columns indicated by the argument
`by` and possibly one or several columns containing the requested
summaries.

## Examples

``` r
if (FALSE) { # \dontrun{
# get Marco Odermatts World Cup results
odermatt <- query_athletes("odermatt", "marco")
odermatt_res <- query_results(odermatt, category = "WC")

# summarise by category and season
summarise_results(odermatt_res, by = c("category", "season"))

# summarise by category, season, and discipline, only show podiums
summarise_results(odermatt_res, by = c("category", "season", "discipline"),
                  show_pos = 1:3, show_dnf = FALSE, show_races = FALSE,
                  show_points = FALSE)
} # }
```

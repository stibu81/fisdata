# Query Competitions

Query all the competitions, i.e., individual races, for a given event.

## Usage

``` r
query_competitions(event)
```

## Arguments

- event:

  a list or data frame with fields/columns `event_id`, `sector` and
  `place` that describe a *single* event. The easiest way to create such
  a data frame is through the function
  [`query_events()`](https://stibu81.github.io/fisdata/reference/query_events.md).
  This function can return multiple events, but
  [`query_events()`](https://stibu81.github.io/fisdata/reference/query_events.md)
  only returns the results for one event If multiple events are passed,
  only the first one will be used.

## Value

A tibble with the following columns: `place`, `date`, `time`,
`competition`, `sector`, `category`, `gender`, and `race_id`.

## Details

The results are cached such that the same data are only downloaded once
per sessions.

## Examples

``` r
if (FALSE) { # \dontrun{
# find the Wengen alpine skiing races from the season 2024/2025
wengen_2025 <- query_events(sector = "AL", place = "wengen",
                            category = "WC", season = 2025)

# get all the races that took place during the event
query_competitions(wengen_2025)
} # }
```

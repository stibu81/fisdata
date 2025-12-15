# Query Race

Query full results for a race.

## Usage

``` r
query_race(competition)
```

## Arguments

- competition:

  a list or data frame with fields/columns `race_id` and `sector` that
  describe a *single* race. The easiest way to create such a data frame
  is through the functions
  [`query_results()`](https://stibu81.github.io/fisdata/reference/query_results.md)
  or
  [`query_competitions()`](https://stibu81.github.io/fisdata/reference/query_competitions.md).
  These functions can return multiple competitions, but `query_race()`
  only returns the results for one race. If multiple competitions are
  passed, only the first one will be used.

## Value

A tibble with at least the following columns: `rank` (or `order`, if
only the start list has been published), `bib`, `fis_code`, `name`,
`birth_year`, `nation`, `sector`, and `competitor_id`. Depending on the
type of race, there are additional columns like `time`, `run1`, `run2`,
`total_time`, `diff_time`, `fis_points`, and `cup_points`.

## Details

Different types of races may have very different way to display the
results. Some disciplines use time measurements, other use a points
system or even a combination of different systems. In some disciplines,
races involve a single run and a single time measurement, while other
use multiple runs and accordingly have multiple run times and possibly a
total time. The function tries to be flexible in determining the format
that is used for a given race, but it is known to fail for some special
cases (e.g., team races in alpine skiing).

The results are cached such that the same data are only downloaded once
per sessions.

## Examples

``` r
if (FALSE) { # \dontrun{
# the results for a race can be queried by using a specific race of an
# athlete as input. So we get all downhill results for Marco Odermatt.
odermatt <- query_athletes("odermatt", "marco")
odermatt_res <- query_results(odermatt, discipline = "DH")

# show the first of the results
odermatt_res[1, ]

# get the full results for this race
query_race(odermatt_res[1, ])

# Or we can start by querying for an event. The following finds the
# competitions for Wengen 2025
wengen2025 <- query_events(sector = "AL", place = "Wengen", season = 2025)
wengen2025_competitions <- query_competitions(wengen2025)

# get the full results for the downhill competition
library(dplyr)
wengen2025_res <- wengen2025_competitions %>%
  filter(competition == "Downhill") %>%
  query_race()
wengen2025_res

# each entry of the race results can be used to get that athletes full
# results.
query_results(wengen2025_res[1, ])
} # }
```

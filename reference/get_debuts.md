# Get the debut races, podiums or victories for an athlete

Get the debut races, podiums or victories for an athlete

## Usage

``` r
get_debuts(
  athlete,
  category = fd_def("category"),
  discipline = fd_def("discipline"),
  by = c("category", "discipline"),
  type = c("race", "podium", "victory")
)
```

## Arguments

- athlete:

  a list or data frame with fields/columns `competitor_id` and `sector`
  that describe a *single* athlete. The easiest way to create such a
  data frame is through the functions
  [`query_athletes()`](https://stibu81.github.io/fisdata/reference/query_athletes.md),
  [`query_race()`](https://stibu81.github.io/fisdata/reference/query_race.md),
  or
  [`query_standings()`](https://stibu81.github.io/fisdata/reference/query_standings.md).
  These functions can return multiple athletes, but
  [`query_results()`](https://stibu81.github.io/fisdata/reference/query_results.md)
  only returns the results for one athlete. If multiple athletes are
  passed, only the first one will be used.

- category:

  abbreviation of the category of the race, e.g., "WC" for "World Cup".
  Not case-sensitive. See the dataset
  [categories](https://stibu81.github.io/fisdata/reference/categories.md)
  for possible values. If a string not matching a category code is used,
  a similar string is searched for in the description column of
  [categories](https://stibu81.github.io/fisdata/reference/categories.md).

- discipline:

  abbreviation for the discipline, e.g., "DH" for "Downhill". Not case
  sensitive. See the dataset
  [disciplines](https://stibu81.github.io/fisdata/reference/disciplines.md)
  for possible values. If a string not matching a discipline code is
  used, a similar string is searched for in the description column of
  [disciplines](https://stibu81.github.io/fisdata/reference/disciplines.md).

- by:

  variables to groups the results by. Possible values are "category",
  and "discipline". Values are partially matched. Set this value to an
  empty vector ([`c()`](https://rdrr.io/r/base/c.html)) or `NA` to
  summarise without grouping.

- type:

  which type of debut to get: the first race ("race"), the first podium
  ("podium"), or the first victory ("victory").

## Value

A tibble with the following columns: `athlete`, `date`, `place`,
`nation`, `sector`, `category`, `discipline`, `rank`, `fis_points`,
`cup_points`, and `race_id`.

## Examples

``` r
if (FALSE) { # \dontrun{
# get Marco Odermatt's World Cup debuts by discipline
odermatt <- query_athletes("odermatt", "marco")
get_debuts(odermatt, category = "WC")

# get first victory by category
get_debuts(odermatt, by = "category", type = "victory")
} # }
```

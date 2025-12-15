# Query Cup Standings for a Season or an Athlete

Query cup standings, either

- the full standings for a season by sector, category (i.e., the cup in
  this context), and gender, or

- the career standings for an athlete by category.

## Usage

``` r
query_standings(
  sector = fd_def("sector"),
  season = fd_def("season"),
  category = fd_def("category"),
  gender = fd_def("gender"),
  type = c("ranking", "start-list", "nations"),
  athlete = NULL
)
```

## Arguments

- sector:

  abbreviation of the sector, e.g., "AL" for alpine skiing. See the
  dataset
  [sectors](https://stibu81.github.io/fisdata/reference/sectors.md) for
  possible values. For convenience, you can also pass a data frame or
  list describing an athlete (see argument `athlete`).

- season:

  year when the season ended, i.e., 2020 stands for the season
  2019/2020. It is not possible to filter for multiple seasons at once.
  If omitted, results are returned for the current season.

- category:

  abbreviation of the category for the cup, e.g., "WC" for "World Cup".
  See the dataset
  [categories](https://stibu81.github.io/fisdata/reference/categories.md)
  for possible values; note that the standing is only available for some
  of the categories. If an unsupported category is used, the FIS page
  unfortunately returns the standings for a default category, which is
  usually the world cup ("WC").

- gender:

  abbreviation of the gender: "M" for male/men, "F" or "W" for
  female/women. For nations cups (`type = "nations"`), use "A" to get
  the overall nations cup.

- type:

  type of standings to return. Not all types may be supported for all
  categories. Possible values are:

  - `"ranking"`, the default, returns the usual ranking of individual
    athletes which determines the discipline and overall winner of the
    cup.

  - `"start-list"` returns the ranking for the start lists.

  - `"nations"` returns the ranking of the nations cup.

- athlete:

  a list or data frame with fields/columns `competitor_id` and `sector`
  that describe a *single* athlete. The easiest way to create such a
  data frame is through the functions
  [`query_athletes()`](https://stibu81.github.io/fisdata/reference/query_athletes.md),
  [`query_race()`](https://stibu81.github.io/fisdata/reference/query_race.md),
  or `query_standings()`. These functions can return multiple athletes,
  but
  [`query_results()`](https://stibu81.github.io/fisdata/reference/query_results.md)
  only returns the results for one athlete. If multiple athletes are
  passed, only the first one will be used.

  Providing a value for `athlete` will trigger the function to return
  the career standings for this athlete. All arguments except for
  `category` and `type` will be ignored in this case. The value
  `"nations"` for `type` is not allowed.

## Value

When querying for season standings, a tibble with at least the following
columns: `sector`, `athlete`, and `nation`. Except for nations cups,
there are also the columns `brand` and `competitor_id`. When querying
for an athlete's standings, a tibble with at least the columns
`athlete`, `sector`, `category`, and `season`.

Depending on the sector, there are multiple columns giving the rank and
the points for the various disciplines. For example, in alpine skiing
("AL"), the columns `all_rank` and `all_points` give the rank and points
for the overall world cup, while `dh_rank` and `dh_points` give the rank
and points for the downhill world cup.

## Details

All filter arguments are set to `""` by default. Setting an argument to
`""` means that no filtering takes place for this parameter. For those
arguments that have a call to
[`fd_def()`](https://stibu81.github.io/fisdata/reference/set_fisdata_defaults.md)
as their default value, the default value can be globally set using
[`set_fisdata_defaults()`](https://stibu81.github.io/fisdata/reference/set_fisdata_defaults.md).

The results are cached such that the same data are only downloaded once
per sessions.

## Examples

``` r
if (FALSE) { # \dontrun{
# get the standings for the women's alpine skiing world cup 2023/24.
query_standings(sector = "AL", season = 2024,
                category = "WC", gender = "W")

# get the overall nations ranking for the alpine skiing world cup 2024/25.
query_standings(sector = "AL", season = 2025,
                category = "WC", gender = "A",
                type = "nations")

# get the women's start list for the snowboard world cup 2021/22
query_standings(sector = "SB", season = 2022,
                category = "WC", gender = "W",
                type = "start-list")

# get the standings for Marco Odermatt
odermatt <- query_athletes("odermatt", "marco")
query_standings(athlete = odermatt)

# the athlete may also simply be passed as the first argument
query_standings(odermatt)
} # }
```

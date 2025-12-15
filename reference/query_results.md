# Query Results for an Athlete

Query results for an athlete using various filters. Omitting a filter
means that results with any value in that field will be returned.
Filtering is case-insensitive and for `place` string matches are
partial.

## Usage

``` r
query_results(
  athlete,
  season = fd_def("season"),
  category = fd_def("category"),
  place = "",
  discipline = fd_def("discipline"),
  add_age = TRUE
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
  These functions can return multiple athletes, but `query_results()`
  only returns the results for one athlete. If multiple athletes are
  passed, only the first one will be used.

- season:

  year when the season ended, i.e., 2020 stands for the season
  2019/2020. It is not possible to filter for multiple seasons at once.

- category:

  abbreviation of the category of the race, e.g., "WC" for "World Cup".
  See the dataset
  [categories](https://stibu81.github.io/fisdata/reference/categories.md)
  for possible values.

- place:

  location of the race. The API does not support special characters, but
  many are handled automatically (see 'Details').

- discipline:

  abbreviation for the discipline, e.g., "DH" for "Downhill". See the
  dataset
  [disciplines](https://stibu81.github.io/fisdata/reference/disciplines.md)
  for possible values.

- add_age:

  should a column with the athletes age be added for each race? The age
  is given in decimal years. Note that for some athletes, only the birth
  year is known, in which case the age will be estimated.

## Value

A tibble with the following columns: `athlete`, `date`, `place`,
`nation`, `sector`, `category`, `discipline`, `rank`, `fis_points`,
`cup_points`, and `race_id`. If `add_age` is `TRUE`, it also contains
the column `age` after `date`.

## Details

All filter arguments are set to `""` by default. Setting an argument to
`""` means that no filtering takes place for this parameter. For those
arguments that have a call to
[`fd_def()`](https://stibu81.github.io/fisdata/reference/set_fisdata_defaults.md)
as their default value, the default value can be globally set using
[`set_fisdata_defaults()`](https://stibu81.github.io/fisdata/reference/set_fisdata_defaults.md).

The API does not support special character in the field `place`. The
following special characters are handled automatically: à, á, å, ä, æ,
ç, ć, č, ð, é, è, ê, ë, ï, ñ, ø, ó, ő, ö, œ, š, ß, ú, ü, and ž. Other
special characters must be replaced by the suitable substitute by the
user.

The results are cached such that the same data are only downloaded once
per sessions.

## Examples

``` r
if (FALSE) { # \dontrun{
# in order to query an athletes results, we first
# have to obtain the competitor id, which is
# required for the query. This can be conveniently
# done with query_athletes().
odermatt <- query_athletes("odermatt", "marco")

# get all of his results
query_results(odermatt)

# get only World Cup Downhill results from the
# season 2023/2024
query_results(
  odermatt,
  category = "WC",
  season = 2024,
  discipline = "DH"
)

# get all results from Kitzbühel. Note that the
# umlaut is removed in the output.
query_results(odermatt, place = "Kitzbühl")
} # }
```

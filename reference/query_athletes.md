# Query Athletes

Query athletes using various filters. Omitting a filter means that
athletes with any value in that field will be returned. Filtering is
case-insensitive and for `last_name`, `first_name`, and `brand`, string
matching is partial.

## Usage

``` r
query_athletes(
  last_name = "",
  first_name = "",
  sector = fd_def("sector"),
  nation = "",
  gender = fd_def("gender"),
  birth_year = "",
  brand = "",
  active_only = fd_def("active_only")
)
```

## Arguments

- last_name, first_name:

  last and first name. String matching is partial. The API does not
  support special characters, but many are handled automatically (see
  'Details').

- sector:

  abbreviation of the sector, e.g., "AL" for alpine skiing. Not
  case-sensitive. See the dataset
  [sectors](https://stibu81.github.io/fisdata/reference/sectors.md) for
  possible values. If a string not matching a sector code is used, a
  similar string is searched for in the description column of
  [sectors](https://stibu81.github.io/fisdata/reference/sectors.md).

- nation:

  abbreviation of the nation, e.g., "SUI" for Switzerland. The value is
  matched exactly, but not case-sensitive. See the dataset
  [nations](https://stibu81.github.io/fisdata/reference/nations.md) for
  possible values. If a string not matching a country code is used, a
  similar string is searched for in the description column of
  [nations](https://stibu81.github.io/fisdata/reference/nations.md).

- gender:

  abbreviation of the gender: "M" for male/men, "F" or "W" for
  female/women.

- birth_year:

  birth year. This also supports multiple years separated by commas
  (e.g, "1995,1998,2000") or year ranges (e.g., "1990-1995").

- brand:

  ski or snowboard brand used by the athlete. String matching is
  partial. The API does not support special characters, but many are
  handled automatically (see 'Details').

- active_only:

  should the query be restricted to active athletes.

## Value

A tibble with the following columns: `active`, `fis_code`, `name`,
`nation`, `age`, `birthdate`, `gender`, `sector`, `club`, `brand`, and
`competitor_id`.

`active` is a logical indicating whether the athlete is still active.
`age` gives the year as an integer, but this value is often missing.
`birthdate` is returned as a character.

## Details

All filter arguments are set to `""` by default. Setting an argument to
`""` means that no filtering takes place for this parameter. For those
arguments that have a call to
[`fd_def()`](https://stibu81.github.io/fisdata/reference/set_fisdata_defaults.md)
as their default value, the default value can be globally set using
[`set_fisdata_defaults()`](https://stibu81.github.io/fisdata/reference/set_fisdata_defaults.md).

The API does not support special character in the fields `last_name`,
`first_name`, and `brand`. The following special characters are handled
automatically: à, á, å, ä, æ, ç, ć, č, ð, é, è, ê, ë, ï, ñ, ø, ó, ő, ö,
œ, š, ß, ú, ü, and ž. Other special characters must be replaced by the
suitable substitute by the user.

One use of this function is to get the competitor id for an athlete,
which is needed in order to query an athletes results with
[`query_results()`](https://stibu81.github.io/fisdata/reference/query_results.md).

The results are cached such that the same data are only downloaded once
per sessions.

## Examples

``` r
if (FALSE) { # \dontrun{
# find Swiss athletes with last name "Cuche"
query_athletes("cuche", nation = "SUI")

# find French alpine skiers using Rossignol skis
query_athletes(
  sector = "AL",
  nation = "FRA",
  brand = "Rossignol",
  active_only = TRUE
)

# find Loïc Maillard. Note that even if the "ï" may be used in the query,
# the name the name is returned without the special character.
query_athletes("meillard", "loïc")

# the query works the same without the special character
query_athletes("meillard", "loic")
} # }
```

# Get And Set Default Values for Parameters in Querying Functions

`set_fisdata_defaults()` sets default values for common arguments that
will

`reset_fisdata_defaults()` resets all the default values to `""`, which
is the same value they get when the package is loaded.

`get_fisdata_defaults()` shows the currently selected default values.

`fd_def()` returns the current default value for a single parameter;
this function's main use is as default argument in the querying
functions.

## Usage

``` r
set_fisdata_defaults(
  sector = NULL,
  season = NULL,
  gender = NULL,
  category = NULL,
  discipline = NULL,
  active_only = NULL,
  reset = FALSE,
  verbose = interactive()
)

get_fisdata_defaults()

reset_fisdata_defaults()

fd_def(
  name = c("sector", "season", "gender", "category", "discipline", "active_only")
)
```

## Arguments

- sector:

  abbreviation of the sector, e.g., "AL" for alpine skiing. Not
  case-sensitive. See the dataset
  [sectors](https://stibu81.github.io/fisdata/reference/sectors.md) for
  possible values. If a string not matching a sector code is used, a
  similar string is searched for in the description column of
  [sectors](https://stibu81.github.io/fisdata/reference/sectors.md).

- season:

  year when the season ended, i.e., 2020 stands for the season
  2019/2020. It is not possible to filter for multiple seasons at once.

- gender:

  abbreviation of the gender: "M" for male/men, "F" or "W" for
  female/women.

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

- active_only:

  should the query be restricted to active athletes.

- reset:

  if `TRUE`, the defaults are set to those that are passed to the
  function, i.e., all arguments that are omitted are set to `""`. If
  `FALSE`, only those defaults that are passed to the function are
  modified, while all the others are left unchanged.

- verbose:

  should the function generate output about what it does?

- name:

  name of the default argument

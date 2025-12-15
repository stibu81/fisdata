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
  reset = FALSE
)

get_fisdata_defaults()

reset_fisdata_defaults()

fd_def(
  name = c("sector", "season", "gender", "category", "discipline", "active_only")
)
```

## Arguments

- sector:

  abbreviation of the sector, e.g., "AL" for alpine skiing. See the
  dataset
  [sectors](https://stibu81.github.io/fisdata/reference/sectors.md) for
  possible values.

- season:

  year when the season ended, i.e., 2020 stands for the season
  2019/2020. It is not possible to filter for multiple seasons at once.

- gender:

  abbreviation of the gender: "M" for male/men, "F" or "W" for
  female/women.

- category:

  abbreviation of the category of the race, e.g., "WC" for "World Cup".
  See the dataset
  [categories](https://stibu81.github.io/fisdata/reference/categories.md)
  for possible values.

- discipline:

  abbreviation for the discipline, e.g., "DH" for "Downhill". See the
  dataset
  [disciplines](https://stibu81.github.io/fisdata/reference/disciplines.md)
  for possible values.

- active_only:

  should the query be restricted to active athletes.

- reset:

  if `TRUE`, the defaults are set to those that are passed to the
  function, i.e., all arguments that are omitted are set to `""`. If
  `FALSE`, only those defaults that are passed to the function are
  modified, while all the others are left unchanged.

- name:

  name of the default argument

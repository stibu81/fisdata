# Read and Write Defaults from a JSON File

Default settings can be written to a JSON file and read again from this
file. If the file `.fisdata.json` exists in the user's home it is read
automatically when fisdata is attached in an interactive session (see
'Details' for how to configure this behaviour).

## Usage

``` r
write_fisdata_defaults(
  file = "~/.fisdata.json",
  overwrite = FALSE,
  sector = "",
  season = "",
  gender = "",
  category = "",
  discipline = "",
  active_only = FALSE
)

write_current_fisdata_defaults(file = "~/.fisdata.json", overwrite = FALSE)

read_fisdata_defaults(
  file = "~/.fisdata.json",
  apply = TRUE,
  verbose = !apply || interactive()
)
```

## Arguments

- file:

  name of the JSON file to read or write

- overwrite:

  should an existing file be overwritten?

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

- apply:

  should the defaults be applied?

- verbose:

  should the function create output. This defaults to `TRUE` in
  interactive sessions or when `apply` is `FALSE`.

## Value

`write_fisdata_defaults()` and `write_current_fisdata_defaults()` return
the json-string that was written to the file (invisibly).
`read_fisdata_defaults()` returns the default values that were read as a
tibble (invisibly).

## Details

When fisdata is attached in an interactive session, it tries to load
defaults from a file `fisdata.json`. You can use another file by setting
the environment variable `FISDATA_DEFAULTS_FILE` to the path to this
file before attaching fisdata. To do this once, you can use
[`Sys.setenv()`](https://rdrr.io/r/base/Sys.setenv.html), to configure R
to always load a different file, you can set `FISDATA_DEFAULTS_FILE` in
your `.Renviron` file.

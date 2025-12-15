# Query Events

Query events using various filters. Omitting a filter means that events
with any value in that field will be returned. In order to reduce the
number of results, the FIS page automatically restricts the results to
one season or even one month, if only few filters are used (see
'Details'). Filtering is case-insensitive and for `place`, string
matching is partial.

`query_current_events()` queries for currently running events and is
equivalent to calling `query_events()` with today's date.

## Usage

``` r
query_events(
  selection = c("all", "results", "upcoming"),
  sector = fd_def("sector"),
  category = fd_def("category"),
  discipline = fd_def("discipline"),
  gender = fd_def("gender"),
  place = "",
  season = fd_def("season"),
  month = "",
  date = ""
)

query_current_events(
  selection = c("all", "results", "upcoming"),
  sector = fd_def("sector"),
  category = fd_def("category"),
  discipline = fd_def("discipline"),
  gender = fd_def("gender"),
  place = ""
)
```

## Arguments

- selection:

  which events should be returned: past events, where results are
  available ("results") or upcoming events ("upcoming") or both ("all")?

- sector:

  abbreviation of the sector, e.g., "AL" for alpine skiing. See the
  dataset
  [sectors](https://stibu81.github.io/fisdata/reference/sectors.md) for
  possible values.

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

- gender:

  abbreviation of the gender: "M" for male/men, "F" or "W" for
  female/women.

- place:

  location of the race. The API does not support special characters, but
  many are handled automatically (see 'Details').

- season:

  year when the season ended, i.e., 2020 stands for the season
  2019/2020. It is not possible to filter for multiple seasons at once.

- month:

  numeric giving the month of the year to filter for. The month is only
  considered when also season is given. Not that the season runs from
  July to June, such that, say, month 11 in season 2025 is translated to
  November 2024.

- date:

  date at which the event takes place. This must either be a `Date` or
  `POSIXct` object or a string in the format "%Y-%m-%d". If `date` is
  used, `season` and `month` are ignored.

## Value

A tibble with the following columns: `start_date`, `end_date`, `place`,
`nation`, `sector`, `categories`, `disciplines`, `genders`, `cancelled`,
and `event_id`.

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

Results are always limited to events from a single season. If no season
is explicitly provided, the current season is used. If no or few filters
are applied, the results are further limited to a single month. If no
month is explicitly specified, the current month is used.

The results are cached such that the same data are only downloaded once
per sessions.

## Examples

``` r
if (FALSE) { # \dontrun{
# query alpine skiing world cup events in February 2024
query_events(sector = "AL", category = "WC", season = 2024, month = 2)

# query ski jumping events on the large hill in the season 2020/21
query_events(sector = "JP", discipline = "LH", season = 2021)

# query cross country events on 2023-03-07
query_events(sector = "CC", date = "2023-03-07")

# calling query_events() without any argument returns all events from the
# current month
query_events()
} # }
```

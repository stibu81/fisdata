# Show URL associated With a Query

All the functions `query_*()` call a URL on the FIS web page to collect
their data. `show_url()` returns the URL that was used to produce a
table of fisdata-results.

## Usage

``` r
show_url(fisdata_df)
```

## Arguments

- fisdata_df:

  a table of fisdata-results produced by one of the
  `query_*()`-functions.

## Value

a character vector of length one with the URL that was used to create
the table. In an interactive session it also copies the URL to the
clipboard as a side effect.

## Details

If run from an interactive session, the URL is also copied into the
clipboard such that it can be pasted into a browser.

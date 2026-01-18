# Show or Browse URL Associated With a Query

All the functions `query_*()` call a URL on the FIS web page to collect
their data. `show_url()` returns the URL that was used to produce a
table of fisdata-results. `browse_url()` opens the URL in a browser.

## Usage

``` r
show_url(fisdata_df)

browse_url(fisdata_df, browser = getOption("browser"))
```

## Arguments

- fisdata_df:

  a table of fisdata-results produced by one of the
  `query_*()`-functions.

- browser:

  a character string giving the name of the browser to be used. If
  omitted, the default browser is used. See
  [`utils::browseURL()`](https://rdrr.io/r/utils/browseURL.html) for
  details.

## Value

`show_url()` returns a character vector of length one with the URL that
was used to create the table. In an interactive session it also copies
the URL to the clipboard as a side effect.

`browse_url()` returns `NULL` invisibly and opens the URL in a browser
as a side effect.

## Details

If run from an interactive session, `show_url()` also copies the URL
into the clipboard such that it can be pasted into a browser.

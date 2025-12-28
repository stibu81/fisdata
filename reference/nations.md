# Table of IOC Country Codes

This dataset contains all current and some historic IOC country codes.
These codes can be used to filter for a specific nation in
[`query_athletes()`](https://stibu81.github.io/fisdata/reference/query_athletes.md).

## Usage

``` r
nations
```

## Format

A data frame with 223 rows and 3 variables:

- code:

  IOC country code consisting of three capital letters

- description:

  name of the country

- current:

  is this a code that is currently in use?

## Source

<https://en.wikipedia.org/wiki/List_of_IOC_country_codes>

Section "Current NOCs" for the countries with `current = TRUE` and
section "Historic NOCs and teams, Codes still in use" for those with
`current = FALSE`.

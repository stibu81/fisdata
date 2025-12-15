# Table of Codes for Disciplines

This dataset contains the codes for the disciplines for which data can
be obtained from the FIS webpage. These codes can be used to filter for
a specific discipline in
[`query_results()`](https://stibu81.github.io/fisdata/reference/query_results.md).
Note that the available disciplines depend on the sector.

## Usage

``` r
disciplines
```

## Format

A data frame with 152 rows and 4 variables:

- sector:

  the code of the sector, to which the discipline belongs

- sector_description:

  the clear-text description of the sector

- code:

  code of the category. They are alphanumeric, starting with a capital
  letter or a digit. Most are 2 or 3 characters long, but up to six
  characters are possible.

- description:

  clear text description of the category

# Table of Codes for Categories

This dataset contains the codes for the race categories for which data
can be obtained from the FIS webpage. These codes can be used to filter
for a specific category in
[`query_results()`](https://stibu81.github.io/fisdata/reference/query_results.md).

## Usage

``` r
categories
```

## Format

A data frame with 97 rows and 2 variables:

- code:

  code of the category. Most consist of two to four capital letters, but
  some are longer (up to 8 letters) or contain digits.

- description:

  clear text description of the category

## Details

The categories are ordered as follows:

- Olympic Games

- World Championships

- World Cups

- Other Cups (excluding Youth & Masters)

- Everything else

The latter two groups involve many categories that are ordered
alphabetically by the code within the group.

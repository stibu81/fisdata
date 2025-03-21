
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fisdata <a href="https://stibu81.github.io/fisdata/"><img src="man/figures/logo.png" align="right" width="175" alt="fisdata website" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/stibu81/fisdata/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/stibu81/fisdata/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/stibu81/fisdata/graph/badge.svg)](https://app.codecov.io/gh/stibu81/fisdata)
<!-- badges: end -->

fisdata makes it easy to download data from the [FIS
webpage](https://www.fis-ski.com) into tibbles. It provides a variety of
functions to query different types of data like athletes, events, or
race results.

## Installation

You can install the development version of fisdata from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("stibu81/fisdata")
```

## Available Querying Functions

fisdata offers the following functions to query different types of data:

- `query_athletes()`: query athletes by name and other attributes and
  obtain a table of matching athletes.
- `query_results()`: query all competition results for a single athlete.
- `query_race()`: get the full results for a single competition.
- `query_events()`: query events by date, place, and other attributes.
- `query_competitions()`: obtain all individual competitions that are
  associated with an event.
- `query_standings()`: get the cup standings with ranks and points per
  discipline.

All these functions are cached, that is, if they are called multiple
times in the same session, the data is downloaded only once. This leads
to better performance and reduces the number of requests that are sent
to the FIS webpage.

## Example Queries

Use `query_athletes()` and `query_results()` to get Didier Cuche’s full
downhill results:

``` r
library(fisdata)
library(dplyr)

query_athletes("cuche", "didier") %>% 
  query_results(discipline = "DH") %>% 
  select(athlete:place, category:rank, cup_points)
#> # A tibble: 303 × 7
#>    athlete      date       place      category  discipline  rank cup_points
#>    <chr>        <date>     <chr>      <chr>     <chr>      <int>      <dbl>
#>  1 Cuche Didier 2012-03-14 Schladming World Cup Downhill      17         NA
#>  2 Cuche Didier 2012-03-13 Schladming Training  Downhill       1         NA
#>  3 Cuche Didier 2012-03-03 Kvitfjell  World Cup Downhill      10         26
#>  4 Cuche Didier 2012-03-01 Kvitfjell  Training  Downhill       2         NA
#>  5 Cuche Didier 2012-02-29 Kvitfjell  Training  Downhill       3         NA
#>  6 Cuche Didier 2012-02-11 Sochi      World Cup Downhill      12         22
#>  7 Cuche Didier 2012-02-10 Sochi      Training  Downhill       7         NA
#>  8 Cuche Didier 2012-02-08 Sochi      Training  Downhill       2         NA
#>  9 Cuche Didier 2012-02-04 Chamonix   World Cup Downhill       7         36
#> 10 Cuche Didier 2012-02-03 Chamonix   World Cup Downhill       3         60
#> # ℹ 293 more rows
```

Use `query_events()`, `query_competitions()` and `query_race()` to get
the full results of the Wengen Downhill in 2025:

``` r
query_events(sector = "AL", place = "wengen", season = 2025) %>% 
  query_competitions() %>% 
  filter(competition == "Downhill") %>% 
  query_race() %>% 
  select(rank, bib, name:diff_time)
#> # A tibble: 48 × 8
#>     rank   bib name              brand     birth_year nation time      diff_time
#>    <int> <int> <chr>             <chr>          <int> <chr>  <Period>  <Period> 
#>  1     1    13 Odermatt Marco    Stoeckli        1997 SUI    2M 22.58S 0S       
#>  2     2    12 Von Allmen Franjo Head            2001 SUI    2M 22.95S 0.37S    
#>  3     3     1 Hrobat Miha       Atomic          1995 SLO    2M 23.15S 0.57S    
#>  4     4     6 Paris Dominik     Nordica         1989 ITA    2M 23.27S 0.69S    
#>  5     5     7 Alexander Cameron Rossignol       1997 CAN    2M 23.29S 0.71S    
#>  6     6    14 Bennett Bryce     Fischer         1992 USA    2M 23.41S 0.83S    
#>  7     7     9 Murisier Justin   Head            1992 SUI    2M 23.76S 1.18S    
#>  8     8    37 Roesti Lars       Stoeckli        1998 SUI    2M 23.85S 1.27S    
#>  9     9    16 Crawford James    Head            1997 CAN    2M 23.86S 1.28S    
#> 10    10     3 Schieder Florian  Atomic          1995 ITA    2M 23.95S 1.37S    
#> # ℹ 38 more rows
```

Use `query_standings()` to get the overall and downhill standings of the
men’s alpine skiing world cup in the season 2022/23:

``` r
query_standings(sector = "AL", season = 2023,
                category = "WC", gender = "M") %>% 
  select(athlete, nation, all_rank:dh_points)
#> # A tibble: 160 × 6
#>    athlete                 nation all_rank all_points dh_rank dh_points
#>    <chr>                   <chr>     <int>      <int>   <int>     <int>
#>  1 Odermatt Marco          SUI           1       2042       3       462
#>  2 Kilde Aleksander Aamodt NOR           2       1340       1       760
#>  3 Kristoffersen Henrik    NOR           3       1154      NA        NA
#>  4 Braathen Lucas          NOR           4        954      NA        NA
#>  5 Kriechmayr Vincent      AUT           5        953       2       614
#>  6 Meillard Loic           SUI           6        877      NA        NA
#>  7 Schwarz Marco           AUT           7        863      31        64
#>  8 Pinturault Alexis       FRA           8        839      NA        NA
#>  9 Feller Manuel           AUT           9        546      NA        NA
#> 10 Zenhaeusern Ramon       SUI          10        467      NA        NA
#> # ℹ 150 more rows
```

## Learn more

- Get started with `vignette("fisdata")` which can also be found
  [here](https://stibu81.github.io/fisdata/articles/fisdata.html).

- Browse the full
  [reference](https://stibu81.github.io/fisdata/reference/) for
  functions and datasets.

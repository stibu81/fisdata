
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fisdata <img src="man/figures/fisdata_logo.png" align="right" width="175" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/stibu81/fisdata/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/stibu81/fisdata/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/stibu81/fisdata/graph/badge.svg)](https://app.codecov.io/gh/stibu81/fisdata)
<!-- badges: end -->

fisdata makes it easy to download data from the [FIS
webpage](https://www.fis-ski.com) into tibbles.

## Installation

You can install the development version of fisdata from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("stibu81/fisdata")
```

## Available Querying Functions

fisdata currently offers three functions to query different types of
data:

- `query_athletes()`: query athletes by name and other attributes and
  obtain a table of matching athletes.
- `query_results()`: query all race results for a single athlete.
- `query_race()`: obtain the full results for a single race.

## Running a Query

Since athletes are identified by a Competitor-ID and races by a Race-ID
that are usually not known to the user, it is generally easiest to start
a query by finding an athlete. For example, the following call gets the
information for Didier Cuche:

``` r
library(fisdata)
library(dplyr)

cuche <- query_athletes("cuche", "didier")
cuche %>% 
  select(active:nation, sector, brand, competitor_id)
#> # A tibble: 1 × 7
#>   active fis_code name         nation sector brand competitor_id
#>   <lgl>  <chr>    <chr>        <chr>  <chr>  <chr> <chr>        
#> 1 FALSE  510030   Cuche Didier SUI    AL     Head  11795
```

The result includes the `competitor_id`, which is required as input in
order to query an athlete’s results.

With the object returned by `query_athletes()`, it is now possible to
query all the race result of an athlete. Note that `query_results()`
must be called with a single athlete. The following query only obtains
the results in downhill races:

``` r
cuche_res <- query_results(cuche, discipline = "DH")
cuche_res %>% 
  select(athlete:place, category:rank, race_id)
#> # A tibble: 303 × 7
#>    athlete      date       place      category  discipline  rank race_id
#>    <chr>        <date>     <chr>      <chr>     <chr>      <int> <chr>  
#>  1 Cuche Didier 2012-03-14 Schladming World Cup Downhill      17 66746  
#>  2 Cuche Didier 2012-03-13 Schladming Training  Downhill       1 66744  
#>  3 Cuche Didier 2012-03-03 Kvitfjell  World Cup Downhill      10 66811  
#>  4 Cuche Didier 2012-03-01 Kvitfjell  Training  Downhill       2 66809  
#>  5 Cuche Didier 2012-02-29 Kvitfjell  Training  Downhill       3 66810  
#>  6 Cuche Didier 2012-02-11 Sochi      World Cup Downhill      12 66801  
#>  7 Cuche Didier 2012-02-10 Sochi      Training  Downhill       7 66800  
#>  8 Cuche Didier 2012-02-08 Sochi      Training  Downhill       2 66798  
#>  9 Cuche Didier 2012-02-04 Chamonix   World Cup Downhill       7 66795  
#> 10 Cuche Didier 2012-02-03 Chamonix   World Cup Downhill       3 66767  
#> # ℹ 293 more rows
```

The result includes the `race_id`, which is required as input in order
to query the full results of a race.

By extracting one of the races from the table, one can now obtain the
full results for that race. The following code gets the full result for
Didier Cuche’s last victory in Wengen:

``` r
wengen_res <- cuche_res %>% 
  filter(place == "Wengen", rank == 1) %>% 
  head(n = 1) %>%
  query_race()
wengen_res
#> # A tibble: 70 × 8
#>     rank   bib fis_code name               birth_year nation time      diff_time
#>    <int> <int> <chr>    <chr>                   <int> <chr>  <Period>  <Period> 
#>  1     1    18 510030   Cuche Didier             1974 SUI    1M 50.31S 0S       
#>  2     2    12 292514   Heel Werner              1982 ITA    1M 51.17S 0.86S    
#>  3     3    15 511313   Janka Carlo              1986 SUI    1M 51.52S 1.21S    
#>  4     4     1 560332   Jerman Andrej            1978 SLO    1M 51.58S 1.27S    
#>  5     5     3 533866   Nyman Steven             1982 USA    1M 51.67S 1.36S    
#>  6     6    14 51005    Scheiber Mario           1983 AUT    1M 51.76S 1.45S    
#>  7     7    28 50858    Streitberger Georg       1981 AUT    1M 51.77S 1.46S    
#>  8     8    16 50041    Walchhofer Michael       1975 AUT    1M 51.79S 1.48S    
#>  9     8    11 50753    Kroell Klaus             1980 AUT    1M 51.79S 1.48S    
#> 10    10    25 293006   Innerhofer Christ…       1984 ITA    1M 51.85S 1.54S    
#> # ℹ 60 more rows
```

Note that the objects created by the querying functions always include
the URL that was downloaded. This URL can be obtained as follows:

``` r
show_url(cuche_res)
#> https://www.fis-ski.com/DB/general/athlete-biography.html?sectorcode=AL&seasoncode=&competitorid=11795&type=result&categorycode=&sort=&place=&disciplinecode=DH&position=&limit=2000
```

You can copy this address into a browser in order to see the same data
as they are presented on the FIS web site. To make this as easy as
possible, `show_url()` automatically copies the URL into the clip board,
when called from an interactive R session.

## Known Limitations

Querying athletes and results is expected to work for all sectors and
disciplines. Querying races, however, is more difficult, since different
types of races have their results rendered in different form on the FIS
web site. fisdata is able to handle the results of many common types of
races but it is expected to fail for some types that are not yet
covered. For example, it usually cannot handle team races:

``` r
query_athletes("von allmen", "franjo") %>% 
  query_results(category = "WSC") %>% 
  filter(discipline == "Team Combined") %>% 
  query_race()
#> Warning in query_race(.): ! The data contains some fields unknown to fisdata.
#> ℹ Affected column: 'name'
#> ! These columns might not be processed as expected.
#> Warning in process_race_column(name, race_df): NAs introduced by coercion
#> Warning in process_race_column(name, race_df): NAs introduced by coercion
#> Warning in process_race_column(name, race_df): NAs introduced by coercion
#> Error in `dplyr::as_tibble()`:
#> ! Column names `nation` and `time` must not be duplicated.
#> Use `.name_repair` to specify repair.
#> Caused by error in `repaired_names()`:
#> ! Names must be unique.
#> ✖ These names are duplicated:
#>   * "nation" at locations 7 and 8.
#>   * "time" at locations 9 and 10.
```

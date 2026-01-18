# Get an Image of an Athlete

Download the image of an athlete from the FIS page. Images are not
available for all athletes.

## Usage

``` r
get_athlete_image(athlete, file = NULL)
```

## Arguments

- athlete:

  a list or data frame with the field/column `competitor_id` that
  describe a *single* athlete. The easiest way to create such a data
  frame is through the functions
  [`query_athletes()`](https://stibu81.github.io/fisdata/reference/query_athletes.md),
  [`query_race()`](https://stibu81.github.io/fisdata/reference/query_race.md),
  or
  [`query_standings()`](https://stibu81.github.io/fisdata/reference/query_standings.md).
  These functions can return multiple athletes, but
  `get_athlete_image()` only downloads the image for one athlete. If
  multiple athletes are passed, only the first one will be used.

- file:

  if given, the image file will be stored to the given path. The image
  files are png or jpg and the file ending will be added automatically
  depending on the file type. Any user provided file ending will be
  ignored.

## Value

`NULL` invisibly. As a side effect, the image is displayed and, if
`file` is given, stored to the requested path.

## Details

The image resolution is 100 x 100.

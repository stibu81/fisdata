# Play Athlete's Name in Browser

For some athlete's, an audio file where they speak their name is
available on the FIS page. This functions opens that page in the
browser.

## Usage

``` r
play_athlete_name(athlete, file = NULL)
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
  `play_athlete_name()` only plays the audio file for one athlete. If
  multiple athletes are passed, only the first one will be used.

- file:

  if given, the audio file will be stored to the given path. The file is
  in the mp3 format and the file ending will be added automatically. Any
  user provided file ending will be ignored.

## Value

`NULL` invisibly. As a side effect, the mp3 file is played in the
browser (if it exists) and, if `file` is given, stored to the requested
path.

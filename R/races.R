#' Query Race
#'
#' Query full results for a race.
#'
#' @param competition a list or data frame with fields/columns `race_id` and
#'  `sector` that describe a *single* race. The easiest way to create
#'  such a data frame is through the functions [query_results()] or
#'  [`query_competitions()`]. These functions can return multiple competitions,
#'  but `query_race()` only returns the results for one race.
#'  If multiple competitions are passed, only the first one will be used.
#'
#' @details
#' Different types of races may have very different way to display the results.
#' Some disciplines use time measurements, other use a points system or even
#' a combination of different systems. In some disciplines, races involve a
#' single run and a single time measurement, while other use multiple
#' runs and accordingly have multiple run times and possibly a total time.
#' The function tries to be flexible in determining the format that is used
#' for a given race, but it is known to fail for some special cases (e.g.,
#' team races in alpine skiing).
#'
#' The results are cached such that the same data are only downloaded once
#' per sessions.
#'
#' @returns
#' A tibble with at least the following columns: `rank` (or `order`, if only
#' the start list has been published), `bib`, `fis_code`,
#' `name`, `birth_year`, `nation`, `sector`, and `competitor_id`.
#' Depending on the type of race, there are additional columns like
#' `time`, `run1`, `run2`, `total_time`, `diff_time`, `fis_points`,
#' and `cup_points`.
#'
#' @examples
#' \dontrun{
#' # the results for a race can be queried by using a specific race of an
#' # athlete as input. So we get all downhill results for Marco Odermatt.
#' odermatt <- query_athletes("odermatt", "marco")
#' odermatt_res <- query_results(odermatt, discipline = "DH")
#'
#' # show the first of the results
#' odermatt_res[1, ]
#'
#' # get the full results for this race
#' query_race(odermatt_res[1, ])
#'
#' # Or we can start by querying for an event. The following finds the
#' # competitions for Wengen 2025
#' wengen2025 <- query_events(sector = "AL", place = "Wengen", season = 2025)
#' wengen2025_competitions <- query_competitions(wengen2025)
#'
#' # get the full results for the downhill competition
#' library(dplyr)
#' wengen2025_res <- wengen2025_competitions %>%
#'   filter(competition == "Downhill") %>%
#'   query_race()
#' wengen2025_res
#'
#' # each entry of the race results can be used to get that athletes full
#' # results.
#' query_results(wengen2025_res[1, ])
#' }
#'
#' @export

query_race <- function(competition) {

  competition <- ensure_one_result(competition)

  url <- get_races_url(competition)
  race <- extract_race(url) %>%
    dplyr::mutate(sector = competition$sector, .before = "competitor_id")

  attr(race, "url") <- url

  race
}


# ensure that only one result is passed on to the processing in query_race()
ensure_one_result <- function(result, error_call = rlang::caller_env()) {

  # result may be a list => make sure it is a tibble
  result <- dplyr::as_tibble(result)

  # if there are no athletes, abort
  if (nrow(result) == 0) {
    cli::cli_abort(
      c("x" = "No result was passed to argument 'result'.",
        "i" = "Pass exactly one result."),
      call = error_call
    )
  }

  # if there are multiple rows, warn and only keep the first one
  if (nrow(result) > 1) {
    result <- result[1, ]
    cli::cli_warn(
      c("!" = "Multiple results were passed to argument 'result'.",
        "i" = "Only results for the first one ({result$discipline}, {result$place}) are returned."),
      call = error_call
    )
  }

  result

}


get_races_url <- function(result) {

  race_id <- result$race_id
  sector <- result$sector

  glue::glue(
    "{fis_db_url}/results.html?",
    "sectorcode={sector}&raceid={race_id}"
  )
}


extract_race <- function(url, error_call = rlang::caller_env()) {

  cached <- get_cache(url)
  if (!cachem::is.key_missing(cached)) {
    return(cached)
  }

  html <- rvest::read_html(url)

  table_rows <- html %>%
    rvest::html_element(css = "div.table__body#events-info-results") %>%
    rvest::html_elements(css = "a.table-row")

  # if there are no rows, return an empty table with the columns that are
  # always present
  empty_df <- get_empty_race_df()
  if (length(table_rows) == 0) {
    set_cache(url, empty_df)
    return(empty_df)
  }

  # extract the results data by parsing the entire container-div
  race <- table_rows %>%
    rvest::html_elements(css = "div.container") %>%
    rvest::html_text2() %>%
    stringr::str_split("\n")

  # the competitor-id is required in order to query the results for the athlete
  competitor_ids <- extract_ids(table_rows, "competitor")

  # determine the column names of the result tibble
  out_names <- get_race_column_names(html, error_call = error_call)

  # create data frame
  race_df <- race %>%
    purrr::map(
      function(a) {
        a %>%
          tibble::as_tibble_row(.name_repair = "minimal") %>%
          magrittr::set_names(out_names[seq_along(a)])
      }
    ) %>%
    dplyr::bind_rows()

  # process all the columns based on their name
  race_df <- purrr::map(
      out_names,
      \(name) process_race_column(name, race_df)
    ) %>%
    purrr::set_names(out_names) %>%
    dplyr::as_tibble() %>%
    dplyr::mutate(competitor_id = competitor_ids)

  set_cache(url, race_df)

  race_df
}


get_empty_race_df <- function() {
  tibble::tibble(
    rank = integer(),
    bib = integer(),
    fis_code = character(),
    name = character(),
    birth_year = integer(),
    nation = character(),
    competitor_id = character()
  )
}

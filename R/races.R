#' Query Race
#'
#' Query full results for a race.
#'
#' @param result a list or data frame with fields/columns `race_id` and
#'  `sector` that describe a *single* race. The easiest way to create
#'  such a data frame is through the function [query_results()]. This function
#'  can return multiple results, but `query_race()` only returns the
#'  results for one race. If multiple results are passed, only the first
#'  one will be used.
#'
#' @details
#' This function does not yet work for all sectors. It has been successfully
#' tested for Cross-Country ("CC"), Alpine Skiing ("AL"),
#' Nordic Combined ("NK"), and for some disciplines in Snowboard ("SB").
#' It may fail or give incorrect results for any other sector.
#' In particular, the function is expected to fail for races where the ranking
#' is not done through a time measurement as, e.g., in Ski Jumping ("JP").
#'
#' @returns
#' A tibble with at least the following columns: `rank`, `bib`, `fis_code`,
#' `name`, `birth_year`, and `nation`. Depending on the type of race, there are
#' be additional columns like `time`, `run1`, `run2`, `total_time`, `diff_time`,
#' `fis_points`, and `cup_points`.
#'
#' @examples
#' \dontrun{
#' # the results for a race can be queried by using a specific race of an
#' # athlete as input. So we get all results for Marco Odermatt.
#' odermatt <- query_athletes("odermatt", "marco")
#' odermatt_res <- query_results(odermatt)
#'
#' # show the first of the results
#' odermatt_res[1, ]
#'
#' # get the full results for this race
#' query_race(odermatt_res[1, ])
#' }
#'
#'
#' @export

query_race <- function(result) {

  result <- ensure_one_result(result)

  url <- get_races_url(result)
  race <- extract_race(url)

  attr(race, "url") <- url

  race
}


extract_race <- function(url, error_call = rlang::caller_env()) {

  html <- rvest::read_html(url)

  table_rows <- html %>%
    rvest::html_element(css = "div.table__body#events-info-results") %>%
    rvest::html_elements(css = "a.table-row")

  # if there are no rows, return an empty table with the columns that are
  # always present
  empty_df <- get_empty_race_df()
  if (length(table_rows) == 0) {
    return(empty_df)
  }

  # extract the results data by parsing the entire container-div
  race <- table_rows %>%
    rvest::html_elements(css = "div.container") %>%
    rvest::html_text2() %>%
    stringr::str_split("\n")

  # the competitor-id is required in order to query the results for the athlete
  # it is only contained in the link
  competitor_ids <- table_rows %>%
    rvest::html_attr("href") %>%
    stringr::str_extract("competitorid=(\\d+)", group = 1)

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
  purrr::map(
      out_names,
      \(name) process_race_column(name, race_df)
    ) %>%
    purrr::set_names(out_names) %>%
    dplyr::as_tibble()
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


get_empty_race_df <- function() {
  tibble::tibble(
    rank = integer(),
    bib = integer(),
    fis_code = character(),
    name = character(),
    birth_year = integer(),
    nation = character(),
  )
}

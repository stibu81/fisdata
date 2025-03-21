#' Query Competitions
#'
#' Query all the competitions, i.e., individual races, for a given event.
#'
#' @param event a list or data frame with fields/columns `event_id`,
#'  `sector` and `place` that describe a *single* event. The easiest way to
#'  create such a data frame is through the function [query_events()].
#'  This function can return multiple events, but `query_events()` only
#'  returns the results for one event If multiple events are passed, only
#'  the first one will be used.
#'
#' The results are cached such that the same data are only downloaded once
#' per sessions.
#'
#' @returns
#' A tibble with the following columns: `place`, `date`, `time`, `competition`,
#' `sector`, `category`, `gender`, and `race_id`.
#'
#' @examples
#' \dontrun{
#' # find the Wengen alpine skiing races from the season 2024/2025
#' wengen_2025 <- query_events(sector = "AL", place = "wengen",
#'                             category = "WC", season = 2025)
#'
#' # get all the races that took place during the event
#' query_competitions(wengen_2025)
#' }
#'
#' @export

query_competitions <- function(event) {

  event <- ensure_one_event(event)

  url <- get_competitions_url(event)
  competitions <- extract_competitions(url) %>%
    dplyr::mutate(sector = event$sector, .after = "competition") %>%
    dplyr::mutate(place = event$place, .before = "date")

  attr(competitions, "url") <- url

  competitions

}


# ensure that only one event is passed on to the processing
# in query_competitions()
ensure_one_event <- function(event, error_call = rlang::caller_env()) {

  # event may be a list => make sure it is a tibble
  event <- dplyr::as_tibble(event)

  # if there are no events, abort
  if (nrow(event) == 0) {
    cli::cli_abort(
      c("x" = "No event was passed to argument 'event'.",
        "i" = "Pass exactly one event"),
      call = error_call
    )
  }

  # if there are multiple rows, warn and only keep the first one
  if (nrow(event) > 1) {
    event <- event[1, ]
    cli::cli_warn(
      c("!" = "Multiple events were passed to argument 'event'.",
        "i" = "Only results for the first one ({event$place}) are returned."),
      call = error_call
    )
  }

  event

}


get_competitions_url <- function(event) {

  event_id <- event$event_id
  sector <- event$sector

  glue::glue(
    "{fis_db_url}/event-details.html?",
    "sectorcode={sector}&eventid={event_id}"
  )
}


extract_competitions <- function(url) {

  cached <- get_cache(url)
  if (!cachem::is.key_missing(cached)) {
    return(cached)
  }

  table_rows <- url %>%
    rvest::read_html() %>%
    rvest::html_element(css = "div.table__body") %>%
    rvest::html_elements(css = "div.table-row")

  # if there are no rows, return an empty table
  empty_df <- get_empty_competitions_df()
  if (length(table_rows) == 0) {
    set_cache(url, empty_df)
    return(empty_df)
  }

  # here, simply extracting the text from the containers does not work.
  # So, we first extract the containers here.
  containers <- table_rows %>%
    rvest::html_elements(css = "div.container")

  # extract date and time separately, because date-time is empty for cancelled
  # race
  date <- containers %>%
    rvest::html_element("div.timezone-date") %>%
    rvest::html_attr("data-date") %>%
    as.Date()
  time <- containers %>%
    rvest::html_element("div.timezone-date") %>%
    rvest::html_attr("data-time") %>%
    dplyr::if_else(. == "", NA_character_, .)

  competition_types <- containers %>%
    rvest::html_element("div.clip") %>%
      rvest::html_text2()

  categories <- containers %>%
    rvest::html_element("div.g-row") %>%
    rvest::html_element("a.g-sm-8") %>%
    rvest::html_element("div.g-row") %>%
    rvest::html_element("div.g-xs-12") %>%
    rvest::html_text2()

  gender <- containers %>%
    rvest::html_element("div.gender__item") %>%
    rvest::html_text2()

  # the race-id is required in order to query the results of the race
  # it is only contained in the link
  race_ids <- extract_ids(table_rows, "race")

  # create data frame
  competitions_df <- dplyr::tibble(
    date = date,
    time = time,
    competition = competition_types,
    category = categories,
    gender = gender,
    cancelled = is_cancelled(table_rows),
    race_id = race_ids
  )

  set_cache(url, competitions_df)

  competitions_df
}


get_empty_competitions_df <- function() {
  tibble::tibble(
    date = as.Date(character()),
    time = character(),
    competition = character(),
    sector = character(),
    category = character(),
    gender = character(),
    cancelled = logical(),
    race_id = character()
  )
}

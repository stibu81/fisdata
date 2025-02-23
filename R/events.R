#' Query Events
#'
#' @param selection which events should be returned: past events, where results
#'  are available ("results") or upcoming events ("upcoming") or both ("all")?
#' @param date date at which the event takes place.
#' @inheritParams query_athletes
#' @inheritParams query_results
#'
#' @details
#' The API does not support special character in the field `place`.
#' The following special characters are handled
#' automatically: à, á, å, ä, æ, ç, ć, č, ð, é, è, ê, ë, ï, ñ, ø, ó, ő, ö,
#' œ, š, ß, ú, ü, and ž.
#' Other special characters must be replaced by the suitable
#' substitute by the user.
#'
#' @returns
#' A tibble.
#'
#' @export

query_events <- function(selection = c("all", "results", "upcoming"),
                         sector = "",
                         category = "",
                         discipline = "",
                         gender = "",
                         place = "",
                         season = "",
                         date = "") {

  url <- get_events_url(selection, sector, category, discipline, gender,
                        place, season, date)

  events <- extract_events(url)

  # add the url as an attribute
  attr(events, "url") <- url

  events

}


get_events_url <- function(selection = c("all", "results", "upcoming"),
                           sector = "",
                           category = "",
                           discipline = "",
                           gender = "",
                           place = "",
                           season = "",
                           date = "",
                           error_call = rlang::caller_env()) {

  selection <- match.arg(selection)
  if (selection == "all") selection <- ""

  # gender is output as "F", but queried as "W"
  if (gender == "F") gender <- "W"

  # if an invalid sector is used, the FIS-page returns results for all sectors.
  # to avoid this, catch invalid sectors here.
  if (!toupper(sector) %in% c("", fisdata::sectors$code)) {
    cli::cli_abort("'{sector}' is not a valid sector.",
                   call = error_call)
  }

  glue::glue(
    "{fis_db_url}/calendar-results.html?",
    "eventselection={selection}&place={replace_special_chars(place)}",
    "&sectorcode={sector}&seasoncode={season}&categorycode={category}&",
    "disciplinecode={discipline}&gendercode={gender}&racedate={date}&",
    "racecodex=&nationcode="
  )
}


extract_events <- function(url) {

 table_rows <- url %>%
    rvest::read_html() %>%
    rvest::html_element(css = "div.table__body") %>%
    rvest::html_elements(css = "div.table-row")

  # if there are no rows, return an empty table
  empty_df <- get_empty_events_df()
  if (length(table_rows) == 0) {
    return(empty_df)
  }

  # because of the multirow parts in the table, we need to extract the "a"
  # elements and only then convert to text, to make the structure clear.
  events <- table_rows %>%
    rvest::html_elements(css = "div.container") %>%
    purrr::map(\(x) rvest::html_elements(x, "a")) %>%
    purrr::map(rvest::html_text2)

  # the event-id is required in order to query the races for the event
  # it is given by the id of the table-row div
  event_ids <- table_rows %>% rvest::html_attr("id")

  # create data frame
  # the structure of the list elements does not yet correspond to the structure
  # of the final table, so we cannot take the names from empty_df here.
  df_names <- c("date", "place", "nation", "sector", "event_details", "genders")
  events_df <- events %>%
    purrr::map(
      function(a) {
        # live events have an additional entry with the date of the event
        # that must be removed. Because also the location appears with the
        # marker "live" after it, we must also add the year to the pattern
        a <- stringr::str_subset(a, "\\d{4}\nlive$", negate = TRUE)
        a <- a[-c(1, 3, 5, 10)]
        a %>%
          tibble::as_tibble_row(.name_repair = "minimal") %>%
          magrittr::set_names(df_names)
    }) %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(event_id = event_ids)

  # parse the event date range
  event_dates = parse_event_dates(events_df$date)

  # prepare output data
  # * split date range into two dates
  # * split event_details into categories and disciplines
  # * convert genders to a list
  events_df %>%
    dplyr::mutate(genders = parse_gender_list(.data$genders)) %>%
    dplyr::mutate(start_date = event_dates$start_date,
                  end_date = event_dates$end_date,
                  .before = "date") %>%
    dplyr::select(-"date")
}


get_empty_events_df <- function() {
  tibble::tibble(
    date_from = as.Date(character()),
    date_to = as.Date(character()),
    place = character(),
    nation = character(),
    sector = character(),
    categories = list(),
    disciplines = list(),
    genders = list(),
    event_id = character()
  )
}

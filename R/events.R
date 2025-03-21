#' Query Events
#'
#' @description
#' Query events using various filters. Omitting a filter means that events
#' with any value in that field will be returned. In order to reduce the number
#' of results, the FIS page automatically restricts the results to one season
#' or even one month, if only few filters are used (see 'Details').
#' Filtering is case-insensitive and for `place`, string matching is partial.
#'
#' `query_current_events()` queries for currently running events and is
#' equivalent to calling `query_events()` with today's date.
#'
#' @param selection which events should be returned: past events, where results
#'  are available ("results") or upcoming events ("upcoming") or both ("all")?
#' @param month numeric giving the month of the year to filter for. The month
#'  is only considered when also season is given. Not that the season runs
#'  from July to June, such that, say, month 11 in season 2025 is translated
#'  to November 2024.
#' @param date date at which the event takes place. This must either be a
#'  `Date` or `POSIXct` object or a string in the format "%Y-%m-%d". If `date`
#'   is used, `season` and `month` are ignored.
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
#' Results are always limited to events from a single season. If no season is
#' explicitly provided, the current season is used. If no or few filters are
#' applied, the results are further limited to a single month. If no month is
#' explicitly specified, the current month is used.
#'
#' @returns
#' A tibble with the following columns: `start_date`, `end_date`, `place`,
#' `nation`, `sector`, `categories`, `disciplines`, `genders`,
#' `cancelled`, and `event_id`.
#'
#' @examples
#' \dontrun{
#' # query alpine skiing world cup events in February 2024
#' query_events(sector = "AL", category = "WC", season = 2024, month = 2)
#'
#' # query ski jumping events on the large hill in the season 2020/21
#' query_events(sector = "JP", discipline = "LH", season = 2021)
#'
#' # query cross country events on 2023-03-07
#' query_events(sector = "CC", date = "2023-03-07")
#'
#' # calling query_events() without any argument returns all events from the
#' # current month
#' query_events()
#' }
#'
#' @export

query_events <- function(selection = c("all", "results", "upcoming"),
                         sector = "",
                         category = "",
                         discipline = "",
                         gender = "",
                         place = "",
                         season = "",
                         month = "",
                         date = "") {

  url <- get_events_url(selection, sector, category, discipline, gender,
                        place, season, month, date)

  events <- extract_events(url)

  # add the url as an attribute
  attr(events, "url") <- url

  events

}


#' @rdname query_events
#' @export

query_current_events <- function(selection = c("all", "results", "upcoming"),
                                 sector = "",
                                 category = "",
                                 discipline = "",
                                 gender = "",
                                 place = "") {
  query_events(selection = selection,
               sector = sector,
               category = category,
               discipline = discipline,
               gender = gender,
               place = place,
               date = lubridate::today())
}


get_events_url <- function(selection = c("all", "results", "upcoming"),
                           sector = "",
                           category = "",
                           discipline = "",
                           gender = "",
                           place = "",
                           season = "",
                           month = "",
                           date = "",
                           error_call = rlang::caller_env()) {

  selection <- match.arg(selection)
  if (selection == "all") selection <- ""
  gender <- standardise_gender(gender)

  # bring the date to standard format
  # for the date filter to work, also the season must be set explicitly
  if (!identical(date, "")) {
    date <- as.Date(date)
    season <- get_season_at_date(date)
    date <- format(date, "%d.%m.%Y")
  # when date is not given, use month if combined with season
  } else {
    if (!identical(month, "") & !identical(season, "")) {
      month <- if (month <= 6) {
        paste(formatC(month, width = 2, flag = "0"), season, sep = "-")
      } else {
        paste(formatC(month, width = 2, flag = "0"), season - 1, sep = "-")
      }
    }
  }

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
    "racecodex=&nationcode=&seasonmonth={month}"
  )
}


extract_events <- function(url) {

  cached <- get_cache(url)
  if (!cachem::is.key_missing(cached)) {
    return(cached)
  }

  table_rows <- url %>%
    rvest::read_html() %>%
    rvest::html_element(css = "div.table__body") %>%
    rvest::html_elements(css = "div.table-row")

  # if there are no rows, return an empty table
  empty_df <- get_empty_events_df()
  has_no_events <- table_rows %>%
    rvest::html_text2() %>%
    stringr::str_detect("No events found") %>%
    any()
  if (length(table_rows) == 0 | has_no_events) {
    set_cache(url, empty_df)
    return(empty_df)
  }

  # because of the multirow parts in the table, we need to extract the "a"
  # elements and only then convert to text, to make the structure clear.
  events <- table_rows %>%
    rvest::html_elements(css = "div.container") %>%
    purrr::map(\(x) rvest::html_elements(x, "a")) %>%
    purrr::map(rvest::html_text2)

  # the event-id is required in order to query the races for the event
  event_ids <- extract_ids(table_rows, "event")

  # create data frame
  # the structure of the list elements does not yet correspond to the structure
  # of the final table, so we cannot take the names from empty_df here.
  df_names <- c("date", "place", "nation", "sector", "event_details", "genders")
  events_df <- events %>%
    purrr::map(
      function(a) {
        # live events have an additional entry with the date of the event
        # that must be removed. If present, it is the second entry and it
        # ends with "\nlive". We cannot simply use the pattern to identify
        # this entry, because there is also an entry with the place followed
        # by "\nlive".
        if (stringr::str_detect(a[2], "\nlive$")) a <- a[-2]
        a <- a[-c(1, 3, 5, 10)]
        a %>%
          tibble::as_tibble_row(.name_repair = "minimal") %>%
          magrittr::set_names(df_names)
    }) %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(event_id = event_ids)

  # parse the event date range
  event_dates <- parse_event_dates(events_df$date)
  event_details <- parse_event_details(events_df$event_details)

  # prepare output data
  # * add column "cancelled"
  # * split date range into two dates
  # * split event_details into categories and disciplines
  # * convert genders to a list
  events_df <- events_df %>%
    dplyr::mutate(cancelled = is_cancelled(table_rows), .after = "genders") %>%
    dplyr::mutate(genders = parse_gender_list(.data$genders)) %>%
    dplyr::mutate(start_date = event_dates$start_date,
                  end_date = event_dates$end_date,
                  .before = "date") %>%
    dplyr::select(-"date") %>%
    dplyr::mutate(categories = !!event_details$categories,
                  disciplines = !!event_details$disciplines,
                  .before = "genders") %>%
    dplyr::select(-"event_details")

  set_cache(url, events_df)

  events_df
}


get_empty_events_df <- function() {
  tibble::tibble(
    start_date = as.Date(character()),
    end_date = as.Date(character()),
    place = character(),
    nation = character(),
    sector = character(),
    categories = character(),
    disciplines = character(),
    genders = character(),
    cancelled = logical(),
    event_id = character()
  )
}

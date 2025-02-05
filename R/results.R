#' Query Results for an Athlete
#'
#' Query results for an athlete using various filters. Omitting a filter means
#' that results with any value in that field will be returned.
#' Filtering is case-insensitive and for `place` string matches are partial.
#'
#' @param athlete a list or data frame with fields/columns `competitor_id` and
#'  `discipline` that describe a *single* athlete. The easiest way to create
#'  such a data frame is through the function [query_athletes()]. This function
#'  can return multiple athletes, but `query_results()` only returns the
#'  results for one athlete. If multiple athletes are passed, only the first
#'  one will be used.
#' @param season year when the season ended, i.e., 2020 stands for the season
#'  2019/2020. It is not possible to filter for multiple seasons at once.
#' @param category abbreviation of the category of the event, e.g., "WC" for
#'  "World Cup". See the dataset [categories] for possible values.
#' @param place location of the event. The API does not
#'  support special characters, but many are handled automatically
#'  (see 'Details').
#' @param event abbreviation of the type of the event, e.g., "DH" for
#'  "Downhill".
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
#' A tibble with the following columns: `athlete`, `date`, `place`, `nation`,
#' `category`, `discipline`, `rank`, `fis_points`, `cup_points`, and `race_id`.
#'
#' @export

query_results <- function(athlete,
                          season = "",
                          category = "",
                          place = "",
                          event = "") {

  athlete <- ensure_one_athlete(athlete)

  competitor_id <- athlete$competitor_id
  discipline <- athlete$discipline

  url <- glue::glue(
    "{fis_db_url}/athlete-biography.html?",
    "sectorcode={discipline}&seasoncode={season}&",
    "competitorid={competitor_id}&type=result&",
    "categorycode={toupper(category)}&sort=&place={replace_special_chars(place)}&",
    "disciplinecode={event}&position=&limit=1000"
  )

  # extract the table rows
  table_rows <- url %>%
    rvest::read_html() %>%
    rvest::html_element(css = "div.table__body") %>%
    rvest::html_elements(css = "a.table-row")

  results <- extract_results(table_rows) %>%
    dplyr::mutate(athlete =athlete$name, .before = 1)

  # the search returns at most 1'000 results. Warn if this limit is reached.
  if (nrow(results) >= 1000) {
    cli::cli_warn(c("!" = "Maximum number of 1'000 athletes reached.",
                    "i" ="Results may be incomplete."))
  }

  results
}


# ensure that only one athlete is passed on to the processing in query_results()
ensure_one_athlete <- function(athlete, error_call = rlang::caller_env()) {

  # athlete may be a list => make sure it is a tibble
  athlete <- dplyr::as_tibble(athlete)

  # if there are no athletes, abort
  if (nrow(athlete) == 0) {
    cli::cli_abort(
      c("x" = "No athlete was passed to argument 'athlete'.",
        "i" = "Pass exactly one athlete."),
      call = error_call
    )
  }

  # if there are multiple rows, warn and only keep the first one
  if (nrow(athlete) > 1) {
    athlete <- athlete[1, ]
    cli::cli_warn(
      c("!" = "Multiple athletes were passed to argument 'athlete'.",
        "i" = "Only results for the first one ({athlete$name}) are returned."),
      call = error_call
    )
  }

  athlete

}


extract_results <- function(table_rows) {

  # if there are no rows, return an empty table
  empty_df <- get_empty_results_df()
  if (length(table_rows) == 0) {
    return(empty_df)
  }

  # extract the results data by parsing the entire container-div
  results <- table_rows %>%
    rvest::html_elements(css = "div.container") %>%
    rvest::html_text2() %>%
    stringr::str_split("\n")

  # the race-id is required in order to query the results of the race
  # it is only contained in the link
  race_ids <- table_rows %>%
    rvest::html_attr("href") %>%
    stringr::str_extract("raceid=(\\d+)", group = 1)

  # create data frame
  df_names <- utils::head(names(empty_df), -1)
  results_df <- results %>%
    purrr::map(
      function(a) {
        # some values are duplicated and are removed here
        a <- a[-c(3, 4, 6, 7)]
        a %>%
          tibble::as_tibble_row(.name_repair = "minimal") %>%
          magrittr::set_names(df_names[seq_along(a)])
      }
    ) %>%
    dplyr::bind_rows()

  # if the optional two later columns are missing for all results, e.g., when
  # querying for trainings, they must be added here.
  if (!"fis_points" %in% names(results_df)) {
    results_df <- results_df %>% dplyr::mutate(fis_points = NA_real_)
  }
  if (!"cup_points" %in% names(results_df)) {
    results_df <- results_df %>% dplyr::mutate(cup_points = NA_real_)
  }

  # add column race_id at the end
  results_df <- results_df %>% dplyr::mutate()

  # prepare output data:
  # * add race_id
  # * date as Date
  # * rank as integer (with DNF, DNQ etc. as NA)
  # * fis_points and cup_points as numeric
  results_df %>%
    dplyr::mutate(date = as.Date(.data$date, format = "%d-%m-%Y"),
                  rank = suppressWarnings(as.integer(.data$rank)),
                  fis_points = as.numeric(.data$fis_points),
                  cup_points = as.numeric(.data$cup_points),
                  race_id = race_ids)

}


get_empty_results_df <- function() {
  tibble::tibble(
    date = as.Date(character()),
    place = character(),
    nation = character(),
    category = character(),
    discipline = character(),
    rank = integer(),
    fis_points = numeric(),
    cup_points = numeric(),
    race_id = character()
  )
}

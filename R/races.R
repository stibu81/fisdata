#' Query Race
#'
#' Query full results for a race.
#'
#' @param result a list or data frame with fields/columns `race_id` and
#'  `discipline` that describe a *single* race. The easiest way to create
#'  such a data frame is through the function [query_results()]. This function
#'  can return multiple results, but `query_rac()` only returns the
#'  results for one race. If multiple results are passed, only the first
#'  one will be used.
#'
#' @returns
#' A tibble with the following columns: `rank`, `bib`, `fis_code`, `name`,
#' `brand`, `birth_year`, `nation`, `time`, `diff_time`, `fis_points`,
#' and `cup_points`.
#'
#' @export

query_race <- function(result) {

  result <- ensure_one_result(result)

  race_id <- result$race_id
  discipline <- result$discipline

  url <- glue::glue(
    "{fis_db_url}/results.html?",
    "sectorcode={discipline}&raceid={race_id}"
  )

  # extract the table rows
  table_rows <- url %>%
    rvest::read_html() %>%
    rvest::html_element(css = "div.table__body#events-info-results") %>%
    rvest::html_elements(css = "a.table-row")

  race <- extract_race(table_rows)

  race
}


extract_race <- function(table_rows) {

  # if there are no rows, return an empty table
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

  # create data frame
  df_names <- names(empty_df)
  race_df <- race %>%
    purrr::map(
      function(a) {
        # in some cases, the column "brand" is missing. Identifz this situation
        # by checking whether column 7 contains the race time.
        if (stringr::str_detect(a[7], "\\d+:\\d+\\.\\d+")) {
          a <- append(a, NA_character_, 4)
        }
        a %>%
          tibble::as_tibble_row(.name_repair = "minimal") %>%
          magrittr::set_names(df_names[seq_along(a)])
      }
    ) %>%
    dplyr::bind_rows()

  # for some race types, e.g., trainings, the last two columns are missing.
  # They are added here.
  if (!"fis_points" %in% names(race_df)) {
    race_df <- race_df %>% dplyr::mutate(fis_points = NA_real_)
  }
  if (!"cup_points" %in% names(race_df)) {
    race_df <- race_df %>% dplyr::mutate(cup_points = NA_real_)
  }

  # for the winner, diff_time is set to the winning time. Replace this by 0.
  race_df$diff_time[1] <- "+0.00"

  # prepare output data:
  # * rank, bib as integer
  # * last name not in all caps
  # * birth_year as integer
  # * time as time
  # * diff_time as numeric
  # * fis_points and cup_points as numeric
  # * set missing cup_points to 0
  race_df %>%
    dplyr::mutate(rank = as.integer(.data$rank),
                  bib = as.integer(.data$bib),
                  name = stringr::str_to_title(.data$name),
                  birth_year = as.integer(.data$birth_year),
                  time = lubridate::ms(.data$time),
                  diff_time = as.numeric(.data$diff_time),
                  fis_points = as.numeric(.data$fis_points),
                  cup_points = as.numeric(.data$cup_points) %>%
                    tidyr::replace_na(0L))

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
        "i" = "Only results for the first one ({result$event}, {result$place}) are returned."),
      call = error_call
    )
  }

  result

}


get_empty_race_df <- function() {
  tibble::tibble(
    rank = integer(),
    bib = integer(),
    fis_code = character(),
    name = character(),
    brand = character(),
    birth_year = integer(),
    nation = character(),
    time = numeric(),
    diff_time = numeric(),
    fis_points = numeric(),
    cup_points = numeric()
  )
}

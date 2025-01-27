#' Query Athletes
#'
#' Query athletes using various filters. Omitting a filter means that athletes
#' with any value in that field will be returned. Filtering is case-insensitive
#' and string matches are partial, except for `nation`.
#'
#' @param last_name,first_name last and first name. These fields do not support
#'  special characters. For example, use "e" instead of "é" or "è",
#'  "ae" instead of "ä", and "ss" instead of "ß".
#' @param discipline abbreviation of the discipline, e.g., AL for alpine skiing
#' @param nation abbreviation of the nation, e.g., SUI for Switzerland. The
#'  value is matched exactly.
#' @param gender abbreviation of the gender: "M" for male or "F" for female
#' @param birth_year birth year. This also supports multiple years separated
#'  by commas (e.g, "1995,1998,2000") or year ranges (e.g., "1990-1995").
#' @param brand ski or snowboard brand used by the athlete. This field does not
#'  support special characters (see argument `last_name`).
#' @param active_only should the query be restricted to active athletes.
#'
#' @export

query_athletes <- function(last_name = "",
                           first_name = "",
                           discipline = "",
                           nation = "",
                           gender = "",
                           birth_year = "",
                           brand = "",
                           active_only = FALSE) {


  # active athletes are found by querying with "O"
  active <- if (active_only) "O" else ""
  # gender is output as "F", but queried as "W"
  if (gender == "F") gender <- "W"

  url <- glue::glue(
    "{fis_db_url}/biographies.html?",
    "lastname={last_name}&firstname={first_name}&",
    "sectorcode={discipline}&gendercode={gender}&birthyear={birth_year}",
    "&skiclub=&skis={brand}&",
    "nationcode={nation}&fiscode=&status={active}&search=true&"
  )

  # extract the table rows
  table_rows <- url %>%
    rvest::read_html() %>%
    rvest::html_element(css = "div.tbody") %>%
    rvest::html_elements(css = "a.table-row")

  athletes <- extract_athletes(table_rows)

  # the search returns at most 1'000 results. Warn if this limit is reached.
  if (nrow(athletes) >= 1000) {
    cli::cli_warn(c("!" = "Maximum number of 1'000 athletes reached.",
                    "i" ="Results may be incomplete."))
  }

  athletes
}


extract_athletes <- function(table_rows) {

  # if there are no rows, return an empty table
  empty_df <- get_empty_athletes_df()
  if (length(table_rows) == 0) {
    return(empty_df)
  }

  # extract the athlete data by parsing the entire container-div
  athletes <- table_rows %>%
    rvest::html_elements(css = "div.container") %>%
    rvest::html_text2() %>%
    stringr::str_split("\n")

  # non-active athletes miss the first column which must be added here
  athletes <- athletes %>%
    purrr::map(\(a) if (!a[1] %in% c("Active", "Not allowed")) c("", a) else a)

  # create data frame
  athletes_df <- athletes %>%
    purrr::map(
      function(a)
        a %>%
          tibble::as_tibble_row(.name_repair = "minimal") %>%
          magrittr::set_names(names(empty_df))
    ) %>%
    dplyr::bind_rows()

  # prepare output data:
  # * active as logical,
  # * lastname not in all caps
  # * age as integer
  # * explicit missing values
  # * reorder
  set_na <- \(x) dplyr::if_else(x %in% c("", " "), NA_character_, x)
  athletes_df %>%
    dplyr::mutate(active = .data$active == "Active",
                  name = stringr::str_to_title(.data$name),
                  age = as.integer(.data$age)) %>%
    dplyr::mutate(dplyr::across(dplyr::where(is.character), set_na))
}


get_empty_athletes_df <- function() {
  tibble::tibble(
    active = logical(),
    fis_code = character(),
    name = character(),
    nation = character(),
    age = integer(),
    birthdate = character(),
    gender = character(),
    discipline = character(),
    club = character(),
    brand = character()
  )
}

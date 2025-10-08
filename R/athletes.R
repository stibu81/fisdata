#' Query Athletes
#'
#' Query athletes using various filters. Omitting a filter means that athletes
#' with any value in that field will be returned. Filtering is case-insensitive
#' and for `last_name`, `first_name`, and `brand`, string matching is partial.
#'
#' @param last_name,first_name last and first name. String matching is partial.
#'  The API does not support special characters, but many are handled
#'  automatically (see 'Details').
#' @param sector abbreviation of the sector, e.g., "AL" for
#'  alpine skiing. See the dataset [sectors] for possible values.
#' @param nation abbreviation of the nation, e.g., "SUI" for Switzerland. The
#'  value is matched exactly. See the dataset [nations] for possible values.
#' @param gender abbreviation of the gender: "M" for male/men,
#'  "F" or "W" for female/women.
#' @param birth_year birth year. This also supports multiple years separated
#'  by commas (e.g, "1995,1998,2000") or year ranges (e.g., "1990-1995").
#' @param brand ski or snowboard brand used by the athlete. String matching is
#'  partial. The API does not
#'  support special characters, but many are handled automatically
#'  (see 'Details').
#' @param active_only should the query be restricted to active athletes.
#'
#' @details
#' All filter arguments are set to `""` by default. Setting an argument to
#' `""` means that no filtering takes place for this parameter. For those
#' arguments that have a call to [fd_def()] as their default value, the default
#' value can be globally set using [set_fisdata_defaults()].
#'
#'
#' The API does not support special character in the fields `last_name`,
#' `first_name`, and `brand`. The following special characters are handled
#' automatically: à, á, å, ä, æ, ç, ć, č, ð, é, è, ê, ë, ï, ñ, ø, ó, ő, ö,
#' œ, š, ß, ú, ü, and ž.
#' Other special characters must be replaced by the suitable
#' substitute by the user.
#'
#' One use of this function is to get the competitor id for an athlete, which
#' is needed in order to query an athletes results with [query_results()].
#'
#' The results are cached such that the same data are only downloaded once
#' per sessions.
#'
#' @returns
#' A tibble with the following columns: `active`, `fis_code`, `name`, `nation`,
#' `age`, `birthdate`, `gender`, `sector`, `club`, `brand`, and
#' `competitor_id`.
#'
#' `active` is a logical indicating whether the athlete is still active. `age`
#' gives the year as an integer, but this value is often missing. `birthdate`
#' is returned as a character.
#'
#' @examples
#' \dontrun{
#' # find Swiss athletes with last name "Cuche"
#' query_athletes("cuche", nation = "SUI")
#'
#' # find French alpine skiers using Rossignol skis
#' query_athletes(
#'   sector = "AL",
#'   nation = "FRA",
#'   brand = "Rossignol",
#'   active_only = TRUE
#' )
#'
#' # find Loïc Maillard. Note that even if the "ï" may be used in the query,
#' # the name the name is returned without the special character.
#' query_athletes("meillard", "loïc")
#'
#' # the query works the same without the special character
#' query_athletes("meillard", "loic")
#' }
#'
#' @export

query_athletes <- function(last_name = "",
                           first_name = "",
                           sector = fd_def("sector"),
                           nation = "",
                           gender = fd_def("gender"),
                           birth_year = "",
                           brand = "",
                           active_only = FALSE) {

  url <- get_athletes_url(last_name, first_name, sector, nation,
                          gender, birth_year, brand, active_only)
  athletes <- extract_athletes(url)

  # the search returns at most 1'000 results. Warn if this limit is reached.
  if (nrow(athletes) >= 1000) {
    cli::cli_warn(c("!" = "Maximum number of 1'000 athletes reached.",
                    "i" ="Results may be incomplete."))
  }

  # add the url as an attribute
  attr(athletes, "url") <- url

  athletes
}


get_athletes_url <- function(last_name = "",
                             first_name = "",
                             sector = "",
                             nation = "",
                             gender = "",
                             birth_year = "",
                             brand = "",
                             active_only = FALSE,
                             error_call = rlang::caller_env()) {

  # active athletes are found by querying with "O"
  active <- if (active_only) "O" else ""
  gender <- standardise_gender(gender)

  # if an invalid sector is used, the FIS-page returns results for all sectors.
  # to avoid this, catch invalid sectors here.
  if (!toupper(sector) %in% c("", fisdata::sectors$code)) {
    cli::cli_abort("'{sector}' is not a valid sector.",
                   call = error_call)
  }

  glue::glue(
    "{fis_db_url}/biographies.html?",
    "lastname={replace_special_chars(last_name)}&",
    "firstname={replace_special_chars(first_name)}&",
    "sectorcode={sector}&gendercode={gender}&birthyear={birth_year}",
    "&skiclub=&skis={replace_special_chars(brand)}&",
    "nationcode={nation}&fiscode=&status={active}&search=true"
  )

}


extract_athletes <- function(url) {

  cached <- get_cache(url)
  if (!cachem::is.key_missing(cached)) {
    return(cached)
  }

  table_rows <- url %>%
    rvest::read_html() %>%
    rvest::html_element(css = "div.tbody") %>%
    rvest::html_elements(css = "a.table-row")

  # if there are no rows, return an empty table
  empty_df <- get_empty_athletes_df()
  if (length(table_rows) == 0) {
    set_cache(url, empty_df)
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

  # the competitor-id is required in order to query the results for the athlete
  competitor_ids <- extract_ids(table_rows, "competitor")

  # create data frame
  df_names <- utils::head(names(empty_df), -1)
  athletes_df <- athletes %>%
    purrr::map(
      function(a) {
        # the birthyear is duplicated and is removed here
        a <- a[-7]
        a %>%
          tibble::as_tibble_row(.name_repair = "minimal") %>%
          magrittr::set_names(df_names)
      }
    ) %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(competitor_id = competitor_ids)

  # prepare output data:
  # * active as logical,
  # * last name not in all caps
  # * age as integer
  # * explicit missing values
  # * reorder
  set_na <- \(x) dplyr::if_else(x %in% c("", " "), NA_character_, x)
  athletes_df <- athletes_df %>%
    dplyr::mutate(active = .data$active == "Active",
                  name = stringr::str_to_title(.data$name),
                  age = as.integer(.data$age)) %>%
    dplyr::mutate(dplyr::across(dplyr::where(is.character), set_na)) %>%
    dplyr::mutate(birthdate = format_birthdate(.data$birthdate))

  set_cache(url, athletes_df)

  athletes_df
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
    sector = character(),
    club = character(),
    brand = character(),
    competitor_id = character()
  )
}

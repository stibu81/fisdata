#' Query Results for an Athlete
#'
#' Query results for an athlete using various filters. Omitting a filter means
#' that results with any value in that field will be returned.
#' Filtering is case-insensitive and for `place` string matches are partial.
#'
#' @param athlete a list or data frame with fields/columns `competitor_id` and
#'  `sector` that describe a *single* athlete. The easiest way to create
#'  such a data frame is through the functions [query_athletes()],
#'  [query_race()], or [query_standings()]. These functions
#'  can return multiple athletes, but `query_results()` only returns the
#'  results for one athlete. If multiple athletes are passed, only the first
#'  one will be used.
#' @param season year when the season ended, i.e., 2020 stands for the season
#'  2019/2020. It is not possible to filter for multiple seasons at once.
#' @param category abbreviation of the category of the race, e.g., "WC" for
#'  "World Cup". See the dataset [categories] for possible values.
#' @param place location of the race. The API does not
#'  support special characters, but many are handled automatically
#'  (see 'Details').
#' @param discipline abbreviation for the discipline, e.g., "DH" for
#'  "Downhill". See the dataset [disciplines] for possible values.
#' @param add_age should a column with the athletes age be added
#'  for each race? The age is given in decimal years. Note that for some
#'  athletes, only the birth year is known, in which case the age will be
#'  estimated.
#'
#' @details
#' All filter arguments are set to `""` by default. Setting an argument to
#' `""` means that no filtering takes place for this parameter. For those
#' arguments that have a call to [fd_def()] as their default value, the default
#' value can be globally set using [set_fisdata_defaults()].
#'
#' The API does not support special character in the field `place`.
#' The following special characters are handled
#' automatically: à, á, å, ä, æ, ç, ć, č, ð, é, è, ê, ë, ï, ñ, ø, ó, ő, ö,
#' œ, š, ß, ú, ü, and ž.
#' Other special characters must be replaced by the suitable
#' substitute by the user.
#'
#' The results are cached such that the same data are only downloaded once
#' per sessions.
#'
#' @returns
#' A tibble with the following columns: `athlete`, `date`, `place`, `nation`,
#' `sector`, `category`, `discipline`, `rank`, `fis_points`, `cup_points`,
#' and `race_id`. If `add_age` is `TRUE`, it also contains the column `age`
#' after `date`.
#'
#' @examples
#' \dontrun{
#' # in order to query an athletes results, we first
#' # have to obtain the competitor id, which is
#' # required for the query. This can be conveniently
#' # done with query_athletes().
#' odermatt <- query_athletes("odermatt", "marco")
#'
#' # get all of his results
#' query_results(odermatt)
#'
#' # get only World Cup Downhill results from the
#' # season 2023/2024
#' query_results(
#'   odermatt,
#'   category = "WC",
#'   season = 2024,
#'   discipline = "DH"
#' )
#'
#' # get all results from Kitzbühel. Note that the
#' # umlaut is removed in the output.
#' query_results(odermatt, place = "Kitzbühl")
#' }
#'
#' @export

query_results <- function(athlete,
                          season = fd_def("season"),
                          category = fd_def("category"),
                          place = "",
                          discipline = fd_def("discipline"),
                          add_age = TRUE) {

  athlete <- ensure_one_athlete(athlete)

  athlete_name <- get_athlete_name(athlete)

  url <- get_results_url(athlete, season, category, place, discipline)
  results <- extract_results(url) %>%
    dplyr::mutate(athlete = athlete_name, .before = 1) %>%
    # the sector code must be added in order to be able to query races
    dplyr::mutate(sector = !!athlete$sector, .before = "category")

  # the search returns at most 2'000 results. Warn if this limit is reached.
  if (nrow(results) >= 2000) {
    cli::cli_warn(c("!" = "Maximum number of 2'000 results reached.",
                    "i" ="Results may be incomplete."))
  }

  # complete the athlete info
  athlete_info <- attr(results, "athlete")
  if (!is.null(athlete_info)) {
    attr(results, "athlete") <- athlete_info %>%
      dplyr::mutate(
        name = athlete_name,
        sector = athlete$sector,
        competitor_id = athlete$competitor_id
      )
  }

  # add age if requested
  if (add_age) {
    if (nrow(results) == 0) {
      results <- results %>%
        dplyr::mutate(age = numeric(0), .after = "date")
    } else {
      results <- results %>%
        dplyr::mutate(
          age = compute_age_at_date(.data$date, athlete_info),
          .after = "date"
        )
    }
  }

  # add the url as an attribute
  attr(results, "url") <- url

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
    athlete_name <- get_athlete_name(athlete)
    cli::cli_warn(
      c("!" = "Multiple athletes were passed to argument 'athlete'.",
        "i" = "Only results for the first one ({athlete_name}) are returned."),
      call = error_call
    )
  }

  athlete

}


get_results_url <- function(athlete,
                            season = "",
                            category = "",
                            place = "",
                            discipline = "") {

  competitor_id <- athlete$competitor_id
  sector <- athlete$sector
  category <- find_code(category, "category")
  discipline <- find_code(discipline, "discipline", sector = sector)

  glue::glue(
    "{fis_db_url}/athlete-biography.html?",
    "sectorcode={sector}&seasoncode={season}&",
    "competitorid={competitor_id}&type=result&",
    "categorycode={toupper(category)}&sort=&place={replace_special_chars(place)}&",
    "disciplinecode={discipline}&position=&limit=2000"
  )
}


extract_results <- function(url) {

  cached <- get_cache(url)
  if (!cachem::is.key_missing(cached)) {
    return(cached)
  }

  html <- rvest::read_html(url)
  table_rows <- html %>%
    rvest::html_element(css = "div.table__body") %>%
    rvest::html_elements(css = "a.table-row")

  # if there are no rows, return an empty table
  empty_df <- get_empty_results_df()
  if (length(table_rows) == 0) {
    set_cache(url, empty_df)
    return(empty_df)
  }

  # extract the results data by parsing the entire container-div
  results <- table_rows %>%
    rvest::html_elements(css = "div.container") %>%
    rvest::html_text2() %>%
    stringr::str_split("\n")

  # the race-id is required in order to query the results of the race
  race_ids <- extract_ids(table_rows, "race")

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
    results_df <- results_df %>% dplyr::mutate(fis_points = NA_character_)
  }
  if (!"cup_points" %in% names(results_df)) {
    results_df <- results_df %>% dplyr::mutate(cup_points = NA_character_)
  }

  # prepare output data:
  # * add race_id
  # * date as Date
  # * rank as integer (with DNF, DNQ etc. as NA)
  # * fis_points and cup_points as numeric
  results_df <- results_df %>%
    dplyr::mutate(date = as.Date(.data$date, format = "%d-%m-%Y"),
                  rank = suppressWarnings(as.integer(.data$rank)),
                  fis_points = parse_number(.data$fis_points),
                  cup_points = parse_number(.data$cup_points),
                  race_id = race_ids)

  # extract some info on the athlete and add it as an attribute for
  # use by other functions. If query_results() is called with an athlete, this
  # is obsolete, because the athlete already contains the relevant information.
  # But if it is called with another input, this is needed. Since we don't
  # know here, how the function was called, we extract it in any case.
  attr(results_df, "athlete") <- extract_athlete_info(html)

  set_cache(url, results_df)

  results_df
}


extract_athlete_info <- function(html) {
  # note: name, sector, and competitor_id are tedious to extract.
  # Since they are known inside query_results, we add them there.
  profile_header <- html %>% rvest::html_element(".athlete-profile__header")
  profile_info <- html %>% rvest::html_element(".profile-info")
  dplyr::tibble(
    active = extract_profile_info_val(profile_info, "Status") == "Active",
    fis_code = extract_profile_info_val(profile_info, "FIS Code"),
    name = NA_character_,
    nation = rvest::html_element(html, ".country__name-short") %>%
      rvest::html_text2(),
    birthdate = extract_profile_info_val(profile_info, "Birthdate") %>%
      format_birthdate(),
    gender = extract_profile_info_val(profile_info, "Gender") %>%
      stringr::str_sub(1, 1),
    sector = NA_character_,
    club = rvest::html_element(profile_header, ".athlete-profile__team") %>%
      rvest::html_text2(),
    brand = extract_profile_info_val(profile_info, "Skis"),
    competitor_id = NA_character_
  )
}


extract_profile_info_val <- function(profile_info, variable) {
  profile_info %>%
    # the #-syntax for id does not work, because it may contain spaces.
    rvest::html_element(
      glue::glue(".profile-info__entry[id='{variable}']")
    ) %>%
    rvest::html_element("span.profile-info__value") %>%
    rvest::html_text2()
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

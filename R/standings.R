#' Query Cup Standings for a Season or an Athlete
#'
#' @description
#' Query cup standings, either
#'
#' * the full standings for a season by sector, category
#'   (i.e., the cup in this context), and gender, or
#' * the career standings for an athlete by category.
#'
#' @inheritParams query_athletes
#' @param season year when the season ended, i.e., 2020 stands for the season
#'  2019/2020. It is not possible to filter for multiple seasons at once. If
#'  omitted, results are returned for the current season.
#' @param category abbreviation of the category for the cup, e.g., "WC" for
#'  "World Cup". See the dataset [categories] for possible values; note that
#'  the standing is only available for some of the categories.
#'  If an unsupported category is used, the FIS page unfortunately returns
#'  the standings for a default category, which is usually the world cup ("WC").
#' @param gender abbreviation of the gender: "M" for male/men,
#'  "F" or "W" for female/women. For nations cups (`type = "nations"`), use
#'  "A" to get the overall nations cup.
#' @param type type of standings to return. Not all types may be supported for
#' all categories. Possible values are:
#'
#' * `"ranking"`, the default, returns the usual ranking of individual athletes
#'   which determines the discipline and overall winner of the cup.
#' * `"start-list"` returns the ranking for the start lists.
#' * `"nations"` returns the ranking of the nations cup.
#'
#' @param athlete a list or data frame with fields/columns `competitor_id` and
#'  `sector` that describe a *single* athlete. The easiest way to create
#'  such a data frame is through the functions [query_athletes()],
#'  [query_race()], or [query_standings()]. These functions
#'  can return multiple athletes, but `query_results()` only returns the
#'  results for one athlete. If multiple athletes are passed, only the first
#'  one will be used.
#'
#'  Providing a value for `athlete` will trigger the function to return the
#'  career standings for this athlete. All arguments except for `category`
#'  and `type` will be ignored in this case. The value `"nations"` for `type`
#'  is not allowed.
#'
#' @details
#' All filter arguments are set to `""` by default. Setting an argument to
#' `""` means that no filtering takes place for this parameter. For those
#' arguments that have a call to [fd_def()] as their default value, the default
#' value can be globally set using [set_fisdata_defaults()].
#'
#' The results are cached such that the same data are only downloaded once
#' per sessions.
#'
#' @return
#' A tibble with at least the following columns: `sector`, `athlete`,
#' and `nation`. Except for nations cups, there are also the columns `brand`
#' and `competitor_id`. Depending on the sector, there are multiple
#' columns giving the rank and the points for the various disciplines. For
#' example, in alpine skiing ("AL"), the columns `all_rank` and `all_points`
#' give the rank and points for the overall world cup, while `dh_rank` and
#' `dh_points` give the rank and points for the downhill world cup.
#'
#' @examples
#' \dontrun{
#' # get the standings for the women's alpine skiing world cup 2023/24.
#' query_standings(sector = "AL", season = 2024,
#'                 category = "WC", gender = "W")
#'
#' # get the overall nations ranking for the alpine skiing world cup 2024/25.
#' query_standings(sector = "AL", season = 2025,
#'                 category = "WC", gender = "A",
#'                 type = "nations")
#'
#' # get the women's start list for the snowboard world cup 2021/22
#' query_standings(sector = "SB", season = 2022,
#'                 category = "WC", gender = "W",
#'                 type = "start-list")
#' }
#'
#' @export

query_standings <- function(sector = fd_def("sector"),
                            season = fd_def("season"),
                            category = fd_def("category"),
                            gender = fd_def("gender"),
                            type = c("ranking", "start-list", "nations"),
                            athlete = NULL) {

  # type must already be handled here, because we use it further down
  type <- match.arg(type)

  # if category is not given, the FIS API returns World Cup standings
  # => make this explicit
  if (category == "") category <- "WC"

  # there are two distinct queries that can be performed by this function:
  # * if athlete is given, get the career standings of that athlete
  # * otherwise, get the full standings for a season
  if (!is.null(athlete)) {
    athlete <- ensure_one_athlete(athlete)
    athlete_name <- get_athlete_name(athlete)
    url <- get_athlete_standings_url(athlete, category, type)
    standings <- extract_athlete_standings(url) %>%
      dplyr::mutate(
        athlete = athlete_name,
        sector = !!athlete$sector,
        category = category,
        .before = 1
      )
  } else {
    url <- get_standings_url(sector, season, category, gender, type)
    standings <- extract_standings(url) %>%
      dplyr::mutate(sector = toupper(sector), .before = 1)

    # if the results are for the nations cup, remove the column brand
    if (type == "nations") {
      standings <- standings %>% dplyr::select(-"brand", -"competitor_id")
    }
  }

  # add the url as an attribute
  attr(standings, "url") <- url

  standings
}


get_standings_url <- function(sector = "",
                              season = "",
                              category = "",
                              gender = "",
                              type = "ranking",
                              error_call = rlang::caller_env()) {

  gender <- standardise_gender(gender)

  # gender = "A" is only supported for the nations cup.
  if (gender == "A" && type != "nations") {
    cli::cli_abort("gender 'A' is only supported for nations cups.",
                   call = error_call)
  }

  # calling this without sector makes no sense, even though the FIS page selects
  # alpine skiing by default
  if (sector == "") {
    cli::cli_abort("'sector' must not be empty.",
                   call = error_call)
  }
  if (!toupper(sector) %in% c(fisdata::sectors$code)) {
    cli::cli_abort("'{sector}' is not a valid sector.",
                   call = error_call)
  }

  # if type is "start-list" or "nation", the category code must be adapted
  if (type == "start-list") {
    category <- paste0(category, "SL")
  } else if (type == "nations") {
    category <- paste0("NC-", category)
  }

  glue::glue(
    "{fis_db_url}/cup-standings.html?",
    "sectorcode={sector}&seasoncode={season}&cupcode={category}&",
    "gendercode={gender}"
  )
}


extract_standings <- function(url) {

  cached <- get_cache(url)
  if (!cachem::is.key_missing(cached)) {
    return(cached)
  }

  table_rows <- url %>%
    rvest::read_html() %>%
    rvest::html_element(css = "div.table__body") %>%
    # usually the table rows are a-tags, but some can be divs.
    rvest::html_elements(css = "a.table-row, div.table-row")

  # if there are no rows, return an empty table
  empty_df <- get_empty_standings_df()
  has_no_standings <- table_rows %>%
    rvest::html_text2() %>%
    stringr::str_detect("No standings found") %>%
    any()
  if (has_no_standings | length(table_rows) == 0) {
    set_cache(url, empty_df)
    return(empty_df)
  }

  # extract the standings data by parsing the entire container-div
  standings <- table_rows %>%
    rvest::html_elements(css = "div.container") %>%
    rvest::html_text2() %>%
    stringr::str_split("\n")

  # the competitor-id is required in order to query the results for the athlete
  competitor_ids <- extract_ids(table_rows, "competitor")
  # if the table row is a div, the competitor id is contained in a link
  # inside the div => also extract these
  competitor_ids_in_div <- table_rows %>%
    rvest::html_element("a") %>%
    extract_ids("competitor")
  i_in_div <- is.na(competitor_ids)
  competitor_ids[i_in_div] <- competitor_ids_in_div[i_in_div]

  # create data frame
  standings_df <- standings %>%
    purrr::map(
      function(a) {
        # the first three elements are athlete, brand, and nation
        # but brand is missing in some cases => if the second element is a
        # nation code, brand is missing.
        has_brand <- !a[[2]] %in% fisdata::nations$code
        abn <- if (has_brand) {
            i_before_ranks <- 1:3
            as.list(a[1:3])
          } else {
            i_before_ranks <- 1:2
            list(a[1], NA_character_, a[2])
          }
        abn <- abn %>%
          purrr::set_names(c("athlete", "brand", "nation")) %>%
          dplyr::as_tibble()
        # from the remainder, remove the elements that are just a space
        a <- Filter(\(x) x != " ", a[-i_before_ranks])
        # the remainder is strucutred as follows:
        #   disicpline, discipline code, rank, points
        # for disciplines, where the athlete does not compete, the last two
        # fields are replaced by a single "---"
        # first, remove the disciplines that this athlete does not compete in
        i_dashes <- which(a == "---")
        i_rm <- purrr::map(i_dashes, \(i) (i - 2):i) %>%
          unlist()
        # if there are no dashes, i_rm ends up being NULL
        if (!is.null(i_rm)) a <- a[-i_rm]
        # loop through the disciplines
        a_split <- split(a, rep(1:(length(a) / 4), each = 4))
        ranks_points <- purrr::map(
          a_split,
          function(disc) {
            parse_number(disc[3:4]) %>%
              as.integer() %>%
              as.list() %>%
              purrr::set_names(
                paste(tolower(disc[2]), c("rank", "points"), sep = "_")
              ) %>%
              dplyr::as_tibble()
          }
        )
        # combine the data frames for the output
        dplyr::bind_cols(c(list(abn), ranks_points))
      }
    ) %>%
    dplyr::bind_rows()

  # prepare output data:
  # * athlete's name in title case
  # * points and ranks as integer
  # * add competitor id
  standings_df <- standings_df %>%
    dplyr::mutate(athlete = .data$athlete %>%
                    stringr::str_to_title() %>%
                    stringr::str_trim(),
                  dplyr::across(-("athlete":"nation"), as.integer),
                  competitor_id = competitor_ids)

  set_cache(url, standings_df)

  standings_df
}


get_empty_standings_df <- function() {
  tibble::tibble(
    athlete = character(),
    brand = character(),
    nation = character(),
    competitor_id = character()
  )
}



get_athlete_standings_url <- function(athlete,
                                      category,
                                      type,
                                      error_call = rlang::caller_env()) {

  competitor_id <- athlete$competitor_id
  sector <- athlete$sector

  # if type is "start-list", the category code must be adapted.
  # "nations" is not supported here.
  if (type == "start-list") {
    category <- paste0(category, "SL")
  } else if (type == "nations") {
    cli::cli_abort("type = 'nations' is not supported for athlete standings.")
  }

  glue::glue(
    "{fis_db_url}/athlete-biography.html?",
    "sectorcode={sector}&competitorid={competitor_id}&",
    "type=cups&cupcode={category}"
  )
}


extract_athlete_standings <- function(url) {

  cached <- get_cache(url)
  if (!cachem::is.key_missing(cached)) {
    return(cached)
  }

  html <- url %>%
    rvest::read_html()
  table_rows <- html %>%
    rvest::html_element(css = "div.table__body") %>%
    # usually the table rows are a-tags, but some can be divs.
    rvest::html_elements(css = "a.table-row, div.table-row")

  # if there are no rows, return an empty table
  empty_df <- get_empty_athlete_standings_df()
  if (length(table_rows) == 0) {
    set_cache(url, empty_df)
    return(empty_df)
  }

  # extract the standings data by parsing the entire container-div
  standings <- table_rows %>%
    rvest::html_elements(css = "div.container") %>%
    rvest::html_text2() %>%
    stringr::str_split("\n")

  # the rows do not contain the abbreviated disciplines, so we need to
  # extract them from the table header
  discipline_codes <- html %>%
    rvest::html_element(css = "div.table__head") %>%
    rvest::html_element(css = "div.container") %>%
    rvest::html_elements(css = "div.g-md") %>%
    rvest::html_text() %>%
    tolower()

  # create data frame
  standings_df <- standings %>%
    purrr::map(
      function(a) {
        # the first element is the season
        season <- as.integer(a[[1]])
        # the remainder is structured as follows:
        #   disicpline, rank, points
        # for disciplines, where the athlete did not compete in the season,
        # the last two fields are replaced by a single "---"
        # first, replace the long discipline names by the abbreviations.
        i_disc <- stringr::str_detect(a, "[A-Za-z]")
        a[i_disc] <- discipline_codes
        # then, remove the disciplines that this athlete does not compete in
        i_dashes <- which(a == "---")
        i_rm <- purrr::map(i_dashes, \(i) (i - 1):i) %>%
          unlist()
        # if there are no dashes, i_rm ends up being NULL
        if (!is.null(i_rm)) a <- a[-i_rm]
        # loop through the disciplines
        a_split <- split(a[-1], rep(1:(length(a) / 3), each = 3))
        ranks_points <- purrr::map(
            a_split,
            function(disc) {
              parse_number(disc[2:3]) %>%
                as.integer() %>%
                as.list() %>%
                purrr::set_names(
                  paste(disc[1], c("rank", "points"), sep = "_")
                ) %>%
                dplyr::as_tibble()
            }
          ) %>%
          dplyr::bind_cols() %>%
          dplyr::mutate(season = season, .before = 1)
      }
    ) %>%
    dplyr::bind_rows()

  set_cache(url, standings_df)

  standings_df
}


get_empty_athlete_standings_df <- function() {
  tibble::tibble(
    season = integer()
  )
}

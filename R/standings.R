#' Query Cup Standings for an Athlete
#'
#' Query results for an athlete using various filters. Omitting a filter means
#' that results with any value in that field will be returned.
#' Filtering is case-insensitive and for `place` string matches are partial.
#'
#' @inheritParams query_athletes
#' @inheritParams query_results
#' @param season year when the season ended, i.e., 2020 stands for the season
#'  2019/2020. It is not possible to filter for multiple seasons at once. If
#'  omitted, results are returned for the current season.
#' @param category abbreviation of the category for the cup, e.g., "WC" for
#'  "World Cup". See the dataset [categories] for possible values; note that
#'  the standing is only available for some of the categories. If an unsupported
#'  category is used, the FIS page unfortunately returns the standings for a
#'  default category.
#'
#' @export

query_standings <- function(sector = "",
                            season = "",
                            category = "",
                            gender = "") {

  url <- get_standings_url(sector, season, category, gender)
  standings <- extract_standings(url)

  # add the url as an attribute
  attr(standings, "url") <- url

  standings
}


get_standings_url <- function(sector = "",
                              season = "",
                              category = "",
                              gender = "",
                              error_call = rlang::caller_env()) {

  # gender is output as "F", but queried as "W"
  if (gender == "F") gender <- "W"

  # if an invalid sector is used, the FIS-page returns results for all sectors.
  # to avoid this, catch invalid sectors here.
  if (!toupper(sector) %in% c("", fisdata::sectors$code)) {
    cli::cli_abort("'{sector}' is not a valid sector.",
                   call = error_call)
  }

  glue::glue(
    "{fis_db_url}/cup-standings.html?",
    "sectorcode={sector}&seasoncode={season}&cupcode={category}&",
    "gendercode={gender}"
  )
}


extract_standings <- function(url) {

  table_rows <- url %>%
    rvest::read_html() %>%
    rvest::html_element(css = "div.table__body") %>%
    rvest::html_elements(css = "a.table-row")

  # if there are no rows, return an empty table
  empty_df <- get_empty_standings_df()
  if (length(table_rows) == 0) {
    return(empty_df)
  }

  # extract the standings data by parsing the entire container-div
  standings <- table_rows %>%
    rvest::html_elements(css = "div.container") %>%
    rvest::html_text2() %>%
    stringr::str_split("\n")

  # the competitor-id is required in order to query the results for the athlete
  competitor_ids <- extract_ids(table_rows, "competitor")

  # create data frame
  standings_df <- standings %>%
    purrr::map(
      function(a) {
        # the first three elements are athlete, brand, and nation
        abn <- a[1:3] %>%
          as.list() %>%
          purrr::set_names(c("athlete", "brand", "nation")) %>%
          dplyr::as_tibble()
        # from the remainder, remove the elements that are just a space
        a <- Filter(\(x) x != " ", a[-(1:3)])
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
  standings_df %>%
    dplyr::mutate(athlete = stringr::str_to_title(.data$athlete),
                  dplyr::across(-("athlete":"nation"), as.integer))

}


get_empty_standings_df <- function() {
  tibble::tibble(
    athlete = character(),
    brand = character(),
    nation = character()
  )
}

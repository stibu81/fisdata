#' Show or Browse URL Associated With a Query
#'
#' All the functions `query_*()` call a URL on the FIS web page to collect
#' their data. `show_url()` returns the URL that was used to produce a table
#' of fisdata-results. `browse_url()` opens the URL in a browser.
#'
#' @param fisdata_df a table of fisdata-results produced by one of the
#'  `query_*()`-functions.
#'
#' @details
#' If run from an interactive session, `show_url()` also copies the URL into
#' the clipboard such that it can be pasted into a browser.
#'
#' @returns
#' `show_url()` returns a character vector of length one with the URL that
#' was used to create the table. In an interactive session it also copies
#' the URL to the clipboard as a side effect.
#'
#' `browse_url()` returns `NULL` invisibly and opens the URL in a browser
#' as a side effect.
#'
#' @export

show_url <- function(fisdata_df) {
  url <- attr(fisdata_df, "url")
  if (interactive() && !is.null(url)) {
    clipr::write_clip(url) # nocov
  }
  url
}

#' @rdname show_url
#' @param browser a character string giving the name of the browser
#'  to be used. If omitted, the default browser is used.
#'  See [utils::browseURL()] for details.
#' @export

browse_url <- function(fisdata_df, browser = getOption("browser")) {
  url <- attr(fisdata_df, "url")
  utils::browseURL(url, browser)
}

# Replace special characters
# the function also converts to lower case such that capital letters need nod
# be replaced. This is possible because the function is used to convert strings
# that are applied in case-insensitive queries.
replace_special_chars <- function(x) {
  x %>%
    stringr::str_to_lower() %>%
    stringr::str_replace_all(
      c(
        # à, á, å, ä, æ
        "\u00e0" = "a", "\u00e1" = "a", "\u00e5" = "a", "\u00e4" = "ae", "\u00e6" = "ae",
        # ç, ć, č
        "\u00e7" = "c", "\u0107" = "c", "\u010d" = "c",
        # ð
        "\u00f0" = "d",
        # é, è, ê, ë
        "\u00e9" = "e", "\u00e8" = "e", "\u00ea" = "e", "\u00eb" = "e",
        # ï
        "\u00ef" = "i",
        # ñ
        "\u00f1" = "n",
        # ø, ó, ő
        "\u00f8" = "o", "\u00f3" = "o", "\u0151" = "o",
        # ö, œ
        "\u00f6" = "oe", "\u0153" = "oe",
        # š, ß
        "\u0161" = "s", "\u00df" = "ss",
        # ú, ü
        "\u00fa" = "u", "\u00fc" = "ue",
        # ž
        "\u017e" = "z",
        # spaces must be URL encoded
        "\\s+" = "%20%"
      )
    )
}


# standardise gender: convert to upper case, replace "F" by "W".
# the latter is useful because query_athletes() returns "F", but the API
# must be queried with "W"
standardise_gender <- function(gender) {
  toupper(gender) %>%
    stringr::str_replace("^F$", "W")
}

# format the birthdate to %Y-%m-%d. The birthdate is kept as a string, because
# for many athletes, only the birthyear is registered. This format nevertheless
# allows for correct sorting by birthdate.
format_birthdate <- function(x) {
  x %>%
    stringr::str_replace("^(\\d{2})-(\\d{2})-(\\d{4})$",
                         "\\3-\\2-\\1")
}

# parse race time to a Period object. The difficulty here is that the race times
# are given in different formats:
# * there may be a +-sign at the beginning (for time differences)
# * they may be given as seconds (43.5), minutes and seconds (1:57.23) or
#   hours minutes and seconds (2:23:05.35)

parse_race_time <- function(x) {
  # extract the sign such that it can be added again later
  sign <- stringr::str_extract(x, "^(\\+|-)*")
  # add enough zeroes at the start and then only keep the part that defines a
  # time period
  x %>%
    stringr::str_remove("^(\\+|-)*") %>%
    stringr::str_c("0:0:", .) %>%
    stringr::str_extract("\\d+:\\d+:[\\d.]+$") %>%
    # hms() does not handle a decimal point that is not preceeded by a digit
    # correctly. E.g., 0:0:.5 is parsed to "5S" instead of "0.5S"
    # => fix this by adding a "0" in front of such a decimal point
    stringr::str_replace("(^|:)\\.", "\\10.") %>%
    stringr::str_c(sign, .) %>%
    lubridate::hms()
}


# parse numbers. They come with thousands separator "'" and some values like
# "DNS" must be converted to NA.
parse_number <- function(x) {
  suppressWarnings(
    x %>%
      stringr::str_remove_all("'") %>%
      as.numeric()
  )
}


# standardise column names:
# * convert to lower case
# * replace anything but letters and numbers by "_"
# * remove leading and training "_"
# * replace multiple "_" by a single one
# * remove "_" followed by a digit
standardise_colnames <- function(x) {
  x %>%
    tolower() %>%
    stringr::str_replace_all("[^[:alnum:]]", "_") %>%
    stringr::str_remove_all("^_+|_+$") %>%
    stringr::str_replace_all("_+", "_") %>%
    stringr::str_remove_all("_(?=\\d)")
}


# in events, the genders that are competing are contained in a single string
# format this to a more readable format.

parse_gender_list <- function(x) {
  x %>%
    stringr::str_split("\n") %>%
    purrr::map_chr(
      \(y) intersect(y, c("M", "W")) %>%
        sort() %>%
        paste0(collapse = " / ")
    )
}


# event dates are given as a character representing a date range in one of
# the following forms:
# * 28 Dec-06 Jan 2024
# * 20 Jan-01 Feb 2024
# * 21-22 Feb 2024
# * 30 Oct 2023
# For events in the current season, the year is missing.

parse_event_dates <- function(x) {

  # 1. Remove line breaks
  x1 <- stringr::str_remove_all(x, "\n")

  # 2. Handle the cases with missing year:
  #    * if today is between Jan-Jun:
  #      * if date is Jan-Jun => current year
  #      * if date is Jul-Dec => previous year
  #    * if today is between Jul-Dec:
  #      * if date is Jan-Jun => next year
  #      * if date is Jul-Dec => current year
  choy <- get_half_of_the_year_at_date(today())[[1]]
  m1 <- "(Jan|Feb|Mar|Apr|May|Jun)$"
  m2 <- "(Jul|Aug|Sep|Oct|Nov|Dec)$"
  x2 <- dplyr::case_when(
    stringr::str_detect(x1, m1) ~ paste(x1, sum(choy) - 1),
    stringr::str_detect(x1, m2) ~ paste(x1, sum(choy) - 2),
    .default = x1
  )

  # 3. If there is no month in front of the dash, copy the month from after
  #    the dash
  x3 <- dplyr::case_when(
    stringr::str_detect(x2, "\\d-") ~
      stringr::str_replace(
        x2, "-",
        paste0(" ", stringr::str_extract(x2, "-\\d+ *(\\w{3})", group = 1), "-")
      ),
    .default = x2
  )

  # 4. Add the year to the date in front of the dash. The difficulty here is
  #    that the range may go over new year.
  years <- stringr::str_extract(x3, "\\d{4}") %>% as.numeric()
  x4 <- dplyr::case_when(
    # a range that includes new year
    stringr::str_detect(x3, "(Nov|Dec)-\\d+ *(Jan|Feb)") ~
      stringr::str_replace(
        x3, "-",
        paste0(" ", years - 1, "-")
      ),
    stringr::str_detect(x3, "\\w-") ~
      # a range that does not include new year
      stringr::str_replace(
        x3, "-",
        paste0(" ", years, "-")
      ),
    .default = x3
  )

  # 5. If there is no dash, double the day
  x5 <- dplyr::if_else(
    !stringr::str_detect(x4, "-"),
    paste0(x4, "-", x4),
    x4
  )

  # split and parse the dates
  dates <- stringr::str_split(x5, "-")
  dplyr::tibble(start_date = purrr::map_chr(dates, getElement, 1),
                end_date = purrr::map_chr(dates, getElement, 2)) %>%
    dplyr::mutate(dplyr::across(dplyr::everything(), lubridate::dmy))
}


# event details are given as a character string of the following form:
# TRA • FIS\n8xDH 4xSG
# The first line conains the categories, the second line the disciplines
# with a multiplier for the number of races.
# Split this int two columns and use "/" as separator.

parse_event_details <- function(x) {
  ed_split <- x %>%
    stringr::str_split("\n") %>%
    purrr::map(\(x) if (length(x) == 1) c(x, "") else x)

  dplyr::tibble(
      categories = purrr::map_chr(ed_split, getElement, 1),
      disciplines = purrr::map_chr(ed_split, getElement, 2)
    ) %>%
    dplyr::mutate(
      categories = stringr::str_replace_all(
          .data$categories,
          "\\s+\u2022\\s+",
          " / "
        ),
      disciplines = stringr::str_replace_all(
          .data$disciplines,
          " +",
          " / "
        )
    )
}


# get the current year and half of the year

get_half_of_the_year_at_date <- function(date = today()) {
  years <- as.integer(lubridate::year(date))
  hoy <- as.integer(lubridate::month(date) > 6) + 1L
  purrr::map2(years, hoy, \(y, h) c(y, h))
}


get_season_at_date <- function(date = today()) {
  as.integer(lubridate::year(date) + (lubridate::month(date) > 6))
}


# create a local version of lubridate::today() because it needs to be
# mocked for some tests.
today <- function(tzone = "") {
  lubridate::today(tzone = tzone)
}


# compute an athletes age at a given date. Note that the birthdate of an
# athlete is stored as a character, not a date, because sometimes only the
# birthyear is given. This function takes care of this and works in all
# situations. When only the birthyear is given, the age is computed assuming
# the birthdate is in the middle of the year and rounded down to whole years.
# If the exact date is given, it is given as a fractional number of years.

compute_age_at_date <- function(date, athlete) {
  # extract the birthdate and remember if  an exacte date was given or not.
  # if the birthdate is missing, return a vector of missing values
  birthdate <- athlete$birthdate
  if (length(birthdate) != 1) {
    cli::cli_abort("'athlete' must contain exactly one athlete.")
  }
  if (is.na(birthdate)) return(rep(NA_real_, length(date)))
  if (is.character(birthdate)) {
    if (stringr::str_detect(birthdate, "^\\d{4}$")) {
      birthdate <- as.Date(glue::glue("{birthdate}-07-01"))
      bd_format <- "year_only"
    } else if (stringr::str_detect(birthdate, "^\\d{4}-\\d{2}-\\d{2}$")) {
      birthdate <- as.Date(birthdate)
      bd_format <- "full_date"
    } else {
      cli::cli_abort("invalid format for birthdate.")
    }
  }

  age <- lubridate::interval(birthdate, date) / lubridate::years(1)

  if (bd_format == "year_only") age <- floor(age)

  age
}


# determine if events were cancelled
is_cancelled <- function(table_rows) {
  status <- table_rows %>%
    rvest::html_elements("div.status") %>%
    rvest::html_elements("span.status__item[title$='ancelled']") %>%
    rvest::html_attr("title")

  status == "Cancelled"
}


# different kinds of IDs are contained in hyperlinks and can be extracted
# with this function.

extract_ids <- function(html, type = c("competitor", "race", "event")) {

  type <- match.arg(type)

  # the event-id is contained in the id-attribute of html
  if (type == "event") {
    return(html %>% rvest::html_attr("id"))
  }

  # if there is an "a"-tag, we must extract it
  a_tag <- html %>% rvest::html_element("a")
  if (!is.na(a_tag[1])) {
    html <- a_tag
  }

  html %>%
    rvest::html_attr("href") %>%
    stringr::str_extract(glue::glue("{type}id=(\\d+)"), group = 1)
}


# depending on the source for athlete, the name is stored in column
# "name" or "athlete".
get_athlete_name <- function(athlete) {
  athlete_name <- if ("name" %in% names(athlete)) {
    athlete$name
  } else {
    athlete$athlete
  }
}

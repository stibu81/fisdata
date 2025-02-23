#' Show URL associated With a Query
#'
#' All the functions `query_*()` call a URL on the FIS web page to collect
#' their data. `show_url()` returns the URL that was used to produce a table
#' of fisdata-results.
#'
#' @param fisdata_df a table of fisdata-results produced by one of the
#'  `query_*()`-functions.
#'
#' @details
#' If run from an interactive session, the URL is also copied into the
#' clipboard such that it can be pasted into a browser.
#'
#' @returns
#' a character vector of length one with the URL that was used to create the
#' table. In an interactive session it also copies the URL to the clipboard
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

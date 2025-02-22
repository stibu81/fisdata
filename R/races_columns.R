# This file contains functions to determine the names of the columns in
# the tibble for a race and to convert them to the appropriate format.

get_race_column_names <- function(html, error_call = rlang::caller_env()) {

  # look at the headers to identify the columns of the data frame to return
  df_names <- html %>%
    rvest::html_element(
      css = "div.sticky[data-boundary='#events-info-results']"
    ) %>%
    rvest::html_text2() %>%
    stringr::str_split_1("\n") %>%
    # convert to lower case to avoid problems due to inconsistent capitalisation
    tolower()

  translation_table <- c(
    "rank" = "rank",
    "bib" = "bib",
    "fis code" = "fis_code",
    "athlete" = "name",
    "year" = "birth_year",
    "nation" = "nation",
    "time" = "time",
    "run 1" = "run1",
    "run 2" = "run2",
    "tot. time" = "total_time",
    "qual. time" = "qual_time",
    "diff. time" = "diff_time",
    "tot. points" = "total_points",
    "diff. points" = "diff_points",
    "score" = "score",
    "fis points" = "fis_points",
    "cup points" = "cup_points"
  )

  # check: are there any columns that have no translation. Warn and only apply
  # minimal conversion to them.
  unknown_names <- !df_names %in% names(translation_table)
  if (sum(unknown_names) > 0) {
    cli::cli_warn(
      c("!" = "The data contains some fields unknown to fisdata.",
        "i" = "Affected column{?s}: {paste0('\\'', df_names[unknown_names], '\\'')}",
        "!" = "These columns might not be processed as expected."),
      call = error_call
    )
    df_names[unknown_names] <-
      standardise_colnames(df_names[unknown_names])
  }

  df_names[!unknown_names] <- translation_table[df_names[!unknown_names]] %>%
    unname()

  # if present on the web site, the brand is written under the athlete's
  # name and accordingly does not occupy its own column. Therefore, it cannot
  # be determined from the column names, whether the brand is present or not.
  # But the brand is included in a split cell with a special class that can
  # be used to check, whether the brand is present or not.
  has_brand <- html %>%
    rvest::html_element(css = ".constructor-name") %>%
    length() %>%
    magrittr::is_greater_than(0)

  # if the brand is present, add the column after the athlete's name
  if (has_brand) {
    df_names <- df_names %>%
      append("brand", after = which(df_names == "name"))
  }

  df_names
}


# process columns of the race df. Use the column name to decide which processing
# is needed. Columns with unknown names will be left unchanged.

process_race_column <- function(name, data) {

  # if the column does not exist in the data, initialise a column with missing
  # values
  col <- if (name %in% names(data)) {
      data[[name]]
    } else {
      rep(NA_character_, nrow(data))
    }

  # process the column based on the column name

  # integer columns
  col_out <- if (name %in% c("rank", "bib", "birth_year")) {
      as.integer(col)
    # numeric columns
    } else if (name %in% c("fis_points", "total_points", "score")) {
      parse_number(col)
    # athlete's name
    } else if (name == "name") {
        stringr::str_to_title(col)
    # race time
    } else if (name %in% c("time", "run1", "run2", "total_time", "qual_time")) {
      parse_race_time(col)
    # time difference
    } else if (name %in% c("diff_time")) {
      # for the winner, diff_time is set to the winning time. If others have
      # finished with the same time, the column contains "&nbsp". All other times
      # start with a "+", so replace those that don't by "+0.00"
      i_zero <- stringr::str_detect(col, "^\\+", negate = TRUE)
      replace(col, i_zero, "+0.00") %>%
        parse_race_time()
    } else if (name %in% c("diff_points")) {
      # for the winner, diff_points is set to the winning points. If others have
      # finished with the same time, the column contains "&nbsp". All other times
      # start with a "-", so replace those that don't by "0"
      i_zero <- stringr::str_detect(col, "^\\-", negate = TRUE)
      replace(col, i_zero, "0") %>%
        parse_number()
    # cup points: if any athletes have gained cup points, fill all missing
    # values with zero
    } else if (name == "cup_points") {
      out <- parse_number(col)
      if (any(!is.na(out))) {
        out <- tidyr::replace_na(out, 0)
      }
      out
    # everything else is left unchanged
    } else {
      col
    }

  col_out
}

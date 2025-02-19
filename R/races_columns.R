# This file contains functions to determine the names of the columns in
# the tibble for a race and to convert them to the appropriate format.

get_race_column_names <- function(html) {

  # look at the headers to identify the columns of the data frame to return
  df_names <- html %>%
    rvest::html_element(css = "div.sticky[data-boundary='#events-info-results']") %>%
    rvest::html_text2() %>%
    stringr::str_split_1("\n") %>%
    # convert to lower to avoid problems due to inconsistent capitalisation
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
    "diff. time" = "diff_time",
    "fis points" = "fis_points",
    "cup points" = "cup_points"
  )

  # check: are there any columns that have no translation. Warn and only apply
  # minimal conversion to them.
  unknown_names <- !df_names %in% names(translation_table)
  if (sum(unknown_names) > 0) {
    cli::cli_warn(
      c("!" = "The data contains some fields unknown to fisdata.",
        "i" = "Affected column{?s}: {paste0('\\'', html_names[unknown_names], '\\'')}",
        "!" = "These columns might not be processed as expected.")
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

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
        "\u017e" = "z"
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

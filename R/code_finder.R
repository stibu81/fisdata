# find a code by searching through descriptions with a string
find_code <- function(char,
                      type = c("sector", "discipline", "category", "nation")) {

  # if char is NULL or NA, return an empty string
  if (is.null(char) || isTRUE(is.na(char))) {
    return("")
  }

  # if char is not a character or is not a scalar, throw an error
  if (length(char) != 1) {
    cli::cli_abort("`char` must have length one.")
  }
  if (!is.character(char)) {
    cli::cli_abort("`char` must be a character.")
  }

  # remove whitespace, return if char is empty string
  char <- stringr::str_squish(char)
  if (char == "") {
    return("")
  }

  type <- match.arg(type)
  code_table <- get_code_table(type)

  # check: if char is a valid code
  i_code <- which(toupper(char) == toupper(code_table$code))
  if (length(i_code) > 0) {
    return(code_table$code[i_code[1]])
  }

  # otherwise, find the closest matching description by computing the distance
  # as follows:
  # 1. compute the approximate string distance to the descriptions. weight
  #    substitutions & deletions higher than insertions because the user is
  #    expected to omit characters but not use wrong ones.
  # 2. subtract twice the number of leading characters where char agrees with the
  #    description. This assumes that the user is likely to use the first or
  #    first few characters of the term.
  dist <- utils::adist(char, code_table$description,
                       costs = list(ins = 1, del = 5, sub = 6),
                       ignore.case = TRUE)
  n_match <- count_leading_matches(char, code_table$description)
  i_best <- which.min(dist - 2 * n_match)
  desc <- code_table$description[i_best]
  code <- code_table$code[i_best]

  return(code)

}


# count the number of leading characters that match between two strings
count_leading_matches <- function(x, y) {

  x_split <- stringr::str_split_1(tolower(x), "")
  lx <- length(x_split)
  y_split <- stringr::str_split(tolower(y), "") %>%
    lapply(\(x) x[1:lx])

  # count the number of matches
  purrr::map_dbl(y_split, \(z) min(which(z != x_split), lx + 1)) - 1
}


# get code table by name
get_code_table <- function(type) {
  if (type == "sector") {
    fisdata::sectors
  } else if (type == "discipline") {
    fisdata::disciplines
  } else if (type == "category") {
    fisdata::categories
  } else if (type == "nation") {
    fisdata::nations
  }
}

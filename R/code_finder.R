# find a code by searching through descriptions with a string
find_code <- function(char,
                      type = c("sector", "discipline", "category", "nation")) {

  # if called with an empty string, NA or NULL, just return the value
  if (char == "" || is.na(char) || is.null(char)) {
    return(char)
  }

  type <- match.arg(type)

  # determine the codes and descriptions to use
  if (type == "sector") {
    codes <- fisdata::sectors$code
    descs <- fisdata::sectors$description
  } else if (type == "discipline") {
    codes <- fisdata::disciplines$code
    descs <- fisdata::disciplines$description
  } else if (type == "category") {
    codes <- fisdata::categories$code
    descs <- fisdata::categories$description
  } else if (type == "nation") {
    codes <- fisdata::nations$code
    descs <- fisdata::nations$country
  }

  # check: if char is a valid code
  i_code <- which(toupper(char) == toupper(codes))
  if (length(i_code) > 0) {
    return(codes[i_code[1]])
  }

  # otherwise, find the closest matching description by computing the distance
  # as follows:
  # 1. compute the approximate string distance to the descriptions. weight
  #    substitutions & deletions higher than insertions because the user is
  #    expected to omit characters but not use wrong ones.
  # 2. subtract twice the number of leading characters where char agrees with the
  #    description. This assumes that the user is likely to use the first or
  #    first few characters of the term.
  dist <- utils::adist(char, descs,
                       costs = list(ins = 1, del = 5, sub = 6),
                       ignore.case = TRUE)
  n_match <- count_leading_matches(char, descs)
  i_best <- which.min(dist - 2 * n_match)
  desc <- descs[i_best]
  code <- codes[i_best]

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

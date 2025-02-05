#' Table of Codes for Disciplines
#'
#' This dataset contains the codes for all the disciplines for which data
#' can be obtained from the FIS webpage. These codes can be used to filter
#' for a specific discipline in [query_athletes()].
#'
#' @format A data frame with `r nrow(disciplines)` rows and
#'  `r ncol(disciplines)` variables:
#' \describe{
#' \item{code}{code of the discipline consisting of two or three
#' (for parasports disciplines) capital letters}
#' \item{description}{clear text name of the discipline}
#' }
#'
#' @keywords datasets

"disciplines"


#' Table of IOC Country Codes
#'
#' This dataset contains all current and some historic IOC country codes.
#' These codes can be used to filter for a specific nation in
#' [query_athletes()].
#'
#' @format A data frame with `r nrow(nations)` rows and
#'  `r ncol(nations)` variables:
#' \describe{
#' \item{code}{IOC country code consisting of three capital letters}
#' \item{country}{name of the country}
#' \item{current}{is this a code that is currently in use?}
#' }
#'
#' @source
#' <https://en.wikipedia.org/wiki/List_of_IOC_country_codes>
#'
#' Section "Current NOCs" for the countries with `current = TRUE` and section
#' "Historic NOCs and teams, Codes still in use" for those with
#' `current = FALSE`.
#'
#' @keywords datasets

"nations"


#' Table of Codes for Categories
#'
#' This dataset contains the codes for many of the race categories for which
#' data can be obtained from the FIS webpage. Note that due to the structure of
#' the site, it is not possible to guarantee that the table of code is complete.
#' There may be other codes that are as of yet missing.
#' These codes can be used to filter
#' for a specific category in [query_results()].
#'
#' @format A data frame with `r nrow(categories)` rows and
#'  `r ncol(categories)` variables:
#' \describe{
#' \item{code}{code of the category consisting of two to four capital letters
#' or (in one case) digits.}
#' \item{description}{clear text name of the category}
#' }
#'
#' @keywords datasets

"categories"

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

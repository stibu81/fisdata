#' Table of Codes for Sectors
#'
#' This dataset contains the codes for all the sectors for which data
#' can be obtained from the FIS webpage. These codes can be used to filter
#' for a specific sector in [query_athletes()].
#'
#' @format A data frame with `r nrow(sectors)` rows and
#'  `r ncol(sectors)` variables:
#' \describe{
#' \item{code}{code of the sector consisting of two or three
#' (for parasports sectors) capital letters}
#' \item{description}{clear text name of the sector}
#' }
#'
#' @keywords datasets

"sectors"


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
#' This dataset contains the codes for the race categories for which
#' data can be obtained from the FIS webpage.
#' These codes can be used to filter for a specific category
#' in [query_results()].
#'
#' @format A data frame with `r nrow(categories)` rows and
#'  `r ncol(categories)` variables:
#' \describe{
#' \item{code}{code of the category. Most consist of two to four capital
#' letters, but some are longer (up to 8 letters) or contain digits.}
#' \item{description}{clear text description of the category}
#' }
#'
#' @details
#' The categories are ordered as follows:
#' * Olympic Games
#' * World Championships
#' * World Cups
#' * Other Cups (excluding Youth & Masters)
#' * Everything else
#'
#' The latter two groups involve many categories that are ordered
#' alphabetically by the code within the group.
#'
#' @keywords datasets

"categories"


#' Table of Codes for Disciplines
#'
#' This dataset contains the codes for the disciplines for which
#' data can be obtained from the FIS webpage.
#' These codes can be used to filter for a specific discipline
#' in [query_results()]. Note that the available disciplines depend on
#' the sector.
#'
#' @format A data frame with `r nrow(disciplines)` rows and
#'  `r ncol(disciplines)` variables:
#' \describe{
#' \item{sector}{the code of the sector, to which the discipline belongs}
#' \item{sector_description}{the clear-text description of the sector}
#' \item{code}{code of the category. They are alphanumeric, starting with a
#' capital letter or a  digit. Most are 2 or 3 characters long, but up to
#' six characters are possible.}
#' \item{description}{clear text description of the category}
#' }
#'
#' @keywords datasets

"disciplines"

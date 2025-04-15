#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom dplyr  %>% .data
#' @importFrom rlang :=
## usethis namespace: end
NULL


# base url
fis_db_url <- "https://www.fis-ski.com/DB/general"

globalVariables(".")

# create an environment that is used as cache
cache <- new.env()

# nocov start

.onLoad <- function(libname, pkgname) {
  cache <<- cachem::cache_mem(
    max_size = 512 * 2^20,
    max_age = 86400,
    evict = "lru"
  )

  # set options to default values
  options(
    fisdata_sector = "",
    fisdata_season = "",
    fisdata_gender = "",
    fisdata_category = "",
    fisdata_discipline = ""
  )
}

# nocov end

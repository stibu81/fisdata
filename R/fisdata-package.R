#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom dplyr  %>%
#' @importFrom rlang := .data .env
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
  reset_fisdata_defaults()

  # determine the file that defaults should be read from. The file name is
  # taken from the environment variable FISDATA_DEFAULTS_FILE. If the variable
  # is unset, fall back to "~/.fisdata.json".
  defaults_file <- Sys.getenv("FISDATA_DEFAULTS_FILE", "~/.fisdata.json")

  # if the file exists and R is running interactively,
  # read defaults from it.
  if (interactive() && file.exists(defaults_file)) {
    cli::cli_alert_info("Reading default values from {defaults_file} ...")
    read_fisdata_defaults(defaults_file, verbose = TRUE)
  }
}

# nocov end


# reexport %>% for convenience
#' @export
dplyr::`%>%`
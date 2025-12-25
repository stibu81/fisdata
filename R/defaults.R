#' Get And Set Default Values for Parameters in Querying Functions
#'
#' @description
#' `set_fisdata_defaults()` sets default values for common arguments that will
# 'be respected by all the querying functions in fisdata.
#'
#' `reset_fisdata_defaults()` resets all the default values to `""`, which is
#' the same value they get when the package is loaded.
#'
#' `get_fisdata_defaults()` shows the currently selected default values.
#'
#' `fd_def()` returns the current default value for a single parameter; this
#' function's main use is as default argument in the querying functions.
#'
#' @inheritParams query_athletes
#' @inheritParams query_results
#' @param reset if `TRUE`, the defaults are set to those that are passed to the
#'  function, i.e., all arguments that are omitted are set to `""`. If `FALSE`,
#'  only those defaults that are passed to the function are modified, while
#'  all the others are left unchanged.
#'
#' @export

set_fisdata_defaults <- function(sector = NULL,
                                 season = NULL,
                                 gender = NULL,
                                 category = NULL,
                                 discipline = NULL,
                                 active_only = NULL,
                                 reset = FALSE) {

  if (reset) {
    reset_fisdata_defaults()
  }

  if (!is.null(sector)) {
    use_sector <- find_code(sector, "sector")
    options(fisdata_sector = use_sector)
  }

  if (!is.null(season)) {
    season_int <- suppressWarnings(as.integer(season))
    if (season == "") {
      options(fisdata_season = "")
    } else if (is.na(season_int) | season_int < 1950 |
        season_int > lubridate::year(today()) + 1) {
      cli::cli_warn("'{season}' is not a valid season.")
    } else {
      options(fisdata_season = as.character(season_int))
    }
  }

  if (!is.null(gender)) {
    use_gender <- standardise_gender(gender)
    if (!use_gender %in% c("", "M", "W")) {
      cli::cli_warn("'{gender}' is not a valid gender code.")
    } else {
      options(fisdata_gender = use_gender)
    }
  }

  if (!is.null(category)) {
    use_category <- find_code(category, "category")
    options(fisdata_category = use_category)
  }

  if (!is.null(discipline)) {
    use_discipline <- find_code(discipline, "discipline")
    options(fisdata_discipline = use_discipline)
  }

  if (!is.null(active_only)) {
    if (!active_only %in% c(TRUE, FALSE)) {
      cli::cli_warn("'{active_only}' is not valid for active_only.")
    } else {
      options(fisdata_active_only = active_only)
    }
  }
}


#' @rdname set_fisdata_defaults
#' @export

get_fisdata_defaults <- function() {
  opt_names <- paste0("fisdata_", eval(formals(fd_def)$name))
  opt_values <- rlang::exec(options, !!!opt_names)
  names(opt_values) <- stringr::str_remove(opt_names, "fisdata_")
  tibble::as_tibble(opt_values)
}


#' @rdname set_fisdata_defaults
#' @export

reset_fisdata_defaults <- function() {
  set_fisdata_defaults(sector = "", season = "", gender = "",
                       category = "", discipline = "", active_only = FALSE)
}


#' @param name name of the default argument
#' @rdname set_fisdata_defaults
#' @export

fd_def <- function(name = c("sector", "season", "gender",
                            "category", "discipline", "active_only")) {
  name <- match.arg(name)
  getOption(paste0("fisdata_", name))
}

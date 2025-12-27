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
#' @param verbose should the function generate output about what it does?
#'
#' @export

set_fisdata_defaults <- function(sector = NULL,
                                 season = NULL,
                                 gender = NULL,
                                 category = NULL,
                                 discipline = NULL,
                                 active_only = NULL,
                                 reset = FALSE,
                                 verbose = interactive()) {

  if (reset) {
    reset_fisdata_defaults()
    if (verbose) {
      cli::cli_alert_info("All defaults have been reset to ''.")
    }
  }

  if (!is.null(sector)) {
    use_sector <- find_code(sector, "sector")
    options(fisdata_sector = use_sector)
    alert_default("sector", use_sector, verbose)
  }

  if (!is.null(season)) {
    season_int <- suppressWarnings(as.integer(season))
    if (season == "") {
      options(fisdata_season = "")
      alert_default("season", season, verbose)
    } else if (is.na(season_int) | season_int < 1950 |
        season_int > lubridate::year(today()) + 1) {
      cli::cli_warn("'{season}' is not a valid season.")
    } else {
      options(fisdata_season = as.character(season_int))
      alert_default("season", season_int, verbose)
    }
  }

  if (!is.null(gender)) {
    use_gender <- standardise_gender(gender)
    if (!use_gender %in% c("", "M", "W")) {
      cli::cli_warn("'{gender}' is not a valid gender code.")
    } else {
      options(fisdata_gender = use_gender)
      alert_default("gender", use_gender, verbose)
    }
  }

  if (!is.null(category)) {
    use_category <- find_code(category, "category")
    options(fisdata_category = use_category)
      alert_default("category", use_category, verbose)
  }

  if (!is.null(discipline)) {
    # when matching the discipline, use the default value for the sector
    # if set_fisdata_defaults has been called with a sector, it's value has
    # already been set as the default such that it will also be used here
    use_discipline <- find_code(discipline, "discipline",
                                sector = fd_def("sector"))
    options(fisdata_discipline = use_discipline)
    alert_default("discipline", use_discipline, verbose)
  }

  if (!is.null(active_only)) {
    if (!active_only %in% c(TRUE, FALSE)) {
      cli::cli_warn("'{active_only}' is not valid for active_only.")
    } else {
      options(fisdata_active_only = active_only)
      alert_default("active_only", active_only, verbose)
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
                       category = "", discipline = "", active_only = FALSE,
                       verbose = FALSE)
}


#' @param name name of the default argument
#' @rdname set_fisdata_defaults
#' @export

fd_def <- function(name = c("sector", "season", "gender",
                            "category", "discipline", "active_only")) {
  name <- match.arg(name)
  getOption(paste0("fisdata_", name))
}


# issue a message describing the default value that has been set.
alert_default <- function(type, value, verbose) {

  if (!verbose) {
    return(NULL)
  }

  # if the value is an empty string, issue a message saying this
  if (value == "") {
    cli::cli_alert_info("The default for '{type}' has been set to ''.")
  } else {
    code_table <- get_code_table(type, sector = fd_def("sector"))
    if (is.null(code_table)) {
      cli::cli_alert_info(
        "The default for '{type}' has been set to '{value}'."
      )
    } else {
      desc <- code_table$description[code_table$code == value][1]
      cli::cli_alert_info(
        "The default for '{type}' has been set to '{value}' ({desc})."
      )
    }
  }
}

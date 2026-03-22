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

  defs <- prepare_defaults(sector = sector,
                           season = season,
                           gender = gender,
                           category = category,
                           discipline = discipline,
                           active_only = active_only)
  
  for (name in names(defs)) {
    value <- defs[[name]]
    if (!is.null(value)) {
      options(
        magrittr::set_names(list(value), paste0("fisdata_", name))
      )
      alert_default(name, value, verbose)
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


#' Read and Write Defaults from a JSON File
#'
#' Default settings can be written to a JSON file and read again from
#' this file. If the file `.fisdata.json` exists in the user's home
#' it is read automatically.
#' 
#' @param file name of the JSON file to read or write
#' @param overwrite should an existing file be overwritten?
#' 
#' @export

write_current_defaults <- function(file = "~/.fisdata.json",
                                   overwrite = FALSE) {

  if (file.exists(file) && !overwrite) {
    cli::cli_abort("The file {file} exists. Use `overwrite = TRUE` to overwrite it.")
  }

  defaults <- get_fisdata_defaults()
  json <- defaults %>%
    # convert to a list to avoid having an unnecessary length-one array
    as.list() %>% 
    jsonlite::toJSON(pretty = TRUE, auto_unbox = TRUE)

  writeLines(json, file)

  invisible(json)
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


# prepare inputs for default values
prepare_defaults <- function(sector = NULL,
                             season = NULL,
                             gender = NULL,
                             category = NULL,
                             discipline = NULL,
                             active_only = NULL) {
  
  if (!is.null(sector)) {
    sector <- find_code(sector, "sector")
  }

  if (!is.null(season)) {
    season_int <- suppressWarnings(as.integer(season))
    if (season == "") {
      season <- ""
    } else if (is.na(season_int) | season_int < 1950 |
        season_int > lubridate::year(today()) + 1) {
      cli::cli_warn("'{season}' is not a valid season.")
      season <- NULL
    } else {
      season <- as.character(season_int)
    }
  }

  if (!is.null(gender)) {
    std_gender <- standardise_gender(gender)
    if (!std_gender %in% c("", "M", "W")) {
      cli::cli_warn("'{gender}' is not a valid gender code.")
      gender <- NULL
    } else {
      gender <- std_gender
    }
  }

  if (!is.null(category)) {
    category <- find_code(category, "category")
  }

  if (!is.null(discipline)) {
    # discipline depends on sector. If a sector has been passed to this
    # function, use it. Otherwise, use the current default.
    discipline_sector <- if (!is.null(sector)) sector else fd_def("sector")
    discipline <- find_code(discipline, "discipline",
                            sector = discipline_sector)
  }

  if (!is.null(active_only)) {
    if (!active_only %in% c(TRUE, FALSE)) {
      cli::cli_warn("'{active_only}' is not valid for active_only.")
      active_only <- NULL
    }
  }
  
  list(sector = sector,
       season = season,
       gender = gender,
       category = category,
       discipline = discipline,
       active_only = active_only)
}
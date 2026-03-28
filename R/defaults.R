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
      alert_default(name, verbose)
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
#' it is read automatically when fisdata is attached in an interactive
#' session (see 'Details' for how to configure this behaviour).
#' 
#' @param file name of the JSON file to read or write
#' @param overwrite should an existing file be overwritten?
#' @inheritParams query_athletes
#' @inheritParams query_results
#' 
#' @details
#' When fisdata is attached in an interactive session, it tries to load defaults
#' from a file `fisdata.json`. You can use another file by setting the environment
#' variable `FISDATA_DEFAULTS_FILE` to the path to this file before attaching
#' fisdata. To do this once, you can use [Sys.setenv()], to configure R to always
#' load a different file, you can set `FISDATA_DEFAULTS_FILE` in your `.Renviron`
#' file. 
#' 
#' @returns
#' `write_fisdata_defaults()` and `write_current_fisdata_defaults()` return the json-string that
#' was written to the file (invisibly). `read_fisdata_defaults()` returns the default
#' values that were read as a tibble (invisibly).
#' 
#' @export

write_fisdata_defaults <- function(file = "~/.fisdata.json",
                                   overwrite = FALSE,
                                   sector = "",
                                   season = "",
                                   gender = "",
                                   category = "",
                                   discipline = "",
                                   active_only = FALSE) {
  defs <- prepare_defaults(sector = sector,
                           season = season,
                           gender = gender,
                           category = category,
                           discipline = discipline,
                           active_only = active_only)
  write_fisdata_defaults_(defs, file, overwrite)
}


#' @rdname write_fisdata_defaults
#' @export

write_current_fisdata_defaults <- function(file = "~/.fisdata.json",
                                           overwrite = FALSE) {
  write_fisdata_defaults_(get_fisdata_defaults(), file, overwrite)
}


# helper function that writes a list or tibble of defaults to a JSON file
write_fisdata_defaults_ <- function(defaults, 
                                    file = "~/.fisdata.json",
                                    overwrite = FALSE,
                                    error_call = rlang::caller_env()) {
  
  if (file.exists(file) && !overwrite) {
    cli::cli_abort("The file {file} exists. Use `overwrite = TRUE` to overwrite it.")
  }

  # don't write NULL for any default to the file
  def_is_null <- purrr::map_lgl(defaults, is.null)
  if (any(def_is_null)) {
    null_names <- names(def_is_null)[def_is_null]
    cli::cli_abort(
      c(
        "!" = "Defaults must no be NULL when writing to a json file.", 
        "i" = "The following value{?s} {?is/are} NULL: {null_names}."
      ),
      call = error_call
    )
  }

  json <- defaults %>%
    # convert to a list to avoid having an unnecessary length-one array
    as.list() %>% 
    jsonlite::toJSON(pretty = TRUE, auto_unbox = TRUE)

  writeLines(json, file)

  invisible(json)
}


#' @param apply should the defaults be applied? 
#' @param verbose should the function create output. This defaults
#'  to `TRUE` in interactive sessions or when `apply` is `FALSE`.
#' @rdname write_fisdata_defaults
#' 
#' @export

read_fisdata_defaults <- function(file = "~/.fisdata.json", 
                          apply = TRUE,
                          verbose = !apply || interactive()) {

  if (!file.exists(file)) {
    cli::cli_abort("The file {file} does not exist.")
  }

  raw <- purrr::possibly(jsonlite::fromJSON)(file)
  if (is.null(raw)) {
    cli::cli_abort("Failed to parse file {file} as JSON.")
  }

  # check that all the expected values are present.
  expected <- c("sector", "season", "gender", "category", "discipline", "active_only")
  is_present <- expected %in% names(raw)
  if (any(!is_present)) {
    cli::cli_abort("Some defaults have no value set: {expected[!is_present]}")
  }

  # run the contents of the file through prepare_defs() to check
  # that the values are valid.
  error_call = rlang::current_call()
  defs <- tryCatch(
    do.call(prepare_defaults, raw[names(raw) %in% expected]),
    error = function(e) {
      cli::cli_abort(c("The contents of file {file} are not valid.",
                       "i" = "Error message: {e$message}"),
                      call = error_call)
    },
    warning = function(w) {
      cli::cli_abort(c("The contents of file {file} are not valid.",
                       "i" = "Warning message: {w$message}"),
                      call = error_call)
    }
  )

  # if verbose and the default are not to be applied, print them here
  # in case the defaults are applied, set_fisdata_defaults() will create output.
  if (verbose && !apply) {
    cli::cli_alert_info("The file {file} contains the following defaults:")
    print(dplyr::as_tibble(defs))
  }

  # if requested, apply the defaults
  if (apply) {
    do.call(set_fisdata_defaults, c(defs, list(verbose = verbose)))
  }

  invisible(dplyr::as_tibble(defs))
}


# issue a message describing the default value that has been set.
# The function must be called AFTER setting the default.
alert_default <- function(type, verbose) {

  if (!verbose) {
    return(NULL)
  }

  # get the default value that has been set
  value <- fd_def(type)
  
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
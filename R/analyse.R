#' Summarise athlete's results
#'
#' Summarise the results of an athlete as they are returned by
#' [query_results()].
#'
#' @param results athlete's results as returned by [query_results()]. The
#'  function can also handle the results from multiple athletes that are
#'  combined into a single tibble with [dplyr::bind_rows()].
#' @param by variables to groups the results by. Possible values are "season",
#'  "category", "discipline", "place", and "nation".
#'  Values are partially matched. In addition, the function always groups by
#'  athlete. Set this value to an empty vector (`c()`) or `NA` to summarise
#'  without additional grouping (i.e., only by athlete).
#' @param show_pos numeric that controls the summary of ranks. Indicate the
#'  break points for the ranks to summarise. The function will then return
#'  counts for the number of ranks that are at least as good as each break
#'  point and worse then the next better break point. Set this value to an
#'  empty vector (`c()`) or `FALSE` to not include the position summaries.
#' @param show_victories logical, should the count of victories (rank 1) be
#'  returned?
#' @param show_podiums logical,  should the count of podiums (ranks 1 to 3)
#'  be returned?
#' @param show_dnf logical, should the races where the athlete did not finish
#'  be counted?
#' @param show_races logical, should the number of races be returned?
#' @param show_points logical, should the sum of the cup points be returned?
#' @param add_relative add relative values, i.e., the value divided by the
#'  number of races, for all summary columns except "races".
#'
#' @returns
#' a `tibble` which always contains `athlete` as its first column. In addition,
#' it contains the grouping columns indicated by the argument `by` and possibly
#' one or several columns containing the requested summaries.
#'
#' @examples
#' \dontrun{
#' # get Marco Odermatts World Cup results
#' odermatt <- query_athletes("odermatt", "marco")
#' odermatt_res <- query_results(odermatt, category = "WC")
#'
#' # summarise by category and season
#' summarise_results(odermatt_res, by = c("category", "season"))
#'
#' # summarise by category, season, and discipline, only show podiums
#' summarise_results(odermatt_res, by = c("category", "season", "discipline"),
#'                   show_pos = 1:3, show_dnf = FALSE, show_races = FALSE,
#'                   show_points = FALSE)
#' }
#'
#' @export

summarise_results <- function(results,
                              by = c("season", "category", "discipline"),
                              show_pos = c(1, 2, 3, 5, 10, 20, 30),
                              show_dnf = TRUE,
                              show_victories = FALSE,
                              show_podiums = TRUE,
                              show_races = TRUE,
                              show_points = TRUE,
                              add_relative = FALSE) {

  grp_by <- c(
    "athlete",
    match_groupings(by, c("season", "category", "discipline", "place", "nation"))
  )

  # prepare show_pos: should positions be summarised?
  # if so, sort, remove duplicates, handle invalid inputs
  do_show_pos <- !isFALSE(show_pos) && length(show_pos) > 0
  if (do_show_pos) {
    # check for non-integer values
    if (!is.numeric(show_pos) |
        any(show_pos != suppressWarnings(as.integer(show_pos)))) {
      cli::cli_abort("show_pos must be a vector of integer values.")
    }
    # check for duplicates
    if (any(duplicated(show_pos))) {
      cli::cli_warn(c("!" = "Duplicated values in show_pos are removed."))
      show_pos <- unique(show_pos)
    }
    show_pos <- sort(unique(show_pos))
  }

  res <- results %>%
    dplyr::filter(.data$category != "Training") %>%
    dplyr::mutate(season = get_season_at_date(.data$date)) %>%
    dplyr::select(dplyr::all_of(grp_by), "rank",
                  if (show_points) "cup_points")

  if (show_victories) {
    res[["victories"]] <- res$rank == 1
  }

  if (show_podiums) {
    res[["podiums"]] <- res$rank <= 3
  }

  if (do_show_pos) {
    # add columns for position count
    # the first column needs special treatment
    if (show_pos[1] == 1) {
      res[["pos1"]] <- res$rank == 1
    } else {
      res[[glue::glue("top{show_pos[1]}")]] <- res$rank <= show_pos[1]
    }
    # the remaining positions can be treated in a loop
    if (length(show_pos) > 1) {
      for (i in 2:length(show_pos)) {
        # disinguish between an isolated position and a range of positions
        if (show_pos[i] == show_pos[i - 1] + 1) {
          res[[glue::glue("pos{show_pos[i]}")]] <- res$rank == show_pos[i]
        } else {
          res[[glue::glue("top{show_pos[i]}")]] <-
            dplyr::between(res$rank, show_pos[i - 1] + 1, show_pos[i])
        }
      }
    }
  }

  if (show_dnf) {
    res[["dnf"]] <- is.na(res$rank)
  }

  # if add_relative is TRUE, we need the number of races
  if (show_races || add_relative) {
    res[["races"]] <- 1L
  }

  # move cup_points to the end
  if (show_points) {
    res <- res %>% dplyr::relocate("cup_points", .after = dplyr::last_col())
  }

  summary <- res %>%
    dplyr::select(-"rank") %>%
    dplyr::summarise(
      dplyr::across(dplyr::everything(), \(x) sum(x, na.rm = TRUE)),
    .by = dplyr::all_of(grp_by)
    )

  if (add_relative) {
    # add the relative columns in a loop such that each can be placed after
    # the corresponding absolute value
    sum_cols <- setdiff(names(summary), c(grp_by, "races"))
    for  (col in sum_cols) {
      summary <- summary %>%
        dplyr::mutate(
          "{col}_rel" := .data[[col]] / .data$races,
          .after = dplyr::all_of(col)
        )
    }
  }

  # remove the column races, if it was not requested
  if (!show_races) {
    summary <- summary %>%
      dplyr::select(-dplyr::any_of("races"))
  }

  summary
}


#' Get the debut races, podiums or victories for an athlete
#'
#' @inheritParams query_results
#' @param by variables to groups the results by. Possible values are "category",
#'  and "discipline". Values are partially matched. Set this value
#'  to an empty vector (`c()`) or `NA` to summarise without grouping.
#' @param type which type of debut to get: the first race ("race"), the first
#'  podium ("podium"), or the first victory ("victory").
#'
#' @return
#' A tibble with the following columns: `athlete`, `date`, `place`, `nation`,
#' `sector`, `category`, `discipline`, `rank`, `fis_points`, `cup_points`,
#' and `race_id`.
#'
#' @examples
#' \dontrun{
#' # get Marco Odermatt's World Cup debuts by discipline
#' odermatt <- query_athletes("odermatt", "marco")
#' get_debuts(odermatt, category = "WC")
#'
#' # get first victory by category
#' get_debuts(odermatt, by = "category", type = "victory")
#' }
#'
#' @export

get_debuts <- function(athlete,
                       category = fd_def("category"),
                       discipline = fd_def("discipline"),
                       by = c("category", "discipline"),
                       type = c("race", "podium", "victory")) {

  type <- match.arg(type)
  grp_by <- match_groupings(by, c("category", "discipline"))

  athlete <- ensure_one_athlete(athlete)

  # get results for all seasons independent of defaults
  results <- query_results(athlete, season = "", category = category,
                           place = "", discipline = discipline) %>%
    dplyr::filter(.data$category != "Training")

  # limit the races to those of the requested type, i.e., all races,
  # podiums or victories.
  if (type == "podium") {
    results <- results %>% dplyr::filter(.data$rank <= 3)
  } else if (type == "victory") {
    results <- results %>% dplyr::filter(.data$rank == 1)
  }

  results %>%
    dplyr::filter(.data$date == min(.data$date),
                  .by = dplyr::all_of(grp_by)) %>%
    dplyr::arrange(dplyr::desc(.data$date)) %>%
    dplyr::mutate(age = compute_age_at_date(.data$date, !!athlete),
                  .after = "date")
}


match_groupings <- function(by, choices, error_call = rlang::caller_env()) {

  # NA and c() both imply no grouping
  if (all(is.na(by)) || length(by) == 0) {
    return(character())
  }

  grp_matches <- pmatch(by, choices, duplicates.ok = TRUE)
  if (any(is.na(grp_matches))) {
    cli::cli_abort(
      "Invalid grouping variables:
        {glue::single_quote(by[is.na(grp_matches)])}",
      call = error_call
    )
  }
  unique(choices[grp_matches])
}

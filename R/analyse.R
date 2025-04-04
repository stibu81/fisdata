#' Summarise athlete's results
#'
#' Summarise the results of an athlete as they are returned by
#' [query_results()].
#'
#' @param results athlete's results as returned by [query_results()].
#' @param by variables to groups the results by. Possible values are "season",
#'  "category" and "discipline". Values are partially matched.
#' @param show_pos numeric that controls the summary of ranks. Indicate the
#'  break points for the ranks to summarise. The function will then return
#'  counts for the number of ranks that are at least as good as each break
#'  point an worse then the next better break point. Set this value to an
#'  empty vector (`c()`) or `NA` to not include the position summaries.
#' @param show_podiums logical,  should the count of podiums (ranks 1 to 3)
#'  be returned?
#' @param show_dnf logical, should the races where the athlete did not finish
#'  be counted?
#' @param show_n_races logical, should the number of races be returned?
#' @param show_points logical, should the sum of the cup points be returned?
#'
#' @returns
#' a `tibble` which always contains `athlete` as its first column. In addition,
#' it contains the grouping columns indicated by the argument `by` and possibly
#' one or several columns containing the requested summaries.
#'
#' @export

summarise_results <- function(results,
                              by = c("season", "category", "discipline"),
                              show_pos = c(1, 2, 3, 5, 10, 20, 30),
                              show_dnf = TRUE,
                              show_podiums = TRUE,
                              show_n_races = TRUE,
                              show_points = TRUE) {

  # determine the grouping
  grp_by <- if (all(is.na(by)) || length(by) == 0) {
    "athlete"
  } else {
    c("athlete", match.arg(by, several.ok = TRUE))
  }

  # prepare show_pos: should positions be summarised?
  # if so, sort, remove duplicates, handle invalid inputs
  do_show_pos <- !isFALSE(show_pos) && length(show_pos) > 0
  if (do_show_pos) {
    # check for non-integer values
    if (!is.numeric(show_pos) | any(show_pos != as.integer(show_pos))) {
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

  if (show_podiums) {
    res[["podium"]] <- res$rank <= 3
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

  if (show_n_races) {
    res[["n_races"]] <- 1
  }

  # move cup_points to the end
  if (show_points) {
    res <- res %>% dplyr::relocate("cup_points", .after = dplyr::last_col())
  }

  res %>%
    dplyr::select(-"rank") %>%
    dplyr::summarise(
      dplyr::across(dplyr::everything(), \(x) sum(x, na.rm = TRUE)),
      .by = dplyr::all_of(grp_by)
    )
}

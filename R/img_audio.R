#' Get an Image of an Athlete
#'
#' Download the image of an athlete from the FIS page. Images are not available
#' for all athletes.
#'
#' @param athlete a list or data frame with the field/column `competitor_id`
#'  that describe a *single* athlete. The easiest way to create
#'  such a data frame is through the functions [query_athletes()],
#'  [query_race()], or [query_standings()]. These functions
#'  can return multiple athletes, but `get_athlete_image()` only downloads the
#'  image for one athlete. If multiple athletes are passed, only the first
#'  one will be used.
#' @param file if given, the image file will be stored to the given path.
#'  The image files are png or jpg and the file ending will be added
#'  automatically depending on the file type. Any user provided file ending
#'  will be ignored.
#'
#' @details
#' The image resolution is 100 x 100.
#'
#' @return
#' `NULL` invisibly. As a side effect, the image is displayed and, if `file`
#' is given, stored to the requested path.
#'
#' @export

get_athlete_image <- function(athlete, file = NULL) {
  athlete <- ensure_one_athlete(athlete)
  id <- athlete$competitor_id

  url <- glue::glue(
    "https://data.fis-ski.com/general/load-competitor-picture/{id}.html"
  )

  # download the image
  tmpfile <- tempfile(id)
  download <- suppressWarnings(
    try(utils::download.file(url, tmpfile, quiet = TRUE), silent = TRUE)
  )

  if (inherits(download, "try-error")) {
    cli::cli_abort(c("x" = "download of image file failed"))
  }

  # determine the file type
  file_type <- determine_img_format(tmpfile)
  if (file_type == "unknown") {
    cli::cli_abort(c("x" = "invalid image file"))
  }

  # if requested, save the file
  if (!is.null(file)) {
    file <- paste0(stringr::str_remove(file, "\\..*$"), ".", file_type)
    file.copy(tmpfile, file)
  }

  # plot
  img <- if (file_type == "png") {
    png::readPNG(tmpfile)
  } else {
    jpeg::readJPEG(tmpfile)
  }
  raster <- grid::rasterGrob(img, interpolate = TRUE)
  grid::grid.newpage()
  grid::grid.draw(raster)

  invisible(NULL)
}


#' Play Athlete's Name in Browser
#'
#' For some athlete's, an audio file where they speak their name is available
#' on the FIS page. This functions opens that page in the browser.
#'
#' @param athlete a list or data frame with the field/column `competitor_id`
#'  that describe a *single* athlete. The easiest way to create
#'  such a data frame is through the functions [query_athletes()],
#'  [query_race()], or [query_standings()]. These functions
#'  can return multiple athletes, but `play_athlete_name()` only plays the
#'  audio file for one athlete. If multiple athletes are passed, only the first
#'  one will be used.
#' @param file if given, the audio file will be stored to the given path.
#'  The file is in the mp3 format and the file ending will be added
#'  automatically. Any user provided file ending will be ignored.
#'
#' @return
#' `NULL` invisibly. As a side effect, the mp3 file is played in the browser
#' (if it exists) and, if `file` is given, stored to the requested path.
#'
#' @export

play_athlete_name <- function(athlete, file = NULL) {
  athlete <- ensure_one_athlete(athlete)
  id <- athlete$competitor_id

  url <- glue::glue(
    "https://www.fis-ski.com/DB/v2/download/athlete-name-audio/{id}.mp3"
  )

  # if requested, save the file
  if (!is.null(file)) {
      file <- paste0(stringr::str_remove(file, "\\..*$"), ".mp3")
      download <- suppressWarnings(
        try(utils::download.file(url, file, quiet = TRUE), silent = TRUE)
      )

    if (inherits(download, "try-error")) {
      cli::cli_abort(c("x" = "download of audio file failed"))
    }
  }

  utils::browseURL(url)

  invisible(NULL)
}


# the images are sometimes png, sometimes jpg. This function uses the first
# bytes of the file to determine the format.
determine_img_format <- function(file) {

  signatures <- list(
    png = as.raw(c(0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A)),
    jpg = as.raw(c(0xFF, 0xD8, 0xFF))
  )

  raw <- readBin(file, "raw", n = max(lengths(signatures)))

  for (type in names(signatures)) {
    sig <- signatures[[type]]
    if (identical(raw[1:length(sig)], sig)) {
      return(type)
    }
  }

  return("unknown")
}


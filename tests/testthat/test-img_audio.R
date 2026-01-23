library(stringr)
library(vdiffr)
library(withr)

# mock function for file download that copies a test image
download.file_mock <- function(url, destfile, ...) {
  id <- str_extract(url, "(\\d+)\\.(html|mp3)$", group = 1)
  file <- test_path("data", id)
  file.copy(file, destfile, overwrite = TRUE)
}


test_that("get_athlete_image() displays images", {
  local_mocked_bindings(
    download.file = download.file_mock,
    .package = "utils"
  )
  athlete <- list(competitor_id = "12345")
  expect_doppelganger("athlete image png", get_athlete_image(athlete)) %>%
    # expect_doppelganger calls print on the tested code which, in this case,
    # leads to the output of "NULL", because get_athlete_image() returns NULL.
    # Using capture_output() suppresses this output.
    capture_output()
  # the jpg on Windows and MacOS is slightly differnet, so the test must
  # be skipped on those OSes
  skip_on_os(c("windows", "mac"))
  athlete <- list(competitor_id = "23456")
  expect_doppelganger("athlete image jpg", get_athlete_image(athlete)) %>%
    capture_output()
})


test_that("get_athlete_image() copies images", {
  local_mocked_bindings(
    download.file = download.file_mock,
    .package = "utils"
  )
  athlete <- list(competitor_id = "12345")
  with_file(
    c("skier.png", "dump.pdf"),
    {
      pdf("dump.pdf")
      get_athlete_image(athlete, "skier")
      dev.off()
      expect_true(file.exists("skier.png"))
    }
  )
  athlete <- list(competitor_id = "23456")
  with_file(
    c("skier.jpg", "dump.pdf"),
    {
      pdf("dump.pdf")
      get_athlete_image(athlete, "skier")
      dev.off()
      expect_true(file.exists("skier.jpg"))
    }
  )
})


test_that("get_athlete_image() handles invalid file format", {
  local_mocked_bindings(
    download.file = download.file_mock,
    .package = "utils"
  )
  athlete <- list(competitor_id = "34567")
  expect_error(get_athlete_image(athlete), "invalid image file")
})


test_that("get_athlete_image() handles failing download", {
  local_mocked_bindings(
    download.file = function(...) stop(),
    .package = "utils"
  )
  athlete <- list(competitor_id = "34567")
  expect_error(get_athlete_image(athlete), "download of image file failed")
})



test_that("play_athlete_name() starts browser", {
  local_mocked_bindings(
    # print the url that is sent to the browser such that the test can
    # capture it
    browseURL = function(url, ...) message(url),
    .package = "utils"
  )
  athlete <- list(competitor_id = "12345")
  expect_null(play_athlete_name(athlete)) %>%
    expect_message(
      "https://www.fis-ski.com/DB/v2/download/athlete-name-audio/12345.mp3"
    )
})


test_that("play_athlete_name() copies audio file", {
  local_mocked_bindings(
    browseURL = function(...) return(NULL),
    download.file = download.file_mock,
    .package = "utils"
  )
  athlete <- list(competitor_id = "12345")
  with_file(
    "skier.mp3",
    {
      play_athlete_name(athlete, "skier")
      expect_true(file.exists("skier.mp3"))
    }
  )
})


test_that("play_athlete_name() handles failing download", {
  local_mocked_bindings(
    browseURL = function(...) return(NULL),
    download.file = function(...) stop(),
    .package = "utils"
  )
  athlete <- list(competitor_id = "34567")
  expect_error(play_athlete_name(athlete, "skier"),
               "download of audio file failed")
})

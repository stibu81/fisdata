library(dplyr, warn.conflicts = FALSE)

test_that("get_results_url() works with valid inputs", {
  cuche <- tibble(name = "Cuche Didier",
                  discipline = "AL",
                  competitor_id = "11795")
  expect_equal(
    get_results_url(cuche),
    paste0("https://www.fis-ski.com/DB/general/athlete-biography.html?",
           "sectorcode=AL&seasoncode=&competitorid=11795&type=result&",
           "categorycode=&sort=&place=&disciplinecode=&position=&limit=2000")
  )
  expect_equal(
    get_results_url(cuche, category = "WC", event = "SG"),
    paste0("https://www.fis-ski.com/DB/general/athlete-biography.html?",
           "sectorcode=AL&seasoncode=&competitorid=11795&type=result&",
           "categorycode=WC&sort=&place=&disciplinecode=SG&position=&",
           "limit=2000")
  )
  expect_equal(
    get_results_url(cuche, event = "DH", season = "2010", place = "Kitzbühel"),
    paste0("https://www.fis-ski.com/DB/general/athlete-biography.html?",
           "sectorcode=AL&seasoncode=2010&competitorid=11795&type=result&",
           "categorycode=&sort=&place=kitzbuehel&disciplinecode=DH&",
           "position=&limit=2000")
  )
})


test_that("ensure_one_athlete() works", {
  cuche2 <- tibble(name = c("Cuche Didier", "Cuche Remi"),
                   discipline = "AL",
                   competitor_id = c("11795", "212253"))
  expect_equal(ensure_one_athlete(cuche2), cuche2[1, ]) %>%
    expect_warning("Multiple athletes.*Cuche Didier")
  expect_equal(ensure_one_athlete(cuche2[1, ]), cuche2[1, ]) %>%
    expect_silent()
  expect_error(ensure_one_athlete(cuche2[integer(0), ]),
               "No athlete was passed")
})


test_that(
  "query_results() works for alpline skiing results for all categories",
  {

    local_mocked_bindings(
      get_results_url = function(...) test_path("data", "results_al_all.html.gz")
    )
    cuche <- tibble(name = "Cuche Didier",
                    discipline = "AL",
                    competitor_id = "11795")
    dh <- query_results(cuche)

    expect_s3_class(dh, "tbl_df")

    expected_names <- c("athlete", "date", "place", "nation", "discipline",
                        "category", "event", "rank", "fis_points",
                        "cup_points", "race_id")
    expect_named(dh, expected_names)

    expected_types <- rep("character", 11) %>%
      replace(c(2, 8:10), c("Date", "integer", "double", "double"))
    for (i in seq_along(expected_types)) {
      if (expected_types[i] == "Date") {
        expect_s3_class(dh[[!!expected_names[i]]], expected_types[i])
      } else {
        expect_type(dh[[!!expected_names[i]]], expected_types[i])
      }
    }

    expect_in(dh$athlete, "Cuche Didier")
    expect_match(cuche$name, "cuche", ignore.case = TRUE)
    expect_in(dh$nation, nations$code)
    expect_true(
      all(between(dh$date, as.Date("2009-11-01"), as.Date("2010-03-31")))
    )
    expect_in(dh$discipline, "AL")
    expect_in(dh$category, c(categories$description, "World Cup Speed Event"))
    expect_in(dh$event, "Downhill")
    expect_in(dh$rank, c(0:100, NA_integer_))
    expect_true(all(na.omit(dh$fis_points) >= 0))
    expect_in(na.omit(dh$cup_points), 0:100)
    expect_match(dh$race_id, "^\\d+$")

    expect_snapshot(print(dh, width = Inf, n = Inf))
  }
)


test_that(
  "query_results() works for alpline skiing results for trainings",
  # trainings have no data for fis_points and cup_points
  {
    local_mocked_bindings(
      get_results_url = function(...) test_path("data", "results_al_tra.html.gz")
    )
    cuche <- tibble(name = "Cuche Didier",
                    discipline = "AL",
                    competitor_id = "11795")
    tra <- query_results(cuche)

    expect_s3_class(tra, "tbl_df")

    expected_names <- c("athlete", "date", "place", "nation", "discipline",
                        "category", "event", "rank", "fis_points",
                        "cup_points", "race_id")
    expect_named(tra, expected_names)

    expected_types <- rep("character", 11) %>%
      replace(c(2, 8:10), c("Date", "integer", "double", "double"))
    for (i in seq_along(expected_types)) {
      if (expected_types[i] == "Date") {
        expect_s3_class(tra[[!!expected_names[i]]], expected_types[i])
      } else {
        expect_type(tra[[!!expected_names[i]]], expected_types[i])
      }
    }

    expect_in(tra$athlete, "Cuche Didier")
    expect_match(cuche$name, "cuche", ignore.case = TRUE)
    expect_in(tra$nation, nations$code)
    expect_true(
      all(between(tra$date, as.Date("2009-11-01"), as.Date("2010-03-31")))
    )
    expect_in(tra$discipline, "AL")
    expect_in(tra$category, "Training")
    expect_in(tra$event, "Downhill")
    expect_in(tra$rank, c(0:100, NA_integer_))
    expect_in(tra$fis_points, NA_real_)
    expect_in(tra$cup_points, NA_real_)
    expect_match(tra$race_id, "^\\d+$")

    expect_snapshot(print(tra, width = Inf, n = Inf))
  }
)


test_that(
  "query_results() works for alpline skiing results for World Championships",
  # world championsships have not data for cup_points, but fis_points are
  # available (as for Olympic Games, National Championships and others)
  {
    local_mocked_bindings(
      get_results_url = function(...) test_path("data", "results_al_wcs.html.gz")
    )
    cuche <- tibble(name = "Cuche Didier",
                    discipline = "AL",
                    competitor_id = "11795")
    wcs <- query_results(cuche)

    expect_s3_class(wcs, "tbl_df")

    expected_names <- c("athlete", "date", "place", "nation", "discipline",
                        "category", "event", "rank", "fis_points",
                        "cup_points", "race_id")
    expect_named(wcs, expected_names)

    expected_types <- rep("character", 11) %>%
      replace(c(2, 8:10), c("Date", "integer", "double", "double"))
    for (i in seq_along(expected_types)) {
      if (expected_types[i] == "Date") {
        expect_s3_class(wcs[[!!expected_names[i]]], expected_types[i])
      } else {
        expect_type(wcs[[!!expected_names[i]]], expected_types[i])
      }
    }

    expect_in(wcs$athlete, "Cuche Didier")
    expect_match(cuche$name, "cuche", ignore.case = TRUE)
    expect_in(wcs$nation, nations$code)
    expect_in(wcs$discipline, "AL")
    expect_in(wcs$category, "World Championships")
    expect_in(wcs$event, "Super G")
    expect_in(wcs$rank, c(0:100, NA_integer_))
    expect_true(all(na.omit(wcs$fis_points) >= 0))
    expect_in(wcs$cup_points, NA_real_)
    expect_match(wcs$race_id, "^\\d+$")

    expect_snapshot(print(wcs, width = Inf, n = Inf))
  }
)


test_that(
  "query_results() works for empty result",
  {
    local_mocked_bindings(
      get_results_url = function(...) test_path("data", "results_empty.html.gz")
    )
    cuche <- tibble(name = "Cuche Didier",
                    discipline = "AL",
                    competitor_id = "11795")
    empty <- query_results(cuche)

    expect_s3_class(empty, "tbl_df")

    expected_names <- c("athlete", "date", "place", "nation", "discipline",
                        "category", "event", "rank", "fis_points",
                        "cup_points", "race_id")
    expect_named(empty, expected_names)

    expected_types <- rep("character", 11) %>%
      replace(c(2, 8:10), c("Date", "integer", "double", "double"))
    for (i in seq_along(expected_types)) {
      if (expected_types[i] == "Date") {
        expect_s3_class(empty[[!!expected_names[i]]], expected_types[i])
      } else {
        expect_type(empty[[!!expected_names[i]]], expected_types[i])
      }
    }
  }
)


test_that("query_results() warns for large result", {
  local_mocked_bindings(
    get_results_url = function(...) NULL,
    extract_results = function(...) tibble(category = 1:2001)
  )

  cuche <- tibble(name = "Cuche Didier",
                  discipline = "AL",
                  competitor_id = "11795")
  expect_warning(
    query_results(cuche),
    "Maximum number of 2'000 results reached"
  )
})

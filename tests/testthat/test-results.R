library(dplyr, warn.conflicts = FALSE)
fisdata:::clear_cache()

# full athlete data for didier cuche which is used in multiple tests
cuche <- tibble(
  active = FALSE,
  fis_code = "510030",
  name = "Cuche Didier",
  nation = "SUI",
  birthdate = "1974",
  gender = "M",
  sector = "AL",
  club = "Chasseral Dombresson",
  brand = "Head",
  competitor_id = "11795"
)


test_that("get_results_url() works with valid inputs", {
  expect_equal(
    get_results_url(cuche),
    paste0("https://www.fis-ski.com/DB/general/athlete-biography.html?",
           "sectorcode=AL&seasoncode=&competitorid=11795&type=result&",
           "categorycode=&sort=&place=&disciplinecode=&position=&limit=2000")
  )
  expect_equal(
    get_results_url(cuche, category = "WC", discipline = "SG"),
    paste0("https://www.fis-ski.com/DB/general/athlete-biography.html?",
           "sectorcode=AL&seasoncode=&competitorid=11795&type=result&",
           "categorycode=WC&sort=&place=&disciplinecode=SG&position=&",
           "limit=2000")
  )
  expect_equal(
    get_results_url(cuche, discipline = "DH", season = "2010", place = "Kitzbühel"),
    paste0("https://www.fis-ski.com/DB/general/athlete-biography.html?",
           "sectorcode=AL&seasoncode=2010&competitorid=11795&type=result&",
           "categorycode=&sort=&place=kitzbuehel&disciplinecode=DH&",
           "position=&limit=2000")
  )
})


test_that("ensure_one_athlete() works", {
  cuche2 <- tibble(name = c("Cuche Didier", "Cuche Remi"),
                   sector = "AL",
                   competitor_id = c("11795", "212253"))
  expect_equal(ensure_one_athlete(cuche2), cuche2[1, ]) %>%
    expect_warning("Multiple athletes.*Cuche Didier")
  expect_equal(ensure_one_athlete(cuche2[1, ]), cuche2[1, ]) %>%
    expect_silent()
  expect_error(ensure_one_athlete(cuche2[integer(0), ]),
               "No athlete was passed")
})


test_that(
  "query_results() works for alpine skiing results for all categories",
  {
    local_mocked_bindings(
      get_results_url = function(...) test_path("data", "results_al_all.html.gz")
    )
    dh <- query_results(cuche)

    expect_s3_class(dh, "tbl_df")

    expected_names <- c("athlete", "date", "age", "place", "nation", "sector",
                        "category", "discipline", "rank", "fis_points",
                        "cup_points", "race_id")
    expect_named(dh, expected_names)

    expected_types <- rep("character", 12) %>%
      replace(c(2:3, 9:11), c("Date", "double", "integer", "double", "double"))
    for (i in seq_along(expected_names)) {
      if (expected_types[i] == "Date") {
        expect_s3_class(dh[[!!expected_names[i]]], expected_types[i])
      } else {
        expect_type(dh[[!!expected_names[i]]], expected_types[i])
      }
    }

    expect_in(dh$athlete, "Cuche Didier")
    expect_match(dh$athlete, "cuche", ignore.case = TRUE)
    expect_in(dh$nation, nations$code)
    expect_true(
      all(between(dh$date, as.Date("2009-11-01"), as.Date("2010-03-31")))
    )
    expect_in(dh$age, 15:40)
    expect_in(dh$sector, "AL")
    expect_in(dh$category, c(categories$description, "World Cup Speed Event"))
    expect_in(dh$discipline, "Downhill")
    expect_in(dh$rank, c(0:100, NA_integer_))
    expect_true(all(na.omit(dh$fis_points) >= 0))
    expect_in(na.omit(dh$cup_points), 0:100)
    expect_match(dh$race_id, "^\\d+$")

    expect_equal(attr(dh, "athlete"), cuche)
    expect_equal(attr(dh, "url"), get_results_url())

    expect_snapshot(print(dh, width = Inf, n = Inf))
  }
)


test_that(
  "query_results() works for alpine skiing results for trainings",
  # trainings have no data for fis_points and cup_points
  {
    local_mocked_bindings(
      get_results_url = function(...) test_path("data", "results_al_tra.html.gz")
    )
    tra <- query_results(cuche, add_age = FALSE)

    expect_s3_class(tra, "tbl_df")

    expected_names <- c("athlete", "date", "place", "nation", "sector",
                        "category", "discipline", "rank", "fis_points",
                        "cup_points", "race_id")
    expect_named(tra, expected_names)

    expected_types <- rep("character", 11) %>%
      replace(c(2, 8:10), c("Date", "integer", "double", "double"))
    for (i in seq_along(expected_names)) {
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
    expect_in(tra$sector, "AL")
    expect_in(tra$category, "Training")
    expect_in(tra$discipline, "Downhill")
    expect_in(tra$rank, c(0:100, NA_integer_))
    expect_in(tra$fis_points, NA_real_)
    expect_in(tra$cup_points, NA_real_)
    expect_match(tra$race_id, "^\\d+$")

    expect_equal(attr(tra, "athlete"), cuche)
    expect_equal(attr(tra, "url"), get_results_url())

    expect_snapshot(print(tra, width = Inf, n = Inf))
  }
)


test_that(
  "query_results() works for alpine skiing results for World Championships",
  # world championsships have not data for cup_points, but fis_points are
  # available (as for Olympic Games, National Championships and others)
  {
    local_mocked_bindings(
      get_results_url = function(...) test_path("data", "results_al_wsc.html.gz")
    )
    wsc <- query_results(cuche)

    expect_s3_class(wsc, "tbl_df")

    expected_names <- c("athlete", "date", "age", "place", "nation", "sector",
                        "category", "discipline", "rank", "fis_points",
                        "cup_points", "race_id")
    expect_named(wsc, expected_names)

    expected_types <- rep("character", 12) %>%
      replace(c(2:3, 9:11), c("Date", "double", "integer", "double", "double"))
    for (i in seq_along(expected_names)) {
      if (expected_types[i] == "Date") {
        expect_s3_class(wsc[[!!expected_names[i]]], expected_types[i])
      } else {
        expect_type(wsc[[!!expected_names[i]]], expected_types[i])
      }
    }

    expect_in(wsc$athlete, "Cuche Didier")
    expect_match(cuche$name, "cuche", ignore.case = TRUE)
    expect_in(wsc$age, 15:40)
    expect_in(wsc$nation, nations$code)
    expect_in(wsc$sector, "AL")
    expect_in(wsc$category, "World Championships")
    expect_in(wsc$discipline, "Super G")
    expect_in(wsc$rank, c(0:100, NA_integer_))
    expect_true(all(na.omit(wsc$fis_points) >= 0))
    expect_in(wsc$cup_points, NA_real_)
    expect_match(wsc$race_id, "^\\d+$")

    expect_equal(attr(wsc, "athlete"), cuche)
    expect_equal(attr(wsc, "url"), get_results_url())

    expect_snapshot(print(wsc, width = Inf, n = Inf))
  }
)


test_that(
  "query_results() works with a row from query_standings",
  # athlete's name in column "athlete" instead of "name"
  {
    local_mocked_bindings(
      get_results_url = function(...) test_path("data", "results_al_all.html.gz")
    )
    cuche_standings <- tibble(athlete = "Cuche Didier",
                              sector = "AL",
                              competitor_id = "11795")
    cuche_athlete <- cuche_standings %>% rename(name = athlete)
    dh <- query_results(cuche_standings)
    expect_equal(dh, query_results(cuche_athlete))
  }
)


test_that(
  "query_results() works for empty result",
  {
    local_mocked_bindings(
      get_results_url = function(...) test_path("data", "results_empty.html.gz")
    )
    empty <- query_results(cuche)

    expect_s3_class(empty, "tbl_df")

    expected_names <- c("athlete", "date", "age", "place", "nation", "sector",
                        "category", "discipline", "rank", "fis_points",
                        "cup_points", "race_id")
    expect_named(empty, expected_names)

    expected_types <- rep("character", 12) %>%
      replace(c(2:3, 9:11), c("Date", "double", "integer", "double", "double"))
    for (i in seq_along(expected_names)) {
      if (expected_types[i] == "Date") {
        expect_s3_class(empty[[!!expected_names[i]]], expected_types[i])
      } else {
        expect_type(empty[[!!expected_names[i]]], expected_types[i])
      }
    }

    expect_equal(attr(empty, "url"), get_results_url())
  }
)


test_that("query_results() warns for large result", {
  local_mocked_bindings(
    get_results_url = function(...) NULL,
    extract_results = function(...) tibble(category = 1:2001)
  )

  expect_warning(
    query_results(cuche, add_age = FALSE),
    "Maximum number of 2'000 results reached"
  )
})

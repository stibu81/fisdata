library(tibble)

test_that("get_athletes_url() works with valid inputs", {
  expect_equal(
    get_athletes_url("Meillard", "Loïc", discipline = "AL", active_only = TRUE),
    paste0("https://www.fis-ski.com/DB/general/biographies.html?",
           "lastname=meillard&firstname=loic&sectorcode=AL&gendercode=&",
           "birthyear=&skiclub=&skis=&nationcode=&fiscode=&status=O&",
           "search=true")
  )
  expect_equal(
    get_athletes_url("Meillard", "Mélanie", nation = "SUI", gender = "F"),
    paste0("https://www.fis-ski.com/DB/general/biographies.html?",
           "lastname=meillard&firstname=melanie&sectorcode=&gendercode=W&",
           "birthyear=&skiclub=&skis=&nationcode=SUI&fiscode=&status=&",
           "search=true")
  )
  expect_equal(
    get_athletes_url("Zenhäusern", "Ramon",
                     gender = "M", birth_year = "1990-1995"),
    paste0("https://www.fis-ski.com/DB/general/biographies.html?",
           "lastname=zenhaeusern&firstname=ramon&sectorcode=&gendercode=M&",
           "birthyear=1990-1995&skiclub=&skis=&nationcode=&fiscode=&status=&",
           "search=true")
  )
  expect_equal(
    get_athletes_url("Odermatt", "Marco",
                     birth_year = "1995,1997", brand = "Stöckli"),
    paste0("https://www.fis-ski.com/DB/general/biographies.html?",
           "lastname=odermatt&firstname=marco&sectorcode=&gendercode=&",
           "birthyear=1995,1997&skiclub=&skis=stoeckli&nationcode=&",
           "fiscode=&status=&search=true")
  )
})


test_that("get_athletes_url() errors work", {
  expect_error(
    get_athletes_url(discipline = "XY"),
    "'XY' is not a valid discipline."
  )
})


test_that("query_athletes() works works", {

  local_mocked_bindings(
    get_athletes_url = function(...) test_path("data", "athletes_cuche.html.gz")
  )
  cuche <- query_athletes()

  expect_s3_class(cuche, "tbl_df")

  expected_names <- c("active", "fis_code", "name", "nation", "age",
                      "birthdate", "gender", "discipline", "club", "brand",
                      "competitor_id")
  expect_named(cuche, expected_names)

  expected_types <- rep("character", 11) %>%
    replace(c(1, 5), c("logical", "integer"))
  for (i in seq_along(expected_types)) {
    expect_type(cuche[[expected_names[i]]], expected_types[i])
  }

  expect_in(cuche$gender, "M")
  expect_match(cuche$name, "cuche", ignore.case = TRUE)
  expect_in(cuche$nation, nations$code)
  expect_match(na.omit(cuche$birthdate), "\\d{4}(-\\d{2}-\\d{2})?")
  expect_in(cuche$discipline, disciplines$code)

  expect_snapshot(print(cuche, width = Inf, n = Inf))
})


test_that("query_athletes() works for empty result", {

  local_mocked_bindings(
    get_athletes_url = function(...) test_path("data", "athletes_empty.html")
  )
  empty <- query_athletes()

  expect_s3_class(empty, "tbl_df")
  expect_equal(nrow(empty), 0)

  expected_names <- c("active", "fis_code", "name", "nation", "age",
                      "birthdate", "gender", "discipline", "club", "brand",
                      "competitor_id")
  expect_named(empty, expected_names)

  expected_types <- rep("character", 11) %>%
    replace(c(1, 5), c("logical", "integer"))
  for (i in seq_along(expected_types)) {
    expect_type(empty[[expected_names[i]]], expected_types[i])
  }
})


test_that("query_athletes() warns for large result", {
  local_mocked_bindings(
    get_athletes_url = function(...) NULL,
    extract_athletes = function(...) tibble(a = 1:1001)
  )
  expect_warning(
    query_athletes(),
    "Maximum number of 1'000 athletes reached"
  )
})

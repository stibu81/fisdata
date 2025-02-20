library(lubridate, warn.conflicts = FALSE)


test_that("show_url() works", {
  local_mocked_bindings(
    get_athletes_url = function(...) test_path("data", "athletes_cuche.html.gz")
  )
  cuche <- query_athletes()

  expect_equal(show_url(cuche), get_athletes_url())

  expect_equal(show_url(mtcars), NULL)
})


test_that("replace_special_chars() works", {
  expect_equal(
    replace_special_chars(
      c("Loïc", "Mélanie", "Žan", "Kostelić", "Štuhec", "Müller")
    ),
    c("loic", "melanie", "zan", "kostelic", "stuhec", "mueller")
  )
  expect_equal(
    replace_special_chars(
      c("à", "á", "å", "ä", "æ", "ç", "ć", "č", "ð", "é", "è", "ê", "ë", "ï",
        "ñ", "ø", "ó", "ő", "ö", "œ", "š", "ß", "ú", "ü", "ž")
    ),
    c("a", "a", "a", "ae", "ae", "c", "c", "c", "d", "e", "e", "e", "e", "i",
      "n", "o", "o", "o", "oe", "oe", "s", "ss", "u", "ue", "z")
  )
  expect_equal(
    replace_special_chars(
      toupper(
        c("à", "á", "å", "ä", "æ", "ç", "ć", "č", "ð", "é", "è", "ê", "ë", "ï",
          "ñ", "ø", "ó", "ő", "ö", "œ", "š", "ß", "ú", "ü", "ž")
      )
    ),
    c("a", "a", "a", "ae", "ae", "c", "c", "c", "d", "e", "e", "e", "e", "i",
      "n", "o", "o", "o", "oe", "oe", "s", "ss", "u", "ue", "z")
  )
})


test_that("format_birthdate() works", {
  expect_equal(
    format_birthdate(c("08-10-1997", "1974", "1987", "12-05-1993", NA)),
    c("1997-10-08", "1974", "1987", "1993-05-12", NA)
  )
})


test_that("parse_race_time() works", {
  expect_equal(
    parse_race_time(
      c("43.5", "1:24.78", "2:32:5.04", "+43.5", "-1:24.78", "+2:32:5.04",
        "-1:.4", "+.32", "-.67", "+0.00", "+.0", NA)
    ),
    as.period(
      c("43.5S", "1M 24.78S", "2H 32M 5.04S", "43.5S", "-1M 24.78S",
        "2H 32M 5.04S", "-1M 0.4S", "0.32S", "-0.67S", "0S", "0S", NA)
    )
  )
})


test_that("parse_number() works", {
  expect_equal(
    parse_number(
      c("5", "34.6", "5432.7", "1'423.5", "9'593", ".2", "0.3", "-.5",
        "-4.8", "-4'568.14", "DNS", NA)
    ),
    c(5, 34.6, 5432.7, 1423.5, 9593, .2, .3, -.5, -4.8, -4568.14, NA, NA)
  )
})


test_that("standardise_colnames() works", {
  expect_equal(
    standardise_colnames(
      c("abc", "ABC", "Run 1", "Diff. Time", " % . Run_ _.2 /__*", "FIS points")
    ),
    c("abc", "abc", "run1", "diff_time", "run2", "fis_points")
  )
})

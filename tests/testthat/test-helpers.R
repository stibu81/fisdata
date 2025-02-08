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

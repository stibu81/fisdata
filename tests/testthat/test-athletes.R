
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

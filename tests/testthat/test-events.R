library(dplyr, warn.conflicts = FALSE)
library(withr)

test_that("get_events_url() works with valid inputs", {
  expect_equal(
    get_events_url(),
    paste0("https://www.fis-ski.com/DB/general/calendar-results.html?",
           "eventselection=&place=&sectorcode=&seasoncode=&categorycode=&",
           "disciplinecode=&gendercode=&racedate=&racecodex=&nationcode=&",
           "seasonmonth=")
  )
  expect_equal(
    get_events_url(sector = "AL", season = 2025, month = 9),
    paste0("https://www.fis-ski.com/DB/general/calendar-results.html?",
           "eventselection=&place=&sectorcode=AL&seasoncode=2025&",
           "categorycode=&disciplinecode=&gendercode=&racedate=&racecodex=&",
           "nationcode=&seasonmonth=09-2024")
  )
  expect_equal(
    get_events_url(selection = "upcoming", category = "WC", gender = "F"),
    paste0("https://www.fis-ski.com/DB/general/calendar-results.html?",
           "eventselection=upcoming&place=&sectorcode=&seasoncode=&",
           "categorycode=WC&disciplinecode=&gendercode=W&racedate=&",
           "racecodex=&nationcode=&seasonmonth=")
  )
  expect_equal(
    get_events_url(date = "2025-02-01", gender = "M"),
    paste0("https://www.fis-ski.com/DB/general/calendar-results.html?",
           "eventselection=&place=&sectorcode=&seasoncode=2025&categorycode=&",
           "disciplinecode=&gendercode=M&racedate=01.02.2025&",
           "racecodex=&nationcode=&seasonmonth=")
  )
  expect_equal(
    get_events_url(place = "Kitzbühel", discipline = "DH",
                   season = 2022, month = 1),
    paste0("https://www.fis-ski.com/DB/general/calendar-results.html?",
           "eventselection=&place=kitzbuehel&sectorcode=&seasoncode=2022&",
           "categorycode=&disciplinecode=DH&gendercode=&racedate=&",
           "racecodex=&nationcode=&seasonmonth=01-2022")
  )
})


test_that("get_events_url() errors work", {
  expect_error(
    get_events_url(sector = "XY"),
    "'XY' is not a valid sector."
  )
})


# best date for testing events: all but three sectors are present
#query_events(date = "01.02.2025")

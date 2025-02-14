library(tibble)

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

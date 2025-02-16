library(dplyr, warn.conflicts = FALSE)

test_that("get_races_url() works with valid inputs", {
  cuche <- tibble(name = "Cuche Didier",
                  discipline = "AL",
                  race_id = "59312")
  expect_equal(
    get_races_url(cuche),
    paste0("https://www.fis-ski.com/DB/general/results.html?sectorcode=AL",
           "&raceid=59312")
  )
})


test_that("ensure_one_result() works", {
  cuche2 <- tibble(name = "Cuche Didier",
                  discipline = "AL",
                  place = "Kitzbuehel",
                  event = c("Downhill", "Super G"),
                  race_id = c("59312", "59311"))
  expect_equal(ensure_one_result(cuche2), cuche2[1, ]) %>%
    expect_warning("Multiple results.*Downhill, Kitzbuehel")
  expect_equal(ensure_one_result(cuche2[1, ]), cuche2[1, ]) %>%
    expect_silent()
  expect_error(ensure_one_result(cuche2[integer(0), ]),
               "No result was passed")
})

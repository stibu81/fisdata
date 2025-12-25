test_that("find_code() works for exact code matches", {
  expect_equal(find_code("AL", type = "sector"), "AL")
  expect_equal(find_code("SWE", type = "nation"), "SWE")
  expect_equal(find_code("30k", type = "discipline"), "30k")
  expect_equal(find_code("WC", type = "category"), "WC")
})


test_that("find_code() works for code matches with deviating capitalisation", {
  expect_equal(find_code("al", type = "sector"), "AL")
  expect_equal(find_code("sWe", type = "nation"), "SWE")
  expect_equal(find_code("30K", type = "discipline"), "30k")
  expect_equal(find_code("wc", type = "category"), "WC")
})


test_that("find_code() works with exact matches in description", {
  expect_equal(find_code("Ski Jumping", type = "sector"), "JP")
  expect_equal(find_code("France", type = "nation"), "FRA")
  expect_equal(find_code("Giant Slalom", type = "discipline"), "GS")
  expect_equal(find_code("Olympic Winter Games", type = "category"), "OWG")
})


test_that("find_code() works with matches at the start of description", {
  expect_equal(find_code("free", type = "sector"), "FR")
  expect_equal(find_code("swi", type = "nation"), "SUI")
  expect_equal(find_code("halfp", type = "discipline"), "HP")
  expect_equal(find_code("cont", type = "category"), "COC")
})


test_that("find_code() works with more complex matches", {
  expect_equal(find_code("nrdco", type = "sector"), "NK")
  expect_equal(find_code("nrw", type = "nation"), "NOR")
  expect_equal(find_code("sup comb", type = "discipline"), "SC")
  expect_equal(find_code("par sl", type = "discipline"), "PSL")
  expect_equal(find_code("nachamp", type = "category"), "NC")
})


test_that("count_leading_matches() works", {
  expect_equal(
    count_leading_matches(
      "abcdef",
      c("abcdez", "abcdzf", "abczef", "abzdef", "azcdef", "zbcdef")
    ),
    5:0
  )
  expect_equal(
    count_leading_matches(
      "ABCDE",
      c("abcdez", "abcdzf", "abczef", "abzdef", "azcdef", "zbcdef")
    ),
    5:0
  )
})

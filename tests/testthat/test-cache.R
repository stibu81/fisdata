library(tibble)
library(glue)
library(cachem)

test_that("url_to_key() works for", {
  expect_equal(url_to_key("abc:123"), "abc_123")
  expect_equal(url_to_key("ABC%123"), "abc_123")
  expect_equal(
    url_to_key(glue("{fis_db_url}/biographies.html")),
    "biographies_html"
  )
  expect_equal(url_to_key("+./&=*?"), "_______")
})


test_that("set_cache() and get_cache() work", {

  on.exit(cache$reset())

  cache$reset()
  expect_equal(cache$keys(), character(0))

  set_cache("a", 1)
  expect_setequal(cache$keys(), "a")
  expect_equal(get_cache("a"), 1)

  set_cache("b", 2)
  expect_setequal(cache$keys(), c("a", "b"))
  expect_equal(get_cache("b"), 2)

  expect_true(is.key_missing(get_cache("c")))
})


# Test for each querying function that caching works:
# * Result is identical when the function is called a second time.
# * The result is taken from cache. This is checked by mocking read_html()
#   such that it throws an error. This would lead to a crash, if caching was
#   not used.

test_that("query_athletes() works with caching", {
  local_mocked_bindings(
    get_athletes_url = function(...) test_path("data", "athletes_cuche.html.gz")
  )
  cuche <- query_athletes()

  local_mocked_bindings(
    read_html = function(...) stop("Cache was not used!"),
    .package = "rvest"
  )
  expect_silent(
    expect_equal(query_athletes(), cuche)
  )
})


test_that("query_results() works with caching", {
  local_mocked_bindings(
    get_results_url = function(...) test_path("data", "results_al_all.html.gz")
  )
  cuche <- tibble(name = "Cuche Didier",
                  sector = "AL",
                  competitor_id = "11795")
  dh <- query_results(cuche)

  local_mocked_bindings(
    read_html = function(...) stop("Cache was not used!"),
    .package = "rvest"
  )
  expect_silent(
    expect_equal(query_results(cuche), dh)
  )
})


test_that("query_race() works with caching", {
  local_mocked_bindings(
    get_races_url = function(...) test_path("data", "race_al_wc_dh.html.gz")
  )
  result <- tibble(athlete = "Odermatt Marco",
                   place = "Wengen",
                   sector = "AL",
                   race_id = "122808")
  wengen_dh <- query_race(result)

  local_mocked_bindings(
    read_html = function(...) stop("Cache was not used!"),
    .package = "rvest"
  )
  expect_silent(
    expect_equal(query_race(result), wengen_dh)
  )
})


test_that("query_standings() works with caching", {
  local_mocked_bindings(
    get_standings_url = function(...) test_path("data", "standings_wc_al_2025.html.gz")
  )
  wc_al_2025 <- query_standings(sector = "AL")

  local_mocked_bindings(
    read_html = function(...) stop("Cache was not used!"),
    .package = "rvest"
  )
  expect_silent(
    expect_equal(query_standings(sector = "AL"), wc_al_2025)
  )
})


test_that("query_standings() for athlete works with caching", {
  local_mocked_bindings(
    get_athlete_standings_url = function(...) test_path("data", "athlete_standings_odermatt.html.gz")
  )
  odermatt <- tibble(
      name = "Odermatt Marco",
      sector = "AL",
      competitor_id = "190231"
    )
  standings_odermatt <- query_standings(athlete = odermatt)

  local_mocked_bindings(
    read_html = function(...) stop("Cache was not used!"),
    .package = "rvest"
  )
  expect_silent(
    expect_equal(query_standings(athlete = odermatt), standings_odermatt)
  )
})


test_that("query_events() works with caching", {
  local_mocked_bindings(
    get_events_url = function(...) test_path("data", "events_20250201.html.gz")
  )
  date <- as.Date("2025-02-01")
  events_20250201 <- query_events(date = date)

  local_mocked_bindings(
    read_html = function(...) stop("Cache was not used!"),
    .package = "rvest"
  )
  expect_silent(
    expect_equal(query_events(date = date), events_20250201)
  )
})


test_that("query_competitions() works with caching", {
  local_mocked_bindings(
    get_competitions_url = function(...) test_path("data", "competitions_wengen_2025.html.gz")
  )
  wengen_2025 <- tibble(sector = "AL", place = "Wengen", event_id = 55595)
  competitions <- query_competitions(wengen_2025)

  local_mocked_bindings(
    read_html = function(...) stop("Cache was not used!"),
    .package = "rvest"
  )
  expect_silent(
    expect_equal(query_competitions(wengen_2025), competitions)
  )
})

# note: some of the test here use files that will be used again in later tests.
# to make sure that those later tests are not influenced by the cache from this
# file, the cache is deleted.
fisdata:::cache$reset()

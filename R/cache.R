# results of querying functions are cached based on the url, since it
# uniquely determines the output of the querying functions.

# the key must only consist of lowercase letters, numbers, -, and _, which means
# that the url must be processed first to ensure this.

get_cache <- function(url) {
  key <- url_to_key(url)
  cache$get(key)
}


set_cache <- function(url, value) {
  key <- url_to_key(url)
  cache$set(key, value)
}


# convert url to a valid key by converting to lower case and replacing all
# invalid characters by "_"
url_to_key <- function(url) {
  url %>%
    stringr::str_remove(glue::glue("{fis_db_url}/")) %>%
    stringr::str_to_lower() %>%
    stringr::str_replace_all("[^a-z0-9]", "_")
}

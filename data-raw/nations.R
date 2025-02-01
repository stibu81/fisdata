# prepare table of olympic country codes from wikipedia

library(rvest)
library(magrittr)
library(purrr)
library(dplyr)
library(stringr)

url <- "https://en.wikipedia.org/wiki/List_of_IOC_country_codes"
html <- read_html(url)
tables <- html_table(html)[c(1, 3)] %>%
  set_names(c("current", "historic")) %>%
  map(\(x) x[1:2] %>% set_names(c("code", "country")))
nations <- tables %>%
  bind_rows(.id = "group") %>%
  mutate(current = group == "current") %>%
  select(-group) %>%
  # the first row is not correct. Fix this by extracting three capital letters
  # as the country code
  mutate(code = str_extract(code, "[A-Z]{3}")) %>%
  arrange(code)

usethis::use_data(nations, overwrite = TRUE)


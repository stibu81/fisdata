# prepare table of olympic country codes from wikipedia

library(rvest)
library(magrittr)
library(purrr)
library(tibble)
library(dplyr)
library(stringr)

url <- "https://en.wikipedia.org/wiki/List_of_IOC_country_codes"
html <- read_html(url)
tables <- html_table(html)[c(1, 3)] %>%
  set_names(c("current", "historic")) %>%
  map(\(x) x[1:2] %>% set_names(c("code", "description")))
nations <- tables %>%
  bind_rows(.id = "group") %>%
  mutate(current = group == "current") %>%
  select(-group) %>%
  # the first row is not correct. Fix this by extracting three capital letters
  # as the country code
  mutate(code = str_extract(code, "[A-Z]{3}")) %>%
  # get rid of footnotes, which are written as numbers inside []
  mutate(description = stringr::str_remove(description, "(\\[\\d+\\])+"))

# manually add some codes that are used on the FIS page but not listed on
# wikipedia (some are contained in the column "Other codes used").
more_nations <- tribble(
    ~code, ~description,
    "BRD", "West Germany",
    "DDR", "East Germany",
    "JUG", "Yugoslavia",
    "SOV", "Soviet Union"
  ) %>%
  mutate(current = FALSE)

nations <- nations %>%
  bind_rows(more_nations) %>%
  arrange(code)

usethis::use_data(nations, overwrite = TRUE)


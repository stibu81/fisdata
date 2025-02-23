# prepare table of categories

library(rvest)
library(dplyr)
library(stringr)
library(waldo)

url <- "https://www.fis-ski.com/DB/general/calendar-results.html"

html <- read_html(url)
options <- html %>%
  html_element("select#categorycode") %>%
  html_elements("option")
categories <- tibble(
    code = html_attr(options, "value"),
    description = html_text(options)
  ) %>%
  filter(code != "") %>%
  mutate(description = str_squish(description))

# CIT has CIT as description, which is not useful. => clarify
categories$description[categories$code == "CIT"] <- "FIS Citizen Race"

# move important events to the top:
# Olympic Games, World Championships, World Cups, other cups, everything else
categories <- categories %>%
  mutate(prio = case_match(code, "OWG" ~ 1, "PWG" ~ 2,
                           "WSC" ~ 3, "SFWC" ~ 4, "ROLWSC" ~ 5,
                           "WC" ~ 6, "COM" ~ 7, "ROLWC" ~ 8,
                           .default = 100)) %>%
  # try to mark allt the other cups, excluding youth events, masters,
  # and qualifications
  mutate(prio = if_else(
    prio == 100 & str_detect(description, "Cup") &
      !str_detect(description, "Junior|Youth|Masters|Qualification"),
      10, prio
  )) %>%
  arrange(prio, code) %>%
  select(-prio)

# compare with the current version of the table in the package
compare(categories, fisdata::categories)

usethis::use_data(categories, overwrite = TRUE)

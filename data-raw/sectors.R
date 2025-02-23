# prepare table of sectors.

library(rvest)
library(dplyr)
library(waldo)

url <- "https://www.fis-ski.com/DB/general/biographies.html"
html <- read_html(url)
options <- html %>%
  html_element("select#sectorcode") %>%
  html_elements("option")
sectors <- tibble(
    code = html_attr(options, "value"),
    description = html_text(options)
  ) %>%
  filter(code != "")

# compare with the current version of the table in the package
compare(sectors, fisdata::sectors)

usethis::use_data(sectors, overwrite = TRUE)

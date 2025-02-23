# prepare table of disciplines

library(rvest)
library(dplyr)
library(stringr)
library(purrr)
library(glue)
library(waldo)

# the disciplines depend on the sector, so they are determined by looping
# through all available sectors.

disciplines <- map(
    sectors$code,
    function(sector) {
      url <- glue("https://www.fis-ski.com/DB/general/calendar-results.html?",
              "sectorcode={sector}")

      html <- read_html(url)
      options <- html %>%
        html_element("select#disciplinecode") %>%
        html_elements("option")
      disciplines <- tibble(
          code = html_attr(options, "value"),
          description = html_text(options)
        ) %>%
        filter(code != "Select an event") %>%
        mutate(description = str_squish(description)) %>%
        mutate(sector = sector, .before = 1)
    }
  ) %>%
  bind_rows() %>%
  left_join(sectors, by = c("sector" = "code"), suffix = c("", "_sector")) %>%
  select(sector, sector_description = description_sector, code, description)

# compare with the current version of the table in the package
compare(disciplines, fisdata::disciplines)

usethis::use_data(disciplines, overwrite = TRUE)

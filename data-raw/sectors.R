# prepare table of sectors. This data has been manually extracted from
# https://www.fis-ski.com/DB/general/biographies.html as follows:
# * enter a nation that likely has athletes in each sector (e.g., SUI)
#   into the field "Nation" to limit the number of search results
# * select a sector from the drop down "Sector"
# * run the search
# * read the code for the sector from the column "Disc."
# * repeat for all sectors from the drop down
# the current version of the data has been extracted on 2025-01-29

sectors <- tibble::tribble(
    ~"code",       ~"description",
    "CC",          "Cross-Country",
    "JP",          "Ski Jumping",
    "NK",          "Nordic Combined",
    "AL",          "Alpine Skiing",
    "FS",          "Freestyle",
    "SB",          "Snowboard",
    "SS",          "Speed Skiing",
    "GS",          "Grass Skiing",
    "TM",          "Telemark",
    "MA",          "Masters",
    "PCC",         "Para Cross-Country",
    "PAL",         "Para Alpine Skiing",
    "PSB",         "Para Snowboard",
    "FR",          "Freeride"
  )

usethis::use_data(sectors, overwrite = TRUE)

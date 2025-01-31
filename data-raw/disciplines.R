# prepare table of discipline. This data has been manually extracted from
# https://www.fis-ski.com/DB/general/biographies.html as follows:
# * enter a nation that likely has athletes in each discipline (e.g., SUI)
#   into the field "Nation" to limit the number of search results
# * select a discipline from the drop down "Discipline"
# * run the search
# * read the code for the discipline from the column "Disc."
# * repeat for all disciplines from the drop down
# the current version of the data has been extracted on 2025-01-29

disciplines <- tibble::tribble(
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

usethis::use_data(disciplines, overwrite = TRUE)

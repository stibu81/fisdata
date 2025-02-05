# prepare table of categories This data has been manually extracted from
# https://www.fis-ski.com/DB/general/biographies.html as follows:
# * list athletes for a discipline
# * click on one of them to see his profile and select the tab results
#   (https://www.fis-ski.com/DB/general/athlete-biography.html).
# * select a category from the dropdown "Category"
# * run the search
# * read the code for the category from the url. It is the parameter to
#   "categorycode", e.g. "&categorycode=EC"
# * repeat for all categories from the drop down
# * try other athletes from the same discipline and check whether there are
#   other categories in the dropdown.
# * repeate with the next disicpline
# Obviously, this procedure does not guarantee that all available categories
# are found.

categories <- tibble::tribble(
    ~"code",       ~"description",
    "WC",          "World Cup",
    "OWG",         "Olympic Winter Games",
    "WSC",         "World Championships",
    "EC",          "European Cup",
    "NAC",         "Nor-Am Cup",
    "ANC",         "Australian New Zealand Cup",
    "SAC",         "South American Cup",
    "FEC",         "Far East Cup",
    "NC",          "National Championships",
    "SFWC",        "Ski-Flying World Championships",
    "COC",         "Continental Cup",
    "WJC",         "Junior World Championships",
    "U23",         "U23 World Championships",
    "TRA",         "Training",
    "SWC",         "Stage World Cup",
    "GP",          "Grand Prix",
    "UVS",         "Universiade",
    "UNI",         "University",
    "ECP",         "European Cup Premium",
    "JUN",         "Junior",
    "JUC",         "Junior Cup",
    "YOG",         "Youth Olympic Winter Games",
    "NJC",         "National Junior Championships",
    "NJR",         "National Junior Race",
    "EYOF",        "European Youth Olympic Festival",
    "CIT",         "FIS Citizen Race",
    "OPN",         "Open",
    "FC",          "FIS Cup",
    "FIS",         "FIS",
    "ENL",         "Entry League FIS",
    "MA",          "Masters",
    "FMC",         "FIS Masters Cup",
    "WCM",         "FIS World Criterium Masters AL",
    "OPA",         "Alpen Cup",
    "WCQ",         "World Cup Qualification",
    "PR",          "Provisional Round",
    "CHI",         "Children"
  )

usethis::use_data(categories, overwrite = TRUE)

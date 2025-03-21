% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/standings.R
\name{query_standings}
\alias{query_standings}
\title{Query Cup Standings}
\usage{
query_standings(
  sector = fd_def("sector"),
  season = fd_def("season"),
  category = fd_def("category"),
  gender = fd_def("gender"),
  type = c("ranking", "start-list", "nations")
)
}
\arguments{
\item{sector}{abbreviation of the sector, e.g., "AL" for
alpine skiing. See the dataset \link{sectors} for possible values.}

\item{season}{year when the season ended, i.e., 2020 stands for the season
2019/2020. It is not possible to filter for multiple seasons at once. If
omitted, results are returned for the current season.}

\item{category}{abbreviation of the category for the cup, e.g., "WC" for
"World Cup". See the dataset \link{categories} for possible values; note that
the standing is only available for some of the categories.
If an unsupported category is used, the FIS page unfortunately returns
the standings for a default category, which is usually the world cup ("WC").}

\item{gender}{abbreviation of the gender: "M" for male/men,
"F" or "W" for female/women. For nations cups (\code{type = "nations"}), use
"A" to get the overall nations cup.}

\item{type}{type of standings to return. Not all types may be supported for
all categories. Possible values are:
\itemize{
\item \code{"ranking"}, the default, returns the usual ranking of individual athletes
which determines the discipline and overall winner of the cup.
\item \code{"start-list"} returns the ranking for the start lists.
\item \code{"nations"} returns the ranking of the nations cup.
}}
}
\value{
A tibble with at least the following columns: \code{sector}, \code{athlete},
and \code{nation}. Except for nations cups, there are also the columns \code{brand}
and \code{competitor_id}. Depending on the sector, there are multiple
columns giving the rank and the points for the various disciplines. For
example, in alpine skiing ("AL"), the columns \code{all_rank} and \code{all_points}
give the rank and points for the overall world cup, while \code{dh_rank} and
\code{dh_points} give the rank and points for the downhill world cup.
}
\description{
Query cup standings by sector, season, category
(i.e., the cup in this context), and gender.
}
\details{
All filter arguments are set to \code{""} by default. Setting an argument to
\code{""} means that no filtering takes place for this parameter. For those
arguments that have a call to \code{\link[=fd_def]{fd_def()}} as their default value, the default
value can be globally set using \code{\link[=set_fisdata_defaults]{set_fisdata_defaults()}}.

The results are cached such that the same data are only downloaded once
per sessions.
}
\examples{
\dontrun{
# get the standings for the women's alpine skiing world cup 2023/24.
query_standings(sector = "AL", season = 2024,
                category = "WC", gender = "W")

# get the overall nations ranking for the alpine skiing world cup 2024/25.
query_standings(sector = "AL", season = 2025,
                category = "WC", gender = "A",
                type = "nations")

# get the women's start list for the snowboard world cup 2021/22
query_standings(sector = "SB", season = 2022,
                category = "WC", gender = "W",
                type = "start-list")
}

}

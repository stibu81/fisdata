% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/races.R
\name{query_race}
\alias{query_race}
\title{Query Race}
\usage{
query_race(result)
}
\arguments{
\item{result}{a list or data frame with fields/columns \code{race_id} and
\code{sector} that describe a \emph{single} race. The easiest way to create
such a data frame is through the function \code{\link[=query_results]{query_results()}}. This function
can return multiple results, but \code{query_race()} only returns the
results for one race. If multiple results are passed, only the first
one will be used.}
}
\value{
A tibble with the following columns: \code{rank}, \code{bib}, \code{fis_code}, \code{name},
\code{brand}, \code{birth_year}, \code{nation}, \code{time}, \code{diff_time}, \code{fis_points},
and \code{cup_points}.
}
\description{
Query full results for a race.
}
\details{
This function does not yet work for all sectors. It has been successfully
tested for Cross-Country ("CC"), Alpine Skiing ("AL"),
Nordic Combined ("NK"), and for some disciplines in Snowboard ("SB").
It may fail or give incorrect results for any other sector.
In particular, the function is expected to fail for races where the ranking
is not done through a time measurement as, e.g., in Ski Jumping ("JP").
}
\examples{
\dontrun{
# the results for a race can be queried by using a specific race of an
# athlete as input. So we get all results for Marco Odermatt.
odermatt <- query_athletes("odermatt", "marco")
odermatt_res <- query_results(odermatt)

# show the first of the results
odermatt_res[1, ]

# get the full results for this race
query_race(odermatt_res[1, ])
}


}

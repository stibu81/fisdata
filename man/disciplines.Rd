% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{disciplines}
\alias{disciplines}
\title{Table of Codes for Disciplines}
\format{
A data frame with 152 rows and
4 variables:
\describe{
\item{sector}{the code of the sector, to which the discipline belongs}
\item{sector_description}{the clear-text description of the sector}
\item{code}{code of the category. They are alphanumeric, starting with a
capital letter or a  digit. Most are 2 or 3 characters long, but up to
six characters are possible.}
\item{description}{clear text description of the category}
}
}
\usage{
disciplines
}
\description{
This dataset contains the codes for the disciplines for which
data can be obtained from the FIS webpage.
These codes can be used to filter for a specific discipline
in \code{\link[=query_results]{query_results()}}. Note that the available disciplines depend on
the sector.
}
\keyword{datasets}

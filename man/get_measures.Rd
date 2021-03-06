% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_measures.R
\name{get_measures}
\alias{get_measures}
\title{Get details of measures available from the EA API}
\usage{
get_measures(
  parameter_name = NULL,
  parameter = NULL,
  qualifier = NULL,
  station_reference = NULL,
  station = NULL
)
}
\arguments{
\item{parameter_name}{Return only measures for parameters with the given
name, for example 'Water Level' or 'Flow'.}

\item{parameter}{Return only measures for parameters with the given short
form name, for example 'level' or 'flow'.}

\item{qualifier}{Return only those measures with the given qualifier. Useful
qualifiers are 'Stage' and 'Downstream Stage' (for stations such as weirs
which measure levels at two locations), 'Groundwater' for groundwater levels
as opposed to river levels and 'Tidal Level' for tidal levels.}

\item{station_reference}{Return only those measures which are available from
the station with the given reference identifier.}

\item{station}{Return only those measures which are available from the
station with the given URI.}
}
\value{
A dataframe of the Environment Agency flood monitoring measures for
the given criteria.
}
\description{
In additional to listing stations, which includes the information on the
measures available from each station, you can list the available measures
directly.
}

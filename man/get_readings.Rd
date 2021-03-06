% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_readings.R
\name{get_readings}
\alias{get_readings}
\title{Get readings from measurement stations via the EA API}
\usage{
get_readings(
  measure = NULL,
  station = NULL,
  latest = FALSE,
  today = FALSE,
  start_date = NULL,
  end_date = NULL,
  since = NULL,
  limit = NULL,
  sorted = TRUE
)
}
\arguments{
\item{measure}{Return readings only for the given measure URI.}

\item{station}{Return only readings of measures which are available from the
station with the given URI.}

\item{latest}{Return only the most recently available reading for each
included measure.}

\item{today}{Return all the readings taken today for each included measure.}

\item{start_date, end_date}{Return the readings taken on the specified range
of days for each included measure, up to the specified limit.}

\item{since}{Return the readings taken since the given date time
(not inclusive), up to the specified limit. Will accept a simple date value
such as 2016-09-07 which will be interpreted as 2016-09-07T:00:00:00Z.}

\item{limit}{Return a maximum of these items from the list. By default the
readings API endpoints have a limit of 500 items, this can be modified by
providing an explicit limit value up to a hard limit of 10000 items.}

\item{sorted}{Order the array of returned readings into descending order by
date, this done before the limits is applied thus enabling you to fetch the
most recent n readings.}
}
\value{
A data frame of the readings.
}
\description{
Get readings from measurement stations via the EA API
}

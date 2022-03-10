#' Get readings from measurement stations via the EA API
#'
#'
#' @param measure Return readings only for the given measure URI.
#' @param latest Return only the most recently available reading for each
#' included measure.
#' @param today Return all the readings taken today for each included measure.
#' @param start_date,end_date Return the readings taken on the specified range
#' of days for each included measure, up to the specified limit.
#' @param station Return only readings of measures which are available from the
#' station with the given URI.
#' @param since Return the readings taken since the given date time
#' (not inclusive), up to the specified limit. Will accept a simple date value
#' such as 2016-09-07 which will be interpreted as 2016-09-07T:00:00:00Z.
#' @param limit Return a maximum of these items from the list. By default the
#' readings API endpoints have a limit of 500 items, this can be modified by
#' providing an explicit limit value up to a hard limit of 10000 items.
#'
#' @return A data frame of the readings.
#' @export
#'
#' @examples
get_readings <- function(measure = NULL,
                         station = NULL,
                         latest = FALSE,
                         today = FALSE,
                         start_date = NULL,
                         end_date = NULL,
                         since = NULL,
                         limit = NULL,
                         sorted = FALSE){

  # Boolean arguments must be represented as null or "" to be properly
  # represented in built URL
  if(latest){
    latest = ""
  } else {
    latest = NULL
  }

  if(today){
    today = ""
  } else {
    today = NULL
  }

  if(sorted){
    sorted = ""
  } else {
    sorted = NULL
  }

  # If no measure or station arguments are passed into function
  if(is.null(measure) & is.null(station)){
  url <- httr::parse_url("http://environment.data.gov.uk/flood-monitoring/data/readings")
  url$query <- list(latest = latest,
                    today = today, # Check how this behaves,
                    startdate = start_date,
                    enddate = end_date,
                    '_sorted' = sorted,
                    '_limit' = limit)
  } else if (!is.null(measure)){
    # If a measure is specified
    url <- httr::parse_url(paste0("http://environment.data.gov.uk/flood-monitoring/id/measures/",
                                  measure,
                                  "/readings"))
    url$query <- list(latest = latest,
                      today = today, # Check how this behaves,
                      startdate = start_date,
                      enddate = end_date,
                      since = since,
                      '_sorted' = sorted,
                      '_limit' = limit)
  } else {
    url <- httr::parse_url(paste0("http://environment.data.gov.uk/flood-monitoring/id/stations/",
                                  station,
                                  "/readings"))
    url$query <- list(latest = latest,
                      today = today, # Check how this behaves,
                      startdate = start_date,
                      enddate = end_date,
                      since = since,
                      '_sorted' = sorted,
                      '_limit' = limit)
  }

  url <- httr::build_url(url)

  response <- jsonlite::fromJSON(url)

  out <- response$items
  out$dateTime <-lubridate::ymd_hms(out$dateTime)
  out

}

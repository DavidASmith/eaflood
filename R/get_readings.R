#' Get readings from measurement stations via the EA API
#'
#'
#' @param measure
#' @param latest
#' @param today
#' @param start_date
#' @param end_date
#' @param station
#' @param since
#' @param limit
#'
#' @return
#' @export
#'
#' @examples
get_readings <- function(measure = NULL,
                         station = NULL,
                         latest = NULL,
                         today = NULL,
                         start_date = NULL,
                         end_date = NULL,
                         since = NULL,
                         limit = NULL,
                         sorted = TRUE){

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

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
                         limit = NULL){

  # If no measure or station arguments are passed into function
  if(is.null(measure) & is.null(station)){
  url <- httr::parse_url("http://environment.data.gov.uk/flood-monitoring/data/readings")
  url$query <- list(latest = latest,
                    today = today, # Check how this behaves,
                    startdate = start_date,
                    enddate = end_date,
                    '_limit' = limit)
  url <- httr::build_url(url)
  } else if (!is.null(measure)){
    # If a measure is specified
    url <- httr::parse_url(paste0("http://environment.data.gov.uk/flood-monitoring/id/measures/",
                                  measure,
                                  "/readings"))
    url$query <- list(latest = latest,
                      today = today, # Check how this behaves,
                      startdate = start_date,
                      enddate = end_date,
                      since = since)
  } else {
    url <- httr::parse_url(paste0("http://environment.data.gov.uk/flood-monitoring/id/stations/",
                                  measure,
                                  "/readings"))
    url$query <- list(latest = latest,
                      today = today, # Check how this behaves,
                      startdate = start_date,
                      enddate = end_date,
                      since = since)
  }

  response <- jsonlite::fromJSON(url)

  response$items

}

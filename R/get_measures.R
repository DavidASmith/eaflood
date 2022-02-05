#' Get details of measures available from the EA API
#'
#'
#' @param parameter_name
#' @param parameter
#' @param qualifier
#' @param station
#' @param station_reference
#'
#' @return
#' @export
#'
#' @examples
get_measures <- function(parameter_name = NULL,
                         parameter = NULL,
                         qualifier = NULL,
                         station_reference = NULL,
                         station = NULL){
  url <- httr::parse_url("http://environment.data.gov.uk/flood-monitoring/id/measures")
  url$query <- list(parameterName = parameter_name,
                    parameter = parameter,
                    qualifer = qualifier,
                    stationReference = station_reference,
                    station = station)
  url <- httr::build_url(url)

  response <- jsonlite::fromJSON(url)

  response$items

}

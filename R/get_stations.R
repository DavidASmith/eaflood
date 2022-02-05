#' Get details of measurement stations from the EA
#'
#'
#' @param lat
#' @param long
#' @param dist
#' @param parameter_name
#' @param parameter
#' @param qualifier
#' @param label
#' @param town
#' @param catchment_name
#' @param river_name
#' @param station_reference
#' @param rloi_id
#' @param search
#' @param type
#' @param status
#'
#' @return
#' @export
#'
#' @examples
get_stations <- function(parameter_name = NULL,
                         parameter = NULL,
                         qualifier = NULL,
                         label = NULL,
                         town = NULL,
                         catchment_name = NULL,
                         river_name = NULL,
                         station_reference = NULL,
                         rloi_id = NULL,
                         search = NULL,
                         lat = NULL,
                         long = NULL,
                         dist = NULL,
                         type = NULL,
                         status = NULL){
  url <- httr::parse_url("http://environment.data.gov.uk/flood-monitoring/id/stations")
  url$query <- list(parameterName = parameter_name,
                    parameter = parameter,
                    qualifer = qualifier,
                    label = label,
                    town = town,
                    catchmentName = catchment_name,
                    riverName = river_name,
                    stationReference = station_reference,
                    RLOIid = rloi_id,
                    search = search,
                    lat = lat,
                    long = long,
                    dist = dist,
                    type = type,
                    status = status)
  url <- httr::build_url(url)

  response <- jsonlite::fromJSON(url)

  response$items

}

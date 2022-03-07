#' Get details of measures available from the EA API
#'
#' In additional to listing stations, which includes the information on the
#' measures available from each station, you can list the available measures
#' directly.
#'
#' @param parameter_name Return only measures for parameters with the given
#' name, for example 'Water Level' or 'Flow'.
#' @param parameter Return only measures for parameters with the given short
#' form name, for example 'level' or 'flow'.
#' @param qualifier Return only those measures with the given qualifier. Useful
#' qualifiers are 'Stage' and 'Downstream Stage' (for stations such as weirs
#' which measure levels at two locations), 'Groundwater' for groundwater levels
#' as opposed to river levels and 'Tidal Level' for tidal levels.
#' @param station Return only those measures which are available from the
#' station with the given URI.
#' @param station_reference Return only those measures which are available from
#' the station with the given reference identifier.
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

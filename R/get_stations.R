#' Get details of measurement stations from the EA
#'
#' The real-time data API provides information on readings of water levels and
#' flows taken at a variety of measurement stations. A given station may
#' provide more than one set of measurements, for example, both water level and
#' flow rate or water level at two different spots (e.g. up-stream and
#' down-stream of a sluice or weir). The API provides metadata on these
#' stations and on the different measures available from each one.
#'
#' @param lat,long,dist Return only stations which are
#' within \code{dist} km of the given latitude/longitude (in WGS84
#' coordinates), this may be approximated by a bounding box.
#' @param parameter_name Return only those stations which measure parameters
#' with the given name, for example 'Water Level' or 'Flow'.
#' @param parameter Return only those stations which measure parameters with
#' the given short form name, for example 'level' or 'flow'.
#' @param qualifier Return only those stations which measure parameters with
#' the given qualifier. Useful qualifiers are 'Stage' and 'Downstream Stage'
#' (for stations such as weirs which measure levels at two locations),
#' 'Groundwater' for groundwater levels as opposed to river levels and
#' 'Tidal Level' for tidal levels.
#' @param label Return only those stations whose label exactly matches this.
#' @param town Return only those stations relating to the given town. Not all
#' stations have an associated town.
#' @param catchment_name Return only those stations whose catchment name is
#' exactly this. Not all stations have an associated catchment area.
#' @param river_name Return only those stations whose river name is exactly
#' this. Not all stations have an associated river name.
#' @param station_reference Return only those stations whose reference
#' identifier is this. The station reference is an internal identifier used by
#' the Environment Agency.
#' @param rloi_id Return only the station (if there is one) whose RLOIid
#' (River Levels on the Internet identifier) matches this.
#' @param search Return only those stations whose label contains this.
#' @param type Return only those stations of the given type, where this can be
#' one of 'SingleLevel', 'MultiTraceLevel', 'Coastal', 'Groundwater' or
#' 'Meteorological'.
#' @param status Return only those stations with the given status, where this
#' can be one of 'Active', 'Closed' or 'Suspended'.
#'
#' @return Data frame of Environment Agency measurement stations.
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

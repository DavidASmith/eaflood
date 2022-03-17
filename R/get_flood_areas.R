#' Get the flood areas from EA
#'
#'The flood areas API provide information on the geographic regions to which a
#'given flood alert or warning may apply. These comprise Flood Alert Areas and
#'Flood Warning Areas. A Flood Alert Area is a geographical area where it is
#'possible for flooding to occur from rivers, sea and in some locations,
#'groundwater. A single Flood Alert Area may cover a large portion of the
#'floodplain, may contain multiple river catchments of similar characteristics
#'and may contain a number of Flood Warning Areas. A Flood Warning Area is a
#'geographical area where Environment Agency expect flooding to occur and which
#'they provide a Flood Warning Service.
#'
#'Full information on the areas is available from the Environment Agency
#'Spatial Data Catalogue as a downloadable file and via a Web Feature Service
#'or Web Mapping Service. For convenience we here provide the feature
#'information for each area as a simple JSON format, including a specification
#'of the polygon for each area (as a geoJSON feature in WGS84 coordinates). A
#'typical application should maintain a local copy of the geographic
#'information rather that reply on on-demand downloads of the rather large
#'polygon files.
#'
#'Each flood warning provides a link (floodArea) to the URI of the flood area
#'to which it applies.
#'
#' @param lat,long,dist Return only warnings applying to flood areas which are
#' within \code{dist} km of the given latitude/longitude (in WGS84
#' coordinates), this may be approximated by a bounding box.
#' @param limit The default limit on number of returned items is 500, this can
#' be adjusted by giving an explicit value, there is no hard upper limit.
#'
#' @return A dataframe of Environment Agency flood areas for the given criteria
#' @export
#'
#' @examples get_flood_areas()
get_flood_areas <- function(lat = NULL,
                            long = NULL,
                            dist = NULL,
                            limit = NULL){
  url <- httr::parse_url("http://environment.data.gov.uk/flood-monitoring/id/floodAreas")
  url$query <- list(lat = lat,
                    long = long,
                    dist = dist,
                    '_limit' = limit)
  url <- httr::build_url(url)

  response <- jsonlite::fromJSON(url)

  response$items
}

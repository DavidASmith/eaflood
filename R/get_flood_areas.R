#' Get the flood areas from EA
#'
#'#' @param lat,long,dist Return only warnings applying to flood areas which are
#' within \code{dist} km of the given latitude/longitude (in WGS84
#' coordinates), this may be approximated by a bounding box.
#' @param limit The default limit on number of returned items is 500, this can
#' be adjusted by giving an explicit value, there is no hard upper limit.
#'
#' @return
#' @export
#'
#' @examples
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

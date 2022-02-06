#' Get the flood areas from EA
#'
#'
#' @param lat
#' @param long
#' @param dist
#' @param limit
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

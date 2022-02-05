#' Get the flood areas from EA
#'
#'
#' @param lat
#' @param long
#' @param dist
#'
#' @return
#' @export
#'
#' @examples
get_flood_areas <- function(lat = NULL,
                               long = NULL,
                               dist = NULL){
  url <- httr::parse_url("http://environment.data.gov.uk/flood-monitoring/id/floodAreas")
  url$query <- list(lat = lat,
                    long = long,
                    dist = dist)
  url <- httr::build_url(url)

  response <- jsonlite::fromJSON(url)

  flood_areas <- response$items
  flood_areas
}

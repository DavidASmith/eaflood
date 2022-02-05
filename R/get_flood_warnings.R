#' Get the current flood warnings from EA
#'
#' @param min_severity
#'
#' @return
#' @export
#'
#' @examples
get_flood_warnings <- function(min_severity = NULL,
                               county = NULL,
                               lat = NULL,
                               long = NULL,
                               dist = NULL){
  url <- httr::parse_url("http://environment.data.gov.uk/flood-monitoring/id/floods")
  url$query <- list('min-severity' = min_severity,
                    county = county,
                    lat = lat,
                    long = long,
                    dist = dist)
  url <- httr::build_url(url)

  response <- jsonlite::fromJSON(url)

  flood_alerts <- response$items
  flood_alerts
}

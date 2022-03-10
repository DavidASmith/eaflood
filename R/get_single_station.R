#' Get details of single measurement station from the EA
#'
#'
#' @param x Environment Agency API Station identifier
#'
#' @return A list of station information
#' @export
#'
#' @examples get_single_station("1491TH")
get_single_station <- function(x){
  url <- httr::parse_url("http://environment.data.gov.uk/flood-monitoring/id/stations")
  url$path <- c(url$path, "/", x)
  url <- httr::build_url(url)

  response <- jsonlite::fromJSON(url)

  response$items

}

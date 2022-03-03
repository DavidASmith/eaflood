#' Get details of single measurement station from the EA
#'
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
get_single_station <- function(x){
  url <- httr::parse_url("http://environment.data.gov.uk/flood-monitoring/id/stations")
  url$path <- c(url$path, "/", x)
  url <- httr::build_url(url)

  response <- jsonlite::fromJSON(url)

  response$items

}

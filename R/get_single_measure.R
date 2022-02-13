#' Get details of single measure from the EA API
#'
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
get_single_measure <- function(x){
  url <- httr::parse_url("https://environment.data.gov.uk/flood-monitoring/id/measures")
  url$path <- c(url$path, "/", x)
  url <- httr::build_url(url)

  response <- jsonlite::fromJSON(url)

  response$items

}

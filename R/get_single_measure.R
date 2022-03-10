#' Get details of single measure from the EA API
#'
#'
#' @param x Environment Agency API measure identifier
#'
#' @return A list of measure information.
#' @export
#'
#' @examples get_single_measure("1491TH-level-stage-i-15_min-mASD")
get_single_measure <- function(x){
  url <-
    httr::parse_url("https://environment.data.gov.uk/flood-monitoring/id/measures")
  url$path <- c(url$path, "/", x)
  url <- httr::build_url(url)

  response <- jsonlite::fromJSON(url)

  response$items
}

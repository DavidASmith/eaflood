#' Download Geo JSON polygons and return as single simple features (sf)
#' dataframe
#'
#' @param x Character vector of URLs to GeoJSON polygons.
#'
#' @return sf (simple features) geographically aware dataframe.
#' @export
#'
#' @examples
polygons_as_sf <- function(x){
  x <- lapply(x, sf::st_read, quiet = TRUE)
  dplyr::bind_rows(x)
}

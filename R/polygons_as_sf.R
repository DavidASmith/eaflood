#' Download Geo JSON polygons and return as single simple features (sf)
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
polygons_as_sf <- function(x){
  x <- lapply(x, sf::st_read, quiet = TRUE)
  dplyr::bind_rows(x)
}

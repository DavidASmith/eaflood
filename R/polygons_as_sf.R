#' Download Geo JSON polygons and return as single simple features (sf)
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
polygons_as_sf <- function(x){
  x <- lapply(polygon_url, st_read)
  bind_rows(x)
}

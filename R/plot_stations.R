#' Plot flood monitoring stations on a map
#'
#' @param ... Other arguments passed to get_stations()
#' @param interactive If TRUE return an interactive map, otherwise a static
#' image.
#'
#' @return Leaflet map if interactive = TRUE, otherwise an image.
#' @export
#'
#' @examples
plot_stations <- function(..., interactive = TRUE){

  x <- get_stations(...)

  x <- sf::st_as_sf(x, coords = c("long", "lat"))

  if(interactive){

    tmap::tmap_mode("view")

    tmap::tm_basemap("CartoDB.Positron") +
      tmap::tm_shape(x) +
      tmap::tm_dots(col = "riverName", size = 0.1)
  } else {

    tmap::tmap_mode("plot")

    bg <- rosm::osm.raster(sf::st_bbox(x), type = "cartolight")

    tmap::tm_shape(bg) +
      tmap::tm_rgb() +
      tmap::tm_shape(x) +
      tmap::tm_dots(col = "riverName", size = 0.2)
  }
}

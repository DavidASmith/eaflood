#' Plot flood areas on interactive map
#'
#' @param lat,long,dist Return only warnings applying to flood areas which are
#' within \code{dist} km of the given latitude/longitude (in WGS84
#' coordinates), this may be approximated by a bounding box.
#' @param limit Return a maximum of these items from the list.
#' @param interactive If TRUE return an interactive map, otherwise a static
#' image.
#'
#' @return A tmap object. Interactive exploration of flood warnings.
#' @export
#'
#' @examples
plot_flood_areas <- function(lat = NULL,
                             long = NULL,
                             dist = NULL,
                             limit = NULL,
                             interactive = TRUE) {

  x <- get_flood_areas(lat = lat,
                       long = long,
                       dist = dist)

  polygon_url <- x$polygon
  polygon <- polygons_as_sf(polygon_url)

  polygon <- cbind(polygon, x)

  polygon <- sf::st_make_valid(polygon)

  polygon_is_valid <- sf::st_is_valid(polygon)

  invalid_polygon <- polygon$TA_NAME[!polygon_is_valid]

  if(any(!polygon_is_valid)) {
    warning(length(invalid_polygon),
            " invalid geometries not plotted: \n",
            paste(invalid_polygon, collapse = "\n"))
  }

  valid_polygon <- polygon[polygon_is_valid, ]

  if(interactive){
    tmap::tmap_mode("view")

    tmap::tm_basemap("CartoDB.Positron") +
      tmap::tm_shape(valid_polygon) +
      tmap::tm_polygons(alpha = 0.5)
  } else {
    tmap::tmap_mode("plot")

    bg <- rosm::osm.raster(sf::st_bbox(valid_polygon), type = "cartolight")

    tmap::tm_shape(bg) +
      tmap::tm_rgb() +
      tmap::tm_shape(valid_polygon) +
      tmap::tm_polygons()
  }
}

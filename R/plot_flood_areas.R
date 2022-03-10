#' Plot flood areas on interactive map
#'
#' @param lat,long,dist Return only warnings applying to flood areas which are
#' within \code{dist} km of the given latitude/longitude (in WGS84
#' coordinates), this may be approximated by a bounding box.
#' @param limit Return a maximum of these items from the list.
#'
#' @return A tmap object. Interactive exploration of flood warnings.
#' @export
#'
#' @examples
plot_flood_areas <- function(lat = NULL,
                                long = NULL,
                                dist = NULL,
                                limit = NULL) {

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
            " invalid geometries not plotted: ",
            paste(invalid_polygon, collapse = ", "), ".")
  }

  valid_polygon <- polygon[polygon_is_valid, ]

  tmap::tmap_mode("view")

  tmap::tm_basemap() +
    tmap::tm_shape(valid_polygon) +
    tmap::tm_polygons(alpha = 0.5)

}

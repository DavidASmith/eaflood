#' Plot flood areas on interactive map
#'
#' @param lat
#' @param long
#' @param dist
#' @param limit
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

  polygon <- st_make_valid(polygon)

  polygon_is_valid <- st_is_valid(polygon)

  invalid_polygon <- polygon$TA_NAME[!polygon_is_valid]

  if(any(!polygon_is_valid)) {
    warning(length(invalid_polygon),
            " invalid geometries not plotted: ",
            paste(invalid_polygon, collapse = ", "), ".")
  }

  valid_polygon <- polygon[polygon_is_valid, ]

  tmap_mode("view")

  tm_basemap() +
    tm_shape(valid_polygon) +
    tm_polygons(alpha = 0.5)

}

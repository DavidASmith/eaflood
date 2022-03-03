#' Plot flood warnings on interactive map
#'
#' @param min_severity
#' @param county
#' @param lat
#' @param long
#' @param dist
#'
#' @return
#' @export
#'
#' @examples
plot_flood_warnings <- function(min_severity = 3,
                                county = NULL,
                                lat = NULL,
                                long = NULL,
                                dist = NULL) {

  x <- get_flood_warnings(min_severity = min_severity,
                          county = county,
                          lat = lat,
                          long = long,
                          dist = dist)

  polygon_url <- x$floodArea$polygon
  polygon <- polygons_as_sf(polygon_url)

  polygon <- cbind(polygon, x)

  polygon <- st_make_valid(polygon)

  polygon_is_valid <- st_is_valid(polygon)

  invalid_polygon <- polygon$TA_NAME[!polygon_is_valid]

  if(!is.null(invalid_polygon)) {
    warning(length(invalid_polygon),
            " invalid geometries not plotted: ",
            paste(invalid_polygon, collapse = ", "), ".")
  }

  valid_polygon <- polygon[polygon_is_valid, ]

  tmap_mode("view")

  tm_basemap() +
    tm_shape(valid_polygon) +
    tm_polygons(col = "severity", alpha = 0.5)

}

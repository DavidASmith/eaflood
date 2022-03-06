#' Plot flood warnings on interactive map
#'
#' @param min_severity Return only warnings which at least as severe as this
#' level.
#' @param county Return only warnings applying to flood areas whose county name
#' contains the submitted string. Can be a list of county names separated by
#' "," in which case alerts which mention any of the named counties will be
#' returned.
#' @param lat,long,dist Return only warnings applying to flood areas which are
#' within \code{dist} km of the given latitude/longitude (in WGS84
#' coordinates), this may be approximated by a bounding box.
#'
#' @return A tmap object. Interactive exploration of flood warnings.
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

  if(any(!polygon_is_valid)) {
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

#' Plot flood warnings on a map
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
#' @param interactive If TRUE return an interactive map, otherwise a static
#' image.
#'
#' @return A tmap object. Interactive exploration of flood warnings.
#' @export
#'
#' @examples
plot_flood_warnings <- function(min_severity = 3,
                                county = NULL,
                                lat = NULL,
                                long = NULL,
                                dist = NULL,
                                interactive = TRUE) {

  x <- get_flood_warnings(min_severity = min_severity,
                          county = county,
                          lat = lat,
                          long = long,
                          dist = dist)

  if(is.null(x)){
    message("No flood warnings returned from API.")
    return(NULL)
  }

  polygon_url <- x$floodArea$polygon
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

  if(nrow(valid_polygon) == 0) {
    message("No valid geometry to plot.")
    return(NULL)
  }

  if(interactive){

    tmap::tmap_mode("view")

    tmap::tm_basemap("CartoDB.Positron") +
      tmap::tm_shape(valid_polygon) +
      tmap::tm_polygons(col = "severity", alpha = 0.5)
  } else {
    tmap::tmap_mode("plot")

    bg <- rosm::osm.raster(sf::st_bbox(valid_polygon), type = "cartolight")

    tmap::tm_shape(bg) +
      tmap::tm_rgb() +
      tmap::tm_shape(valid_polygon) +
      tmap::tm_polygons(col = "severity")
  }
}

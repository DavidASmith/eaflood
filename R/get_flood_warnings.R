#' Get the current flood warnings from Environment Agency API.
#'
#' The Environment Agency issue warnings of floods that cover specific warning
#' or alert areas. The floods API provides a listing of all current such
#' warnings and is updated every 15 minutes.
#'
#'
#'A warning may be at one of four possible severity levels:
#'
#' \describe{
#'   \item{1}{Severe Flood Warning - Severe Flooding, Danger to Life.}
#'   \item{2}{Flood Warning	- Flooding is Expected, Immediate Action Required.}
#'   \item{3}{Flood Alert	- Flooding is Possible, Be Prepared.}
#'   \item{4}{Warning no Longer in Force - The warning is no longer in force.}
#' }
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
#' @return A data frame of flood warnings from the Environment Agency API.
#'
#' Each individual warning with have a URI given by the @id field in the data:
#'
#' http://environment.data.gov.uk/flood-monitoring/id/floods/{id}
#'
#' The {id} section of this URI is taken from the value of the floodAreaID.
#' Therefore the current warning for a flood area (if any warning exists) will
#' always have the same URI.
#' The severity level and the message field may change through the lifetime of
#' the warning. The data for a warning will include the time at which the
#' severity last changed. At some point after a warning is no longer in force
#' it will disappear from the data feed and the URI for that warning will cease
#' to resolve. If no warning is currently in place for that flood area, then
#' attempting to resolve the URI will return a 404 status code. For
#' approximately 24 hours after a warning has been in place for a flood area,
#' the severity level will be set to 4, "Warning no Longer in Force", before
#' the warning response is removed altogether.
#'
#' For more information about the returned data, see
#' \url{https://environment.data.gov.uk/flood-monitoring/doc/reference#flood-warnings}.
#'
#' @export
#'
#' @examples
get_flood_warnings <- function(min_severity = 3,
                               county = NULL,
                               lat = NULL,
                               long = NULL,
                               dist = NULL){
  url <- httr::parse_url("http://environment.data.gov.uk/flood-monitoring/id/floods")
  url$query <- list('min-severity' = min_severity,
                    county = county,
                    lat = lat,
                    long = long,
                    dist = dist)
  url <- httr::build_url(url)

  response <- jsonlite::fromJSON(url)

  flood_alerts <- response$items

  if(class(flood_alerts) == "list" & length(flood_alerts) == 0){
    message("No flood warnings for given criteria.")
    NULL
  } else {
    flood_alerts
  }
}

#' Plot readings for a given measure
#'
#' Readings for each of the published measures are available for the recent
#' period (up to the last four weeks). Longer historic data records may be
#' available separately. Each reading comprises a reference to the measure
#' being read (identified by its URI), a date time stamp for when the reading
#' applies and a numeric value. The set of readings is updated every 15
#' minutes, but the individual measures may be updated less frequently than
#' this.
#'
#' @param x Measure URI.
#' @param today Return all the readings taken today for each included measure.
#' @param start_date,end_date Return the readings taken on the specified range
#' of days for each included measure, up to the specified limit.
#' @param since Return the readings taken since the given date time
#' (not inclusive), up to the specified limit. Will accept a simple date value
#' such as 2016-09-07 which will be interpreted as 2016-09-07T:00:00:00Z.
#' @param limit Return a maximum of these items from the list. By default the
#' readings API endpoints have a limit of 500 items, this can be modified by
#' providing an explicit limit value up to a hard limit of 10000 items.
#' @param show_max Where available, show max on record as reference line on
#' chart.
#' @param show_high Where available, show typical high as reference line on
#' chart.
#' @param show_low Where available, show typical low as reference line on
#' chart.
#'
#' @return ggplot2 plot object.
#' @export
#' @importFrom rlang .data
#'
#' @examples
plot_measure_readings <- function(x,
                                  today = FALSE,
                                  start_date = NULL,
                                  end_date = NULL,
                                  since = NULL,
                                  limit = NULL,
                                  show_max = TRUE,
                                  show_high = TRUE,
                                  show_low = TRUE) {

  readings <- get_readings(measure = x,
                           today = today,
                           start_date = start_date,
                           end_date = end_date,
                           since = since,
                           limit = limit)

  measure_metadata <- get_single_measure(x)

  station_metadata <- get_single_station(measure_metadata$stationReference)

  # Generic plot for all measures
  p <-
    ggplot2::ggplot(data = readings,
                    mapping = ggplot2::aes_string(x = "dateTime",
                                                  y = "value")) +
    ggplot2::labs(title = measure_metadata$label) +
    ggplot2::xlab(NULL) +
    ggplot2::ylab(paste0(measure_metadata$parameterName,
                         " (",
                         measure_metadata$unitName,
                         ")"))

  # Plot level
  if(measure_metadata$parameter == "level" & measure_metadata$qualifier == "Stage"){

    p <- p +
      ggplot2::geom_line() +
      ggplot2::labs(title = paste0(station_metadata$label, " - ", station_metadata$riverName),
                    subtitle = paste0(measure_metadata$parameterName, " - ", measure_metadata$qualifier))

    if(show_max) {
      p <- p +
        ggplot2::geom_hline(yintercept = station_metadata$stageScale$maxOnRecord$value) +
        ggplot2::geom_text(ggplot2::aes(x = min(.data$dateTime),
                                        y = station_metadata$stageScale$maxOnRecord$value,
                                        label = "Max on record",
                                        hjust = "inward",
                                        vjust = 1))
    }

    if(show_high) {
      p <- p +
        ggplot2::geom_hline(yintercept = station_metadata$stageScale$typicalRangeHigh) +
        ggplot2::geom_text(ggplot2::aes(x = min(.data$dateTime),
                                        y = station_metadata$stageScale$typicalRangeHigh,
                                        label = "Typical range high",
                                        hjust = "inward",
                                        vjust = 1))
    }

    if(show_low) {
      p <- p +
        ggplot2::geom_hline(yintercept = station_metadata$stageScale$typicalRangeLow) +
        ggplot2::geom_text(ggplot2::aes(x = min(.data$dateTime),
                                        y = station_metadata$stageScale$typicalRangeLow,
                                        label = "Typical range low",
                                        hjust = "inward",
                                        vjust = 1)
        )
    }


  }


  # Plot level downstream
  if(measure_metadata$parameter == "level" & measure_metadata$qualifier == "Downstream Stage"){
    p <- p +
      ggplot2::geom_line()

    if(!is.null(station_metadata$downstageScale)){
      if(show_max) {
      p <- p +
        ggplot2::geom_hline(yintercept = station_metadata$downstageScale$maxOnRecord$value) +
        ggplot2::geom_text(ggplot2::aes(x = min(.data$dateTime),
                                        y = station_metadata$downstageScale$maxOnRecord$value,
                                        label = "Max on record",
                                        hjust = "inward",
                                        vjust = 1))
      }
      if(show_high) {
      p <- p +
        ggplot2::geom_hline(yintercept = station_metadata$downstageScale$typicalRangeHigh) +
        ggplot2::geom_text(ggplot2::aes(x = min(.data$dateTime),
                                        y = station_metadata$downstageScale$typicalRangeHigh,
                                        label = "Typical range high",
                                        hjust = "inward",
                                        vjust = 1))
      }
      if(show_low) {
        p <- p+
        ggplot2::geom_hline(yintercept = station_metadata$downstageScale$typicalRangeLow) +
        ggplot2::geom_text(ggplot2::aes(x = min(.data$dateTime),
                                        y = station_metadata$downstageScale$typicalRangeLow,
                                        label = "Typical range low",
                                        hjust = "inward",
                                        vjust = 1))
      }
    }

    p <- p +
      ggplot2::labs(title = paste0(station_metadata$label, " - ", station_metadata$riverName),
                    subtitle = paste0(measure_metadata$parameterName, " - ", measure_metadata$qualifier))

  }


  # Plot flow measure
  if(measure_metadata$parameter == "flow"){
    p <- p +
      ggplot2::geom_line() +
      ggplot2::labs(title = paste0(station_metadata$label, " - ", station_metadata$riverName),
                    subtitle = paste0(measure_metadata$parameterName, " - ", measure_metadata$qualifier))
  }


  # Plot temperature measure
  if(measure_metadata$parameter == "temperature"){
    p <- p +
      ggplot2::geom_line()
  }

  # Plot rainfall measure
  if(measure_metadata$parameter == "rainfall"){
    p <- p +
      ggplot2::geom_col() +
      ggplot2::labs(title = paste0(station_metadata$label, " - ", station_metadata$riverName),
                    subtitle = paste0(measure_metadata$parameterName, " - ", measure_metadata$qualifier))
  }


  # Plot wind measure
  if(measure_metadata$parameter == "wind"){
    p <- p +
      ggplot2::geom_line()
  }


  # Return plot
  p

}

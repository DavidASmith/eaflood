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
#'
#' @return ggplot2 plot object.
#' @export
#'
#' @examples
plot_measure_readings <- function(x) {

  readings <- get_readings(measure = x)

  measure_metadata <- get_single_measure(x)

  station_metadata <- get_single_station(measure_metadata$stationReference)

  # Generic plot for all measures
  p <- readings |>
    ggplot2::ggplot(ggplot2::aes(x = dateTime, y = value)) +
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
      ggplot2::geom_hline(yintercept = station_metadata$stageScale$maxOnRecord$value) +
      ggplot2::geom_text(ggplot2::aes(x = min(dateTime),
                    y = station_metadata$stageScale$maxOnRecord$value,
                    label = "Max on record",
                    hjust = "inward",
                    vjust = -1)) +
      ggplot2::geom_hline(yintercept = station_metadata$stageScale$typicalRangeHigh) +
      ggplot2::geom_text(ggplot2::aes(x = min(dateTime),
                    y = station_metadata$stageScale$typicalRangeHigh,
                    label = "Typical range high",
                    hjust = "inward",
                    vjust = -1)) +
      ggplot2::geom_hline(yintercept = station_metadata$stageScale$typicalRangeLow) +
      ggplot2::geom_text(ggplot2::aes(x = min(dateTime),
                    y = station_metadata$stageScale$typicalRangeLow,
                    label = "Typical range low",
                    hjust = "inward",
                    vjust = 1)
      )    +
      ggplot2::labs(title = paste0(station_metadata$label, " - ", station_metadata$riverName),
           subtitle = paste0(measure_metadata$parameterName, " - ", measure_metadata$qualifier))
  }


  # Plot level downstream
  if(measure_metadata$parameter == "level" & measure_metadata$qualifier == "Downstream Stage"){
    p <- p +
      ggplot2::geom_line()

    if(!is.null(station_metadata$downstageScale)){
      p <- p +
        ggplot2::geom_hline(yintercept = station_metadata$downstageScale$maxOnRecord$value) +
        ggplot2::geom_text(ggplot2::aes(x = min(dateTime),
                      y = station_metadata$downstageScale$maxOnRecord$value,
                      label = "Max on record",
                      hjust = "inward",
                      vjust = -1)) +
        ggplot2::geom_hline(yintercept = station_metadata$downstageScale$typicalRangeHigh) +
        ggplot2::geom_text(ggplot2::aes(x = min(dateTime),
                      y = station_metadata$downstageScale$typicalRangeHigh,
                      label = "Typical range high",
                      hjust = "inward",
                      vjust = -1)) +
        ggplot2::geom_hline(yintercept = station_metadata$downstageScale$typicalRangeLow) +
        ggplot2::geom_text(ggplot2::aes(x = min(dateTime),
                      y = station_metadata$downstageScale$typicalRangeLow,
                      label = "Typical range low",
                      hjust = "inward",
                      vjust = 1))
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

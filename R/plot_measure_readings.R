#' Plot readings for a given measure
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
plot_measure_readings <- function(x) {

  readings <- get_readings(measure = x)

  measure_metadata <- get_single_measure(x)

  station_metadata <- get_single_station(measure_metadata$stationReference)

  # Generic plot for all measures
  p <- readings |>
    ggplot2::ggplot(aes(dateTime, value)) +
    labs(title = measure_metadata$label) +
    xlab(NULL) +
    ylab(paste0(measure_metadata$parameterName,
                " (",
                measure_metadata$unitName,
                ")"))

  # Plot level
  if(measure_metadata$parameter == "level" & measure_metadata$qualifier == "Stage"){

    p <- p +
      geom_line() +
      geom_hline(yintercept = station_metadata$stageScale$maxOnRecord$value) +
      geom_text(aes(x = min(dateTime),
                    y = station_metadata$stageScale$maxOnRecord$value,
                    label = "Max on record",
                    hjust = "inward",
                    vjust = -1)) +
      geom_hline(yintercept = station_metadata$stageScale$typicalRangeHigh) +
      geom_text(aes(x = min(dateTime),
                    y = station_metadata$stageScale$typicalRangeHigh,
                    label = "Typical range high",
                    hjust = "inward",
                    vjust = -1)) +
      geom_hline(yintercept = station_metadata$stageScale$typicalRangeLow) +
      geom_text(aes(x = min(dateTime),
                    y = station_metadata$stageScale$typicalRangeLow,
                    label = "Typical range low",
                    hjust = "inward",
                    vjust = 1)
      )    +
      labs(title = paste0(station_metadata$label, " - ", station_metadata$riverName),
           subtitle = paste0(measure_metadata$parameterName, " - ", measure_metadata$qualifier))
  }


  # Plot level downstream
  if(measure_metadata$parameter == "level" & measure_metadata$qualifier == "Downstream Stage"){
    p <- p +
      geom_line()

    if(!is.null(station_metadata$downstageScale)){
      p <- p +
        geom_hline(yintercept = station_metadata$downstageScale$maxOnRecord$value) +
        geom_text(aes(x = min(dateTime),
                      y = station_metadata$downstageScale$maxOnRecord$value,
                      label = "Max on record",
                      hjust = "inward",
                      vjust = -1)) +
        geom_hline(yintercept = station_metadata$downstageScale$typicalRangeHigh) +
        geom_text(aes(x = min(dateTime),
                      y = station_metadata$downstageScale$typicalRangeHigh,
                      label = "Typical range high",
                      hjust = "inward",
                      vjust = -1)) +
        geom_hline(yintercept = station_metadata$downstageScale$typicalRangeLow) +
        geom_text(aes(x = min(dateTime),
                      y = station_metadata$downstageScale$typicalRangeLow,
                      label = "Typical range low",
                      hjust = "inward",
                      vjust = 1))
    }

    p <- p +
      labs(title = paste0(station_metadata$label, " - ", station_metadata$riverName),
           subtitle = paste0(measure_metadata$parameterName, " - ", measure_metadata$qualifier))

  }


  # Plot flow measure
  if(measure_metadata$parameter == "flow"){
    p <- p +
      geom_line() +
      labs(title = paste0(station_metadata$label, " - ", station_metadata$riverName),
           subtitle = paste0(measure_metadata$parameterName, " - ", measure_metadata$qualifier))
  }


  # Plot temperature measure
  if(measure_metadata$parameter == "temperature"){
    p <- p +
      geom_line()
  }

  # Plot rainfall measure
  if(measure_metadata$parameter == "rainfall"){
    p <- p +
      geom_col() +
      labs(title = paste0(station_metadata$label, " - ", station_metadata$riverName),
           subtitle = paste0(measure_metadata$parameterName, " - ", measure_metadata$qualifier))
  }


  # Plot wind measure
  if(measure_metadata$parameter == "wind"){
    p <- p +
      geom_line()
  }


  # Return plot
  p

}


# A level measure
x <- "L0215-level-stage-i-15_min-m"
x <- "L0218-level-stage-i-15_min-m"

# A downstream level measure
x <- "1029TH-level-downstage-i-15_min-mASD"
x <- "4615TH-level-downstage-i-15_min-mASD"


# A flow measure
x <- "F1906-flow-logged-i-15_min-m3_s"

# A rainfall measure
x <- "E7050-rainfall-tipping_bucket_raingauge-t-15_min-mm"

# A wind measure
x <- "755900-wind-direction-Mean-15_min-deg" # direction
x <- "720763-wind-speed-Mean-15_min-m_s" #  speed



# A temperature measure
x <- "3680-temperature-dry_bulb-i-15_min-deg_C"



readings <- get_readings(measure = x)

measure_metadata <- get_single_measure(x)

station_metadata <- get_single_station(measure_metadata$stationReference)

# Generic plot for all measures
p <- readings |>
  ggplot2::ggplot(aes(dateTime, value)) +
  labs(title = paste0(station_metadata$label, " - ", station_metadata$riverName)) +
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
    )
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
                  vjust = -1))
  }

}


# Plot flow measure
if(measure_metadata$parameter == "flow"){
  p <- p +
    geom_line()
}


# Plot temperature measure
if(measure_metadata$parameter == "temperature"){
  p <- p +
    geom_line()
}

# Plot rainfall measure
if(measure_metadata$parameter == "rainfall"){
  p <- p +
    geom_col()
}


# Plot wind measure
if(measure_metadata$parameter == "wind"){
  p <- p +
    geom_line()
}



p


#
#
# Anomaly Tab
#
#

source(file.path("required", "libraries.R"),  local = TRUE)$value

#
# LINE GRAPHS
#

# PRIMARY METRIC

# Data preparation

anomaly_primary_metric_data <- reactive({
  
  data <- ga_primary_metric()
  choice <- input$metric
  
  ## make reactive to choice
  agg    <- input$periodValue
  max_a  <- input$max_anoms
  
  agg_data <- aggregate_data(data[,c('date', choice)], agg)
  
  ad <- try(anomalyDetect(agg_data[,c('date', choice)], direction="both", max_anoms = max_a))
  
  if(!is.error(ad)){
    return(ad)
  } else {
    NULL
  }
  
})

# Rendering line graph

output$anomaly_primary_metric_plot <- renderDygraph({
  
  choice <- input$metric
  agg <- input$periodValue
  data <- ga_primary_metric()
  
  anomalies <- anomaly_primary_metric_data()$anoms
  
  agg_data <- data[,c('date', choice)]
  names(agg_data) <- c('date', 'metric')
  
  agg_data <- aggregate_data(data[,c('date', choice)], agg)
  
  ts_data <- zoo(agg_data[,choice], 
                 order.by = agg_data[,'date'])
  
  d <- dygraph(ts_data) %>%
    dySeries("V1", color = "#8a48a4", label = str_to_title(choice) ) %>%
    dyOptions(fillGraph = TRUE, fillAlpha = 0.4, drawPoints = TRUE, pointSize = 1, drawGrid = FALSE, colors = "#18bc9c")
  
  
  if(!is.null(anomalies)){
    for(i in 1:length(anomalies$timestamp))
      d <- d %>% dyEvent(anomalies$timestamp[i], "Anomaly", color = "gray")
  }
  
  return(d)
  
})

# SECONDARY METRIC

# Data preparation

anomaly_secondary_metric_data <- reactive({
  
  data <- ga_secondary_metric()
  choice <- input$secondaryMetric
  
  ## make reactive to choice
  agg    <- input$periodValue
  max_a  <- input$max_anoms
  
  agg_data <- aggregate_data(data[,c('date', choice)], agg)
  
  ad <- try(anomalyDetect(agg_data[,c('date', choice)], direction="both", max_anoms = max_a))
  
  if(!is.error(ad)){
    return(ad)
  } else {
    NULL
  }
  
})

# Rendering line graph

output$anomaly_secondary_metric_plot <- renderDygraph({
  
  choice <- input$secondaryMetric
  agg <- input$periodValue
  data <- ga_secondary_metric()
  
  anomalies <- anomaly_secondary_metric_data()$anoms
  
  agg_data <- data[,c('date', choice)]
  names(agg_data) <- c('date', 'metric')
  
  agg_data <- aggregate_data(data[,c('date', choice)], agg)
  
  ts_data <- zoo(agg_data[,choice], 
                 order.by = agg_data[,'date'])
  
  d <- dygraph(ts_data) %>%
    dySeries("V1", color = "#8a48a4", label = str_to_title(choice) ) %>%
    dyOptions(fillGraph = TRUE, fillAlpha = 0.4, drawPoints = TRUE, pointSize = 1, drawGrid = FALSE, colors = "#0277BD")
  
  
  if(!is.null(anomalies)){
    for(i in 1:length(anomalies$timestamp))
      d <- d %>% dyEvent(anomalies$timestamp[i], "Anomaly", color = "gray")
  }
  
  return(d)
  
})
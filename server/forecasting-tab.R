#
#
# Forecasting Tab
#
#

source(file.path("required", "libraries.R"),  local = TRUE)$value

#
# LINE GRAPHS
#

# PRIMARY METRIC

output$forecast_plot <- renderDygraph({
  
  req(ga_primary_metric())
  req(input$metric)
  req(input$forecastPeriod)
  
  dataframe <- cbind(ga_primary_metric())
  
  metric <- input$metric
  
  setnames(dataframe, old=c("date", input$metric), new=c("ds", "y"))
  
  m <- prophet(dataframe)
  
  future <- make_future_dataframe(m, periods = input$forecastPeriod)
  
  forecast <- predict(m, future)
  
  
  ## plotting the dygraph
  dyplot.prophet(m, forecast, uncertainty = TRUE) %>% dyOptions(drawGrid = FALSE, colors = c("black", "#18bc9c"))
  
})

# SECONDARY METRIC

output$forecast_secondary_metric <- renderDygraph({
  
  req(ga_secondary_metric())
  req(input$secondaryMetric)
  req(input$forecastPeriod)
  
  dataframe <- cbind(ga_secondary_metric())
  
  metric <- input$secondaryMetric
  
  setnames(dataframe, old=c("date", metric), new=c("ds", "y"))
  
  m <- prophet(dataframe)
  
  future <- make_future_dataframe(m, periods = input$forecastPeriod)
  
  forecast <- predict(m, future)
  
  ## plotting the dygraph
  dyplot.prophet(m, forecast, uncertainty = TRUE) %>% dyOptions(drawGrid = FALSE, colors = c("black", "#0277BD"))
  
})
#
#
# Seasonality Tab
#
#

source("libraries.R")

#
# LINE GRAPHS
#

# PRIMARY METRIC

output$primary_metric_season_plot <- renderDygraph({
  
  req(ga_primary_metric())
  req(input$metric)
  
  ga_primary_metric <- ga_primary_metric()
  metric <- input$metric
  
  ga_primary_metric_tsd <- ts(ga_primary_metric[,2], frequency = 365)
  decomp = decompose(ga_primary_metric_tsd)
  
  decomposition_func <- function(x)  {
    
    tryCatch(
      {
        ga_primary_metric_tsd <- ts(ga_primary_metric[,2], frequency = 365)
        decomp = decompose(ga_primary_metric_tsd)
      },
      error = function(cond) {
        message(paste("There is not enough data", ga_primary_metric_tsd))
        message("Here is the problem:")
        message(cond)
        return(NA)
      },
      warning = function(cond) {
        message(paste("While decomposing the data there was a warning:", url))
        message("Here's the original warning message:")
        message(cond)
        # Choose a return value in case of warning
        return(NULL)
      },
      finally = {
        message(paste("Data decomposed", ga_primary_metric_tsd))
      }
    )
    return(decomp)
  }
  
  ### adding seasonal values to the df dataframe
  ga_primary_metric$seasonal <- decomp$seasonal
  
  ### adding trend values to the df dataframe
  ga_primary_metric$trend <- decomp$trend
  
  ### adding residual values to the df dataframe
  ga_primary_metric$random <- decomp$random
  
  ga_primary_metric_ts <- xts(ga_primary_metric[,3], order.by = ga_primary_metric$date)
  
  ## plotting the dygraph
  ga_primary_metric_ts %>% dygraph(group = "seasonality-graphs") %>%
    ## disable grid
    dyOptions(drawGrid = FALSE) %>%
    ## update label based on the metric selected
    dySeries(label = input$metric) %>%
    ## change the line graph to a fill graph
    dyOptions(fillGraph = TRUE,
              fillAlpha = 0.4,
              drawPoints = FALSE,
              pointSize = 1,
              drawGrid = FALSE,
              drawGapEdgePoints = TRUE,
              colors = "#18bc9c"
    ) %>%
    dyRangeSelector()
  
})

# SECONDARY METRIC

output$secondary_metric_season_plot <- renderDygraph({
  
  req(ga_secondary_metric())
  req(input$secondaryMetric)
  
  ga_secondary_metric <- ga_secondary_metric()
  metric <- input$secondaryMetric
  
  ga_secondary_metric_tsd <- ts(ga_secondary_metric[,2], frequency = 365)
  decomp = decompose(ga_secondary_metric_tsd)
  
  decomposition_func <- function(x)  {
    
    tryCatch(
      {
        ga_secondary_metric_tsd <- ts(ga_secondary_metric[,2], frequency = 365)
        decomp = decompose(ga_secondary_metric_tsd)
      },
      error = function(cond) {
        message(paste("There is not enough data", ga_secondary_metric_tsd))
        message("Here is the problem:")
        message(cond)
        return(NA)
      },
      warning = function(cond) {
        message(paste("While decomposing the data there was a warning:", url))
        message("Here's the original warning message:")
        message(cond)
        # Choose a return value in case of warning
        return(NULL)
      },
      finally = {
        message(paste("Data decomposed", ga_secondary_metric_tsd))
      }
    )
    return(decomp)
  }
  
  ### adding seasonal values to the df dataframe
  ga_secondary_metric$seasonal <- decomp$seasonal
  
  ### adding trend values to the df dataframe
  ga_secondary_metric$trend <- decomp$trend
  
  ### adding residual values to the df dataframe
  ga_secondary_metric$random <- decomp$random
  
  ga_secondary_metric_ts <- xts(ga_secondary_metric[,3], order.by = ga_secondary_metric$date)
  
  ## plotting the dygraph
  ga_secondary_metric_ts %>% dygraph(group = "seasonality-graphs") %>%
    ## disable grid
    dyOptions(drawGrid = FALSE) %>%
    ## update label based on the metric selected
    dySeries(label = input$secondaryMetric) %>%
    ## change the line graph to a fill graph
    dyOptions(fillGraph = TRUE,
              fillAlpha = 0.4,
              drawPoints = FALSE,
              pointSize = 1,
              drawGrid = FALSE,
              drawGapEdgePoints = TRUE,
              colors = "#0277BD"
    ) %>%
    dyRangeSelector()
  
})
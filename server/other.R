
source(file.path("required", "libraries.R"),  local = TRUE)$value

#
# SCATTER PLOT FOR THE RELATIONSHIP OF THE 2 METRICS
# Exploratory tab
#

output$metric_scatter_plot <- renderPlotly({
  
  req(ga_merged_metrics())
  req(input$metric)
  req(input$secondaryMetric)
  
  ga_merged_metrics <- ga_merged_metrics()
  
  primaryMetric <- input$metric
  secondaryMetric <- input$secondaryMetric
  
  fv <- ga_merged_metrics %>%
    lm(sessions ~ transactionRevenue,.) %>%
    fitted.values()
  
  plot_ly(data = ga_merged_metrics, x = ~sessions, y = ~transactionRevenue, type = "scatter",
          marker = list(size = 10, color = "#18bc9c",
                        line = list(color = "#169c81", width = 1))) %>%
    config(displayModeBar = F)%>%
    layout( yaxis = list(zeroline = FALSE),
            xaxis = list(zeroline = FALSE))
})

## Rendering graph trend

output$sessions_trend_plot <- renderDygraph({
  
  req(ga_primary_metric())
  req(input$metric)
  
  ga_primary_metric <- ga_primary_metric()
  metric <- input$metric
  
  
  ga_primary_metric_tsd <- ts(ga_primary_metric[,2], frequency = 365)
  decomp = decompose(ga_primary_metric_tsd)
  
  ### adding seasonal values to the df dataframe
  ga_primary_metric$seasonal <- decomp$seasonal
  
  ### adding trend values to the df dataframe
  ga_primary_metric$trend <- decomp$trend
  
  ### adding residual values to the df dataframe
  ga_primary_metric$random <- decomp$random
  
  ga_primary_metric_ts <- xts(ga_primary_metric[,4], order.by = ga_primary_metric$date)
  
  ## plotting the dygraph
  ga_primary_metric_ts %>% dygraph %>%
    ## disable grid
    dyOptions(drawGrid = FALSE) %>%
    ## update label based on the metric selected
    dySeries(label = input$metric) %>%
    ## change the line graph to a fill graph
    dyOptions(fillGraph = TRUE, fillAlpha = 0.4, drawPoints = FALSE, pointSize = 1, drawGrid = FALSE, colors = "#3498db")
  
})

## Rendering graph "Percentage of daily sessions by gender"

output$gender_plot <- renderDygraph({
  req(ga_data_with_Gender())
  req(input$metric)
  
  ga_data_with_Gender <- ga_data_with_Gender()
  
  metric <- input$metric
  
  ## Pivot table to split sessions by gender
  ga_gender_data_pivot <- spread(ga_data_with_Gender, "userGender", metric)
  ## adding total sessions column to the dataframe
  ga_gender_data_pivot$metric = apply(ga_gender_data_pivot[,-1],1,sum)
  ## calculating percentage of sessions by gender
  ga_gender_data_pivot$female_pct = ga_gender_data_pivot$female / ga_gender_data_pivot$metric
  ga_gender_data_pivot$male_pct = ga_gender_data_pivot$male / ga_gender_data_pivot$metric
  ## running xts for the 2 columns female_pct and male_pct
  ga_gender_data_ts <- xts(x = ga_gender_data_pivot[,5:6], order.by = ga_gender_data_pivot$date)
  ## plotting the dygraph
  ga_gender_data_ts %>% dygraph %>%
    ## set labels for the two variables
    dySeries("female_pct", label = "Female %") %>%
    dySeries("male_pct", label = "Male %") %>%
    ## disable grid
    dyOptions(drawGrid = FALSE, drawPoints = TRUE, pointSize = 1) %>%
    ## format the Y Axis to display the values in percentages
    dyAxis("y", valueFormatter = "function(v){return (v*100).toFixed(1) + '%'}",
           axisLabelFormatter = "function(v){return (v*100).toFixed(0) + '%'}")
  
})
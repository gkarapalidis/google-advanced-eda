#
#
# Performance Tab
#
#

source("libraries.R")

#
# LINE GRAPHS
#

## PRIMARY METRIC LINE GRAPHS

output$sessions_plot <- renderDygraph({
  
  req(ga_primary_metric())
  req(input$metric)
  req(input$periodValue)
  
  data <- ga_primary_metric()
  metric <- input$metric
  period <- input$periodValue
  
  agg_data <- data[,c("date", metric)]
  names(agg_data) <- c("date", "metric")
  
  agg_data <- aggregate_data(data[,c("date", metric)], period)
  
  #ga_primary_metric_ts <- xts(ga_primary_metric[,2], order.by = ga_primary_metric$date)
  
  ga_primary_metric_ts <- zoo(agg_data[,metric], order.by = agg_data[,'date'])
  
  
  ## plotting the dygraph
  ga_primary_metric_ts %>% dygraph(group = "performance-graphs") %>%
    ## disable grid
    dyOptions(drawGrid = FALSE) %>%
    ## update label based on the metric selected
    dySeries(label = input$metric) %>%
    ## change the line graph to a fill graph
    dyOptions(fillGraph = TRUE, fillAlpha = 0.4, drawPoints = TRUE, pointSize = 1, drawGrid = FALSE, colors = "#18bc9c") %>%
    dyRangeSelector() %>%
    ## add events
    dyEvent("2019-06-06", "Site Diversity Update", color = "gray", labelLoc = "bottom") %>%
    dyEvent("2019-06-03", "Core Update", color = "gray", labelLoc = "bottom") %>%
    dyEvent("2019-05-23", "Indexing Bugs", color = "gray", labelLoc = "bottom") %>%
    dyEvent("2019-04-05", "Deindexing Bug", color = "gray", labelLoc = "bottom") %>%
    dyEvent("2019-03-12", "Core Update: Florida 2", color = "gray", labelLoc = "bottom") %>%
    dyEvent("2019-04-01", "SERPs Update", color = "gray", labelLoc = "bottom") %>%
    dyEvent("2019-02-06", "Unnamed Update", color = "gray", labelLoc = "bottom")
  
})


## SECONDARY METRIC LINE GRAPH

output$secondary_metric_plot <- renderDygraph({
  
  req(ga_secondary_metric())
  req(input$secondaryMetric)
  req(input$periodValue)
  
  data <- ga_secondary_metric()
  metric <- input$secondaryMetric
  period <- input$periodValue
  
  agg_data <- data[,c("date", metric)]
  names(agg_data) <- c("date", "metric")
  
  agg_data <- aggregate_data(data[,c("date", metric)], period)
  
  #ga_primary_metric_ts <- xts(ga_primary_metric[,2], order.by = ga_primary_metric$date)
  
  ga_secondary_metric_ts <- zoo(agg_data[,metric], order.by = agg_data[,'date'])
  
  
  ## plotting the dygraph
  ga_secondary_metric_ts %>% dygraph(group = "performance-graphs") %>%
    ## disable grid
    dyOptions(drawGrid = FALSE) %>%
    ## update label based on the metric selected
    dySeries(label = input$secondaryMetric) %>%
    ## change the line graph to a fill graph
    dyOptions(fillGraph = TRUE, fillAlpha = 0.4, drawPoints = TRUE, pointSize = 1, drawGrid = FALSE, colors = "#0277BD") %>%
    dyRangeSelector() %>%
    ## add events
    dyEvent("2019-06-06", "Site Diversity Update", color = "gray", labelLoc = "bottom") %>%
    dyEvent("2019-06-03", "Core Update", color = "gray", labelLoc = "bottom") %>%
    dyEvent("2019-05-23", "Indexing Bugs", color = "gray", labelLoc = "bottom") %>%
    dyEvent("2019-04-05", "Deindexing Bug", color = "gray", labelLoc = "bottom") %>%
    dyEvent("2019-03-12", "Core Update: Florida 2", color = "gray", labelLoc = "bottom") %>%
    dyEvent("2019-04-01", "SERPs Update", color = "gray", labelLoc = "bottom") %>%
    dyEvent("2019-02-06", "Unnamed Update", color = "gray", labelLoc = "bottom")
  
})


#
# 
# HEATMAPS
#
#


# PRIMARY METRIC

# DATA PREPARATION

plot_date_data <- reactive({
  
  req(ga_primary_metric())
  req(input$metric)
  
  data <- ga_primary_metric()
  
  if(is.null(data)){
    return(NULL)
  }
  
  choice <- input$metric
  plot1_dates <- input$datepicker
  
  min_date <- min(plot1_dates[1])
  max_date <- max(plot1_dates[2])
  
  pdata <- data[data$date > min_date &
                  data$date < max_date,]
  
  pdata <- pdata[,colnames(pdata) %in% c("date", choice)]
  
  
})


# PRIMARY METRIC RENDERING HEATMAP

output$heatmap_primary_metric <- renderD3heatmap({
  # validate(
  #   need(is.null(plot_date_data()), "Plot data")
  # )
  
  hm_data <- plot_date_data()
  
  week_pad <- period_function_generator("week", pad = TRUE)
  
  hm_data$wday <- lubridate::wday(hm_data$date, label = TRUE, abbr = TRUE, week_start = 1)
  
  hm_data$week <- paste0(year(hm_data$date),
                         " W",
                         week_pad(hm_data$date)
  )
  
  names(hm_data) <- c("date", "sessions", "wday", "week")
  
  hm_data <- tbl_df(hm_data)
  
  hm_f <- tidyr::spread(hm_data[,c("sessions","wday","week")],
                        wday,
                        sessions)
  hm_m <- as.matrix(hm_f %>% dplyr::select(-week))
  row.names(hm_m) <- factor(hm_f$week)
  
  hm_m[is.na(hm_m)] <- 0
  
  d3heatmap(hm_m,
            colors = "Blues",
            Rowv = FALSE,
            Colv = FALSE,
            labRow = row.names(hm_m),
            labCol = colnames(hm_m)
  )
  
  
  
})

# SECONDARY METRIC HEATMAP 

# DATA PREPARATION

plot_date_data_secondary_metric <- reactive({
  
  data <- ga_secondary_metric()
  
  if(is.null(data)){
    return(NULL)
  }
  
  choice <- input$secondaryMetric
  plot1_dates <- input$datepicker
  
  min_date <- min(plot1_dates[1])
  max_date <- max(plot1_dates[2])
  
  pdata <- data[data$date > min_date &
                  data$date < max_date,]
  
  pdata <- pdata[,colnames(pdata) %in% c("date", choice)]
  
  
})


# SECONDARY METRIC RENDERING HEATMAP

output$heatmap_secondary_metric <- renderD3heatmap({
  # validate(
  #   need(is.null(plot_date_data()), "Plot data")
  # )
  
  hm_data <- plot_date_data_secondary_metric()
  
  week_pad <- period_function_generator("week", pad = TRUE)
  
  hm_data$wday <- lubridate::wday(hm_data$date, label = TRUE, abbr = TRUE, week_start = 1)
  
  hm_data$week <- paste0(year(hm_data$date),
                         " W",
                         week_pad(hm_data$date)
  )
  
  names(hm_data) <- c("date", "sessions", "wday", "week")
  
  hm_data <- tbl_df(hm_data)
  
  hm_f <- tidyr::spread(hm_data[,c("sessions","wday","week")],
                        wday,
                        sessions)
  hm_m <- as.matrix(hm_f %>% dplyr::select(-week))
  row.names(hm_m) <- factor(hm_f$week)
  
  hm_m[is.na(hm_m)] <- 0
  
  d3heatmap(hm_m,
            colors = "Greens",
            Rowv = FALSE,
            Colv = FALSE,
            labRow = row.names(hm_m),
            labCol = colnames(hm_m)
  )
  
  
  
})
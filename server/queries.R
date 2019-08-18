
source("libraries.R")

#
# GA Query for Primary metric
#

ga_primary_metric <- reactive({
  
  req(view_id())
  req(input$datepicker)
  req(input$metric)
  req(input$channel)
  req(input$samplingValue)
  
  ## Setting up the GA  query
  
  with_shiny(
    google_analytics,
    view_id(),
    date_range = input$datepicker,
    dimensions = c("date"),
    metrics = input$metric,
    filter = input$channel,
    max = -1,
    anti_sample = input$samplingValue,
    shiny_access_token = auth()
  )
})

#
# GA Query for Secondary metric
#

ga_secondary_metric <- reactive({
  
  req(view_id())
  req(input$datepicker)
  req(input$secondaryMetric)
  req(input$channel)
  req(input$samplingValue)
  
  ## Setting up the GA  query
  
  with_shiny(
    google_analytics,
    view_id(),
    date_range = input$datepicker,
    dimensions = c("date"),
    metrics = input$secondaryMetric,
    filter = input$channel,
    max = -1,
    anti_sample = input$samplingValue,
    shiny_access_token = auth()
  )
})

#
# Merge Queries for Primary and Secondary Metrics in a single dataframe
#

ga_merged_metrics <- reactive({
  
  merge(ga_primary_metric(), ga_secondary_metric(), by = "date", all = TRUE)
  
})

### GA query for sessions and userGender
#
#

ga_data_with_Gender <- reactive({
  
  req(view_id())
  req(input$datepicker)
  req(input$metric)
  req(input$channel)
  req(input$samplingValue)
  
  ## Setting up the GA  query
  
  with_shiny(
    google_analytics,
    view_id(),
    date_range = input$datepicker,
    dimensions = c("date", "userGender"),
    metrics = input$metric,
    filter = input$channel,
    max = -1,
    anti_sample = input$samplingValue,
    shiny_access_token = auth()
  )
})
##
## server.R
##

source("libraries.R")

server = function(input, output, session) {
  
  source(file.path("server", "queries.R"),  local = TRUE)$value
  source(file.path("server", "functions.R"),  local = TRUE)$value
  source(file.path("server", "performance-tab.R"),  local = TRUE)$value
  source(file.path("server", "seasonality-tab.R"),  local = TRUE)$value
  source(file.path("server", "forecasting-tab.R"),  local = TRUE)$value
  source(file.path("server", "anomaly-tab.R"),  local = TRUE)$value
  source(file.path("server", "other.R"),  local = TRUE)$value

  ## get auth token
  auth <- callModule(googleAuth_js, "auth")
  
  ## get ga_accounts
  ga_accounts <- reactive({
    req(auth())
    
    with_shiny(
      ga_account_list,
      shiny_access_token = auth()
    )
    
  })
  
  ## get viewID from the dropdown
  
  view_id <- callModule(authDropdown, "auth_dropdown", 
                        ga.table = ga_accounts)
  
  
  # Anti-Sampling Notifications
  
  observeEvent(input$samplingValue, {
    
    if (input$samplingValue == TRUE) { showNotification(paste("Anti-sampling turned ON. Slower data extraction, higher accuracy."), duration = 3, type = "warning", closeButton = TRUE)
    } else {showNotification("Anti-sampling turned OFF. Faster data extraction, lower accuracy.", duration = 1.5, type = "warning", closeButton = TRUE)
    
    }
  })
  
  # Download datasets button
  
  thedata <- reactive(iris)
  #req(output$downloadData)
  
  output$downloadData <- downloadHandler(
    filename = function(){"dataset.csv"}, 
    content = function(fname){
      write.csv(ga_primary_metric(), fname)
    }
  )
} ## Server script ends here
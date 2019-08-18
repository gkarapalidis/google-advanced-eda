## libraries.R

# List of all libraries required by the app

# Shiny

library(shiny)             
library(shinyjs)
library(shinysky)
library(shinythemes)       
library(shinyWidgets)
library(shinybusy)

# Google

library(googleAuthR)       ## auth login
library(googleAnalyticsR)  ## get google analytics

gar_set_client(scopes = "https://www.googleapis.com/auth/analytics.readonly")

# Graphs and visual

library(dygraphs) 
library(ggplot2)
library(plotly)
library(d3heatmap)

# Models and time series

library(prophet)
library(AnomalyDetection)
library(CausalImpact)
library(xts)
library(tseries)
library(zoo)

# Data manipulation

library(tidyr)
library(lubridate)
library(stringr)
library(dplyr)
library(data.table)
library(DT)

# Shiny app

library(rsconnect)
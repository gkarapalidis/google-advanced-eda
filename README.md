# Advanced EDA for Google Analytics

Hi! This is my first ShinyApp and its purpose is to help analyse data from Google Analytics easily and quickly. 
This app is purely an experiment and a way for me to become more familiar with R, Shiny and statistical models.
Inspiration was taken from a Shiny demo dashboard [Mark Edmondson](https://github.com/MarkEdmondson1234) created. 

It requests data for two metrics at the same time and you can perform the below exploratory and predictive analysis.

 1. Performance over time for up to two metrics and Google updates annotations for reference.
 2. Extraction of seasonality using time series decomposition
 3. Forecasting using Facebook Prophet
 4. Anomaly detection
 5. Causal effect analysis (in development)
 6. Weather correlations (in development)

I will keep developing the app and continue making changes to the UI and features. 

## Packages

Packages currently in use listed below and links to all the original sources provided for reference.

**Shiny libraries**
[shiny](https://github.com/rstudio/shiny) (1.3.2.9001)
[shinyjs](https://github.com/daattali/shinyjs) (1.0)
[shinysky](https://github.com/AnalytixWare/ShinySky) (0.1.2)
[shinythemes](https://github.com/rstudio/shinythemes) (1.1.2)
[shinyWidgets](https://github.com/dreamRs/shinyWidgets) (0.4.8)
[shinybusy](https://github.com/dreamRs/shinybusy) (0.1.2)

**Google API libraries**
[googleAuthR](https://code.markedmondson.me/googleAuthR/) (0.8.1)
[googleAnalyticsR](https://code.markedmondson.me/googleAnalyticsR/) (0.6.0)

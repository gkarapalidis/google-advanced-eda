# Advanced EDA for Google Analytics

Hi! This is my first ShinyApp and its purpose is to help analyse data from Google Analytics easily and quickly. 
This app is purely an experiment and a way for me to become more familiar with R, Shiny and statistical models.
Inspiration was taken from a Shiny demo dashboard [Mark Edmondson](https://github.com/MarkEdmondson1234) created. 

Its supports app to two metrics at the same time and you can perform the below exploratory and predictive analysis.

 1. Performance over time for up to two metrics and Google updates annotations for reference.
 2. Extraction of seasonality using time series decomposition
 3. Forecasting using Facebook Prophet
 4. Anomaly detection
 5. Causal effect analysis (in development)
 6. Weather correlations (in development)

I will keep developing the app and continue making changes to the UI and features. 

![enter image description here](https://lh3.googleusercontent.com/IKtaRXpSlzfBXH_Qh6_MBiG86YtKtby9wvdPNG1VsoUAhf1d8aPgMIpYEbF-5Se-IDWtkyhkjltk "Advanced EDA Screenshot")

[Demo](https://karapalidis.com/advanced-eda/)

## Packages

Packages currently in use listed below and links to all the original sources provided for reference.

**Shiny libraries**
[shiny](https://github.com/rstudio/shiny) (1.3.2.9001)
[shinyjs](https://github.com/daattali/shinyjs) (1.0)
[shinysky](https://github.com/AnalytixWare/ShinySky) (0.1.2)
[shinythemes](https://github.com/rstudio/shinythemes) (1.1.2)
[shinyWidgets](https://github.com/dreamRs/shinyWidgets) (0.4.8)
[shinybusy](https://github.com/dreamRs/shinybusy) (0.1.2)
[rsconnect](https://github.com/rstudio/rsconnect) (0.8.15)

**Google API libraries**
[googleAuthR](https://code.markedmondson.me/googleAuthR/) (0.8.1)
[googleAnalyticsR](https://code.markedmondson.me/googleAnalyticsR/) (0.6.0)

**Graph libraries**
[dygraphs](https://github.com/rstudio/dygraphs) (1.1.1.6)
[ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html) (3.2.1)
[plotly](https://cran.r-project.org/web/packages/plotly/index.html) (4.9.0)
[d3heatmap](https://github.com/rstudio/d3heatmap) (0.6.1.2)

**Models and time series**
[prophet](https://facebook.github.io/prophet/) (0.5)
[AnomalyDetection](https://github.com/twitter/AnomalyDetection) (1.0)
[CausalImpact](https://github.com/google/CausalImpact) (1.2.3)
[xts](https://cran.r-project.org/web/packages/xts/index.html) (0.11-2)
[tseries](https://cran.r-project.org/web/packages/tseries/index.html) (0.10-47)
[zoo](https://cran.r-project.org/web/packages/zoo/index.html) (1.8-6)

**Data manipulation**
tidyr (0.8.3)
lubridate (1.7.4)
stringr (1.4.0)
dplyr (0.8.3)
data.table (1.12.2)
DT (0.8)

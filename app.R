##################################################################################################
# Project   : Advanced EDA
#
# Author    : George Karapalidis
#
# Created   : 15/07/2019
#
# Updated   : 17/08/2019
#
# Version   : 0.1.1
#
# Demo on   : https://karapalidis.com/advanced-eda/
#
# Github    : https://github.com/gkarapalidis/advanced-eda/
#
# Purpose   : Data tool for quick and easy exploratory data analysis using data 
#             from Google analytics and Google Search Console.
#
# Files     : dependencies.R
#             libraries.R
#             ui.R
#             server.R
#             server/performace-tab.R
#             server/seasonality-tab.R
#             server/forecasting-tab.R
#             server/anomaly-tab.R
#             server/functions.R
#             server/ga-queries.R
#
#################################################################################################

# load libraries
source("libraries.R")

shinyApp(ui = ui.R, server = server.R)

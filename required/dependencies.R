# R version 3.6.1 (2019-07-05)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows >= 8 x64 (build 9200)

# locale:
# LC_COLLATE=English_United Kingdom.1252      LC_CTYPE=English_United Kingdom.1252    
# LC_MONETARY=English_United Kingdom.1252     LC_NUMERIC=C 
# LC_TIME=English_United Kingdom.1252   

# attached base packages:
# stats     graphics  grDevices utils     datasets  methods   base     

# other attached packages:
# CausalImpact_1.2.3      bsts_0.9.1             BoomSpikeSlab_1.1.1    Boom_0.9.1             MASS_7.3-51.4         
# rsconnect_0.8.15        data.table_1.12.2      tseries_0.10-47        xts_0.11-2             prophet_0.5           
# rlang_0.4.0             Rcpp_1.0.2             AnomalyDetection_1.0   DT_0.8                 stringr_1.4.0         
# dplyr_0.8.3             lubridate_1.7.4        tidyr_0.8.3            zoo_1.8-6              shinybusy_0.1.2       
# googleAnalyticsR_0.6.0  googleAuthR_0.8.1      d3heatmap_0.6.1.2      plotly_4.9.0           ggplot2_3.2.1         
# dygraphs_1.1.1.6        shinyWidgets_0.4.8     shinythemes_1.1.2      shinysky_0.1.2         plyr_1.8.4            
# RJSONIO_1.3-1.2         shinyjs_1.0            shiny_1.3.2.9001      

# loaded via a namespace (and not attached):
# fs_1.3.1             matrixStats_0.54.0    usethis_1.5.1         devtools_2.1.0        RColorBrewer_1.1-2   
# httr_1.4.0           rprojroot_1.3-2       rstan_2.19.2          tools_3.6.1           backports_1.1.4      
# R6_2.4.0             lazyeval_0.2.2        colorspace_1.4-1      withr_2.1.2           tidyselect_0.2.5     
# gridExtra_2.3        prettyunits_1.0.2     processx_3.4.1        curl_4.0              compiler_3.6.1       
# cli_1.1.0            desc_1.2.0            scales_1.0.0          quadprog_1.5-7        callr_3.3.1          
# digest_0.6.20        StanHeaders_2.18.1-10 extraDistr_1.8.11     base64enc_0.1-3       pkgconfig_2.0.2      
# htmltools_0.3.6      sessioninfo_1.1.1     fastmap_1.0.0         htmlwidgets_1.3       TTR_0.23-4           
# rstudioapi_0.10      quantmod_0.4-15       jsonlite_1.6          inline_0.3.15         magrittr_1.5         
# loo_2.1.0            munsell_0.5.0         stringi_1.4.3         yaml_2.2.0            pkgbuild_1.0.3       
# grid_3.6.1           parallel_3.6.1        promises_1.0.1        crayon_1.3.4          lattice_0.20-38      
# ps_1.3.0             pillar_1.4.2          igraph_1.2.4.1        codetools_0.2-16      stats4_3.6.1         
# pkgload_1.0.2        glue_1.3.1            remotes_2.1.0         png_0.1-7             httpuv_1.5.1         
# testthat_2.2.1       gtable_0.3.0          purrr_0.3.2           assertthat_0.2.1      mime_0.7             
# xtable_1.8-4         later_0.8.0           viridisLite_0.3.0     tibble_2.1.3          memoise_1.1.0 


# INSTALL PACKAGES AND DEPENDENCIES

install.packages("devtools", dependencies = TRUE)

install.packages("shiny", dependencies = TRUE)
install.packages("shinyjs", dependencies = TRUE)
install.packages("shinythemes", dependencies = TRUE)
install.packages("shinyWidgets", dependencies = TRUE)
install.packages("shinybusy", dependencies = TRUE)
devtools::install_github("AnalytixWare/ShinySky", dependencies = TRUE)

install.packages("googleAuthR", dependencies = TRUE)
install.packages("googleAnalyticsR", dependencies = TRUE)

install.packages("dygraphs", dependencies = TRUE)
install.packages("ggplot2", dependencies = TRUE)
install.packages("plotly", dependencies = TRUE)
install.packages("d3heatmap", dependencies = TRUE)

install.packages("prophet", dependencies = TRUE)
install.packages("CausalImpact", dependencies = TRUE)
install.packages("xts", dependencies = TRUE)
install.packages("tseries", dependencies = TRUE)
install.packages("zoo", dependencies = TRUE)
devtools::install_github("twitter/AnomalyDetection", dependencies = TRUE)

install.packages("tidyr", dependencies = TRUE)
install.packages("lubridate", dependencies = TRUE)
install.packages("stringr", dependencies = TRUE)
install.packages("dplyr", dependencies = TRUE)
install.packages("data.table", dependencies = TRUE)
install.packages("DT", dependencies = TRUE)

install.packages("rsconnect", dependencies = TRUE)
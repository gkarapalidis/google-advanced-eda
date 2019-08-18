## functions.R

source(file.path("required", "libraries.R"),  local = TRUE)$value

#message("functions.R called from ", getwd())

is.error <- function(x) inherits(x, "try-error")


get_ga_data <- function(profileID, 
                        fetch_metrics, 
                        fetch_dimensions,
                        fetch_filter = ""){
  
  ## Run this locally first, to store the auth token.
  rga.open(where="token.rga")
  
  all_start <-  ga$getFirstDate(profileID)
  start <- today() - options()$rga$daysBackToFetch
  yesterday <- today() -1
  
  message("# Fetching GA data")
  ga_data <- ga$getData(ids = profileID,
                        start.date = start,
                        end.date = yesterday,
                        metrics = fetch_metrics,
                        dimensions = fetch_dimensions,
                        filters = fetch_filter,
                        batch = T)
  
  return(ga_data)
  
}

## Twitter's AnomalyDetection
## https://github.com/twitter/AnomalyDetection
anomalyDetect <- function(data, ...){
  message("Anomaly detection")
  if("date" != names(data)[1]){
    stop("'date' must be in first column of data")
  }
  
  if(ncol(data) > 2){
    warning("More than two columns detected in data, only first that isn't 'date' is used")
  }
  
  data <- data[,1:2]
  
  data$date <- as.POSIXct(data$date)
  data[is.na(data[,2]),2] <- 0
  
  a_result <- AnomalyDetectionTs(data, plot = T, ...)
  
}


aggregate_data <- function(data, agg_period){
  
  if("date" != names(data)[1]){
    stop("'date' must be in first column of data")
  }
  
  if(ncol(data) > 2){
    warning("More than two columns detected in data, only first that isn't 'date' is used")
  }
  
  agg_data <- data[,1:2]
  
  
  ## aggregate data if not agg == date
  if(agg_period %in% c('week', 'month', 'year')){
    old_names <- names(agg_data)
    names(agg_data) <- c("date","metric")
    agg_data <- tbl_df(agg_data)
    date_type_function <- period_function_generator(agg_period, pad=T)
    
    agg_data <-  agg_data %>% 
      mutate(period_type = paste0(year(date),
                                  "_",
                                  date_type_function(date))) %>%
      group_by(period_type) %>%
      dplyr::summarise(date = min(date),
                       metric = sum(metric))
    
    agg_data <- data.frame(agg_data)
    names(agg_data) <- c(agg_period, old_names)
    agg_data$date <- as.Date(agg_data$date)
  } else {
    
  }
  
  agg_data
  
}



## utility to create a time period finder on a date
## outputs a function you use on Date objects
period_function_generator <- function(period, pad=FALSE){
  
  if(!(period %in% c("month", "week", "year", "monthYear"))){
    stop("time_period must be one of 'week', 'month', 'monthYear', or 'year'")
  }
  
  if(period == "month" | period == "monthYear"){
    f <- month
  } else if (period == "week" | period == "weekYear"){
    f <- week
  } else if(period == "year"){
    f <- year
  }
  
  if(pad){
    
    function(x){
      gsub(" ","0", sprintf("%2d",f(x)))
    } 
    
  } else {
    f
  }    
  
}

lag_time <- function(period, amount=1L, data_date = Sys.Date()){
  
  if(period %in% c("month", "monthYear")){
    data_date %m-% months(amount)
  } else if (period == "week"){
    data_date - 7*amount
  } else if(period == "year"){
    data_date %m-% years(amount)
  } 
  
}

calcPeriodChange <- function (data, time_period) {
  
  if("date" != names(data)[1]){
    stop("'date' must be in first column of data")
  }
  
  if(ncol(data) > 2){
    warning("More than two columns detected in data, only first that isn't 'date' is used")
  }
  
  if(!(time_period %in% c("week", "month", "year", "monthYear"))){
    stop("time_period must be one of 'week', 'month', 'monthYear', or 'year'")
  }
  
  period_f <- period_function_generator(time_period)
  
  ## make the period column
  data$period    <- period_f(data$date)
  now_period     <- period_f(today())
  
  lag_one_period <- period_f(lag_time(time_period, 1))
  lag_one_total <- sum(data[data$period == lag_one_period &
                              year(data$date) == year(today()),2], 
                       na.rm=T)
  
  ## what periods to compare
  if(time_period %in% c("week", "month", "year")){
    lag_two_period <- period_f(lag_time(time_period, 2))
    ## calculate % difference for that period
    
    lag_two_total <- sum(data[data$period == lag_two_period &
                                year(data$date) == year(today()),2], 
                         na.rm=T)
    
  } else if(time_period == "monthYear") {
    lag_two_period <- period_f(lag_time(time_period, 13))
    lag_two_total <- sum(data[data$period == lag_two_period &
                                year(data$date) == year(lag_time(time_period, 13)),2], 
                         na.rm=T)
  }
  
  diff_period <- (lag_one_total - lag_two_total) / 
    (lag_one_total + lag_two_total)
}



valueBoxTimeOnTime <- function(data, time_period="month"){
  
  diff_period <- calcPeriodChange(data, time_period)
  
  wentUp <- ifelse(diff_period > 0, TRUE, FALSE)
  
  ## decide what to put in the box
  if(!is.na(wentUp)){
    diff_period <- paste(round(diff_period, 2)*100, "%")
    
    icon_vb <- ifelse(wentUp, "arrow-up", "arrow-down")
    color_vb <- ifelse(wentUp, "olive", "maroon")
  } else { ## period was invalid, default to nothing
    diff_period <- "-"
    icon_vb <- "exclamation"
    color_vb <- "teal"
  }
  
  if(time_period=="monthYear"){
    sub_title_name <- "Last Month vs Same Month Last Year"
  } else {
    sub_title_name <- str_to_title(paste(time_period,"on",time_period))
  }
  
  ## output a shinydashboard valueBox for use in ui.r
  valueBox(
    value = diff_period,
    subtitle = sub_title_name,
    icon = icon(icon_vb),
    color = color_vb
  )
  
  
}
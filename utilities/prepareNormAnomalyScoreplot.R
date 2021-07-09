# Author: Ozan Aygun
# Purpose: given time-series calculates normalized anomaly scores and returns
# a ggplot for presentation, pointing outliers quantified.
# Input: a ts object
require(forecast)
require(ggplot2)
require(tsoutliers)

prepareNormAnomalyScoreplot <- function(x){
    
    yr.flag <- FALSE
    
    outliers.x <- tsoutliers(x)
    rem <- remainder(mstl(x,robust = TRUE)) 
    sd.x <- ifelse(sd(rem) == 0,1,sd(rem))
    
    anomaly.score <- rep(0, length(x))
    anomaly.score[outliers.x$index] <- (x[outliers.x$index] - outliers.x$replacements)/sd.x
    
    if(frequency(x) == 12){
        
        calendar.dates <-  as.POSIXct(as.yearmon(time(x)))
        
    } else if (frequency(x) == 4) {
        
        calendar.dates <-  as.POSIXct(as.yearqtr(time(x)))
        
    } else {
        
        yr <- as.character(time(x))
        calendar.dates <-  as.POSIXct(paste0(yr,"-01-01"))
        yr.flag <- TRUE
    }
   
    
    x.df <- data.frame(calendar.date = calendar.dates,
                       values = as.numeric(x),
                       stringsAsFactors = FALSE)    
    
    gp <- ggplot(x.df,aes(x = calendar.dates, y = values))+
        xlab("Time")+
        geom_line(color = "navy")+
        geom_point(aes(color = anomaly.score , size = abs(anomaly.score)))+
        scale_color_gradient2(high = "blue", low = "red")+
        scale_size_continuous(range = c(0.4, 5))+
        scale_x_datetime(date_labels  = ifelse(yr.flag,"%Y","%m-%Y"),breaks = x.df$calendar.date)+
        theme_bw()+
        theme(axis.text.x = element_text(size = 7, angle = 45),
              panel.grid = element_blank(),
              panel.background = element_rect(fill = "#8394c7"))
    
    return(gp)
    
}
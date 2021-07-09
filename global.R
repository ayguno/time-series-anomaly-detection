library(shiny)
library(shinymaterial)
library(ggplot2)
library(plotly)
library(forecast)
library(fpp)
library(lubridate)
require(kableExtra)
library(shinyWidgets)
require(scales)
require(zoo)

# Source utilities
source("./utilities/prepareSTLplot.R")
source("./utilities/prepareZScoreplot.R")
source("./utilities/prepareNormAnomalyScoreplot.R")


# Default ts data for display
sample.data <- tail(fpp::ausbeer,200)
# Add a few outliers 
#sample.data[24] <- 100
#sample.data[80] <- 150
sample.data[60] <- 600
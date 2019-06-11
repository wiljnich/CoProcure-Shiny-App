library(shiny)
library(jsonlite)
library(dplyr)
library(curl)
dat <- fromJSON("https://cncx06eah4.execute-api.us-east-1.amazonaws.com/production/dashboard")
dat$ts <- as.Date(dat$ts)
dats <- dat[which(dat$category=='search'),]
dats <- dats %>% group_by(ts) %>% summarise(activityID = n())
datu <- dat[which(dat$category=='user'),]
datu <- datu %>% group_by(ts) %>% summarise(activityID = n())
datc <- dat[which(dat$category=='contract'),]
datc <- datc %>% group_by(ts) %>% summarise(activityID = n())

server <- function(input, output) {
  
  output$lineChart <- renderPlot({  
    chartData <- switch(input$radio,
                        "Search" = dats,
                        "User" = datu,
                        "Contract" = datc
    )
    
    chartTitle <- switch(input$radio,
                         "Search" = "Search",
                         "User" = "User",
                         "Contract" = "Contract"
    )
    
    xrange <- range(chartData[[1]])
    yrange <- range(chartData[[2]])
    plot(xrange,yrange,type="n",xlab="",ylab="Total Actions",cex.lab=1.5,
         main=paste("User Actions Over Time - ", chartTitle))
    lines(chartData[[1]], chartData[[2]],col="#2862AB",lwd=3)
  },height = 500, width = 600)
  
}
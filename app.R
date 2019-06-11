## necessary packages for deployment - must have all of these
library(shiny)
library(jsonlite)
library(dplyr)
library(curl)

## data from coprocure.us AWS endpoint
dat <- fromJSON("https://cncx06eah4.execute-api.us-east-1.amazonaws.com/production/dashboard")

## process dates and subset data by category of user activity
dat$ts <- as.Date(dat$ts)
dats <- dat[which(dat$category=='search'),]
dats <- dats %>% group_by(ts) %>% summarise(activityID = n())
datu <- dat[which(dat$category=='user'),]
datu <- datu %>% group_by(ts) %>% summarise(activityID = n())
datc <- dat[which(dat$category=='contract'),]
datc <- datc %>% group_by(ts) %>% summarise(activityID = n())

#ui portion of app
ui <- fluidPage(
  ## img must be stored in a www subfolder
  img(src='coprocure-logo.jpg'),
  titlePanel("CoProcure User Activity"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("radio", label = h3("Select category"),
                   choices = list("Search", "User", "Contract"),selected = "Search")
    ),
    mainPanel(
      plotOutput("lineChart")
    )   
  )      
)
## server portion of app
server <- function(input, output) {
  ## chart data is selected by radio button from subsetted data frames
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

shinyApp(ui = ui, server = server)

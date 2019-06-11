#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
ui <- fluidPage(
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

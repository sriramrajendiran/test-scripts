library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Flix"),
  
  # get input
  sidebarLayout(
    sidebarPanel(
      textInput("search", label = h3("Enter name to get description"), 
                value = "Suriya"),
      submitButton("Search")
    ),
    
    
    
    # Show description
    mainPanel(
      textOutput("distPlot")
    )
  )
))

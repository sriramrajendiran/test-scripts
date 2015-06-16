library(shiny)
library(SPARQL)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
 output$distPlot <- renderText({ endpoint <- "http://dbpedia.org/sparql/"
  
  query <- "PREFIX dbpedia0: <http://dbpedia.org/ontology/>
SELECT ?cat WHERE { <http://dbpedia.org/resource/"
  
  query <- paste(query,input$search,sep="")
  query <- paste(query,"> dbpedia0:abstract ?cat. FILTER (LANG(?cat)='en')}",sep="")
  
  qd <- SPARQL(endpoint,query)
  fd <- qd$results
  gsub("@en","",toString(fd))
 })
  
})

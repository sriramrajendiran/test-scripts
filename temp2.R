library(SPARQL)
library(xlsx)

dat <- read.xlsx("People database (actor).xlsx", sheetName="Sheet1")
endpoint <- "http://live.dbpedia.org/sparql/"

query <- "PREFIX dct: <http://purl.org/dc/terms/>
  SELECT ?person {
    ?person dct:subject <http://dbpedia.org/resource/Category:Actresses_in_Tamil_cinema> .
  }"

qd <- SPARQL(endpoint,query)
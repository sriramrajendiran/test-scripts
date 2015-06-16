library(SPARQL)
library(xlsx)
endpoint <- "http://dbpedia.org/sparql/"
actress <- {}

query1 <- "PREFIX dct: <http://purl.org/dc/terms/> SELECT ?person { ?person dct:subject <http://dbpedia.org/resource/Category:Actresses_in_Tamil_cinema> .}"


query2 <- "PREFIX dct: <http://purl.org/dc/terms/>
  SELECT ?person {
    ?person dct:subject <http://dbpedia.org/resource/Category:21st-century_Indian_actresses> .
  }"

query3 <- "PREFIX dct: <http://purl.org/dc/terms/>
  SELECT ?person {
    ?person dct:subject <http://dbpedia.org/resource/Category:Actresses_in_Telugu_cinema> .
  }"

query4 <- "PREFIX dct: <http://purl.org/dc/terms/>
  SELECT ?person {
    ?person dct:subject <http://dbpedia.org/resource/Category:Male_actors_in_Tamil_cinema> .
  }"


rs1 <- SPARQL(endpoint,query1)
rs2 <- SPARQL(endpoint,query2)
rs3 <- SPARQL(endpoint,query3)
rs4 <- SPARQL(endpoint,query4)

actress <- cbind(rs1$results,rs2$results,rs3$results,rs4$results)
act <- t(actress)

for (i in 1:length(act)){
  act[i] <- gsub("<http://dbpedia.org/resource/","",act[i])
  act[i] <- gsub("@en","",act[i])
  act[i] <- gsub(">","",act[i])
}
##act <- lapply(act, as.character)  ##to change from factor array to char array
v <- as.vector(act) ## to change dataframe into vector

write.table(x=v,file ="Tamil_actress.csv", sep=",",  row.names=FALSE)
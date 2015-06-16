






query <- "PREFIX dbpedia2: <http://dbpedia.org/property/> SELECT ?cat WHERE { <http://dbpedia.org/resource/Ajith_Kumar> dbpedia2:award ?cat.}"

qd <- SPARQL(endpoint,query)
pp <- qd$results
award <- {}
for (i in 1:length(act)){
  temp <- gsub("<http://dbpedia.org/resource/","",pp[i])
  temp <- gsub("@en","",temp)
  temp <- gsub("\"","",temp)
  award <- paste(award,gsub(">","",temp),sep = ",")
  
}

award <- substring(award,2)
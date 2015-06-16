##query <- "PREFIX dct: <http://dbpedia.org/ontology/> SELECT ?person { ?person dct:starring <http://dbpedia.org/resource/Ajith_Kumar> .}"

library(SPARQL)
library(xlsx)

dat <- read.csv("list_of_actors.csv",header = TRUE)
endpoint <- "http://live.dbpedia.org/sparql/"
cine_name <- dat$title
real_name <- dat$Birth.name.other.names

for(i in 1:nrow(dat)) {
  if (!is.na(cine_name[i])) {
    films <- {}
    search <- cine_name[i]
    search <- gsub(" ","_",search)
    query <- "PREFIX dbpedia0: <http://dbpedia.org/property/> SELECT ?cat { ?cat dbpedia0:starring <http://dbpedia.org/resource/"
    query <- paste(query,search,sep="")
    query <- paste(query,">.}",sep="")
    
    qd <- SPARQL(endpoint,query)
    du <- t(qd$results)
    
    if(length(du)==0){
      query <- "PREFIX dbpedia0: <http://dbpedia.org/ontology/> SELECT ?cat { ?cat dbpedia0:starring <http://dbpedia.org/resource/"
      query <- paste(query,search,sep="")
      query <- paste(query,">.}",sep="")
      
      qd <- SPARQL(endpoint,query)
      du <- t(qd$results)
    }
    
    for (j in 1:length(du)){
      temp <- {}
      temp <- gsub("<http://dbpedia.org/resource/","",du[j])
      temp <- gsub("@en","",temp)
      temp <- gsub("\"","",temp)
      films <- paste(films,gsub(">","",temp),sep = ",")
      films <- substring(films,2)
    }
    dat[i,"Filmography"] <- films
  }
}

write.csv(x=dat,file="actors_filmography.csv",na="Na")


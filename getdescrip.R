library(SPARQL)
library(xlsx)

dat <- read.xlsx("People database (actor).xlsx", sheetName="Sheet1")
endpoint <- "http://live.dbpedia.org/sparql/"
cine_name <- dat$Name
real_name <- dat$Birth.name.other.names
du <- {}
for(i in 1:nrow(dat)) {
  if (!is.na(cine_name[i])) {
    search <- cine_name[i]
    search <- gsub(" ","_",search)
    query <- "PREFIX dbpedia0: <http://dbpedia.org/ontology/>
    SELECT ?cat WHERE { <http://dbpedia.org/resource/"
    
    query <- paste(query,search,sep="")
    query <- paste(query,"> dbpedia0:abstract ?cat. FILTER (LANG(?cat)='en')}",sep="")
    
    qd <- SPARQL(endpoint,query)
    du <- qd$results
    du <- gsub("@en","",toString(du))
    dat[i,"Brief.description"] <- du
  }
}

write.csv(x=dat,file="new_people_descrip_live.csv",na="Na")


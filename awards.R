library(SPARQL)
library(xlsx)

dat <- read.xlsx("People database (actor).xlsx", sheetName="Sheet1")
endpoint <- "http://live.dbpedia.org/sparql/"
cine_name <- dat$Name
real_name <- dat$Birth.name.other.names

for(i in 1:nrow(dat)) {
  if (!is.na(cine_name[i])) {
    search <- cine_name[i]
    search <- gsub(" ","_",search)
    query <- "PREFIX dbpedia2: <http://dbpedia.org/property/> 
    SELECT ?cat WHERE { <http://dbpedia.org/resource/"
    
    query <- paste(query,search,sep="")
    query <- paste(query,"> dbpedia2:award ?cat.}",sep="")
    
    qd <- SPARQL(endpoint,query)
    pp <- qd$results
    award <- {}
    for (i in 1:length(pp)){
      temp <- gsub("<http://dbpedia.org/resource/","",pp[i])
      temp <- gsub("@en","",temp)
      temp <- gsub("\"","",temp)
      award <- paste(award,gsub(">","",temp),sep = ",")
      
    }
    award <- substring(award,2)
    dat[i,"Awards.and.recognitions"] <- award
  }
}

write.csv(x=dat,file="new_people_descrip_live.csv",na="Na")


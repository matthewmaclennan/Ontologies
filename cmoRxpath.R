#Scripts in R dealing with the RSC's Chemical Methods Ontology
library(XML)
library(RCurl)
#create a vector of all chemical methods with their synonyms below
#load the ontology into R
CMO.owl<-htmlTreeParse(getURL("http://www.rsc.org/ontologies/CMO/CMO_OWL.owl"),useInternalNode=T)
#obtain the main technique names
xpathApply(CMO.owl,"//class/label")
#obtain the vector of synonyms. The unlisted xpath results contain "\n" characters with multiple spaces, so strsplit() is used
#to clean this up.
CMO_synonyms<-unlist(strsplit(unlist(xpathApply(CMO.owl,"//class/hasexactsynonym",xmlValue)),"\n +"))
#the synonyms "hasexactsynonym" are sibling nodes to the "label" nodes (which are children nodes of "class"), 
#so lapply() to the ancestor node ("class"), then go to the "hasexactsynonym node". Using lapply() will help to assemble the 
#vector for searching.

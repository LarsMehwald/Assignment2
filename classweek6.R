#################################################

# Access web-based data
# In class assignment week 6

# Daniel Salgado Moreno

setwd("~/HSoG/DataAnalysis/GitHub/Assignment2")
library("rio")
URL_PKS_faelle <- "http://www.bka.de/SharedDocs/Downloads/DE/Publikationen/PolizeilicheKriminalstatistik/2014/Zeitreihen/Faelle/tb01__FaelleGrundtabelleAb1987__csv,templateId=raw,property=publicationFile.csv/tb01__FaelleGrundtabelleAb1987__csv.csv"

PKS_faelle <- read.csv(URL_PKS_faelle, sep=";")





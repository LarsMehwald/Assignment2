########################
# Lars and Daniel 
# 21 October 2015
# Working with the PKS data frame 
########################

library("rio")
search()

URL_PKS_faelle <- "http://www.bka.de/SharedDocs/Downloads/DE/Publikationen/PolizeilicheKriminalstatistik/2014/Zeitreihen/Faelle/tb01__FaelleGrundtabelleAb1987__csv,templateId=raw,property=publicationFile.csv/tb01__FaelleGrundtabelleAb1987__csv.csv"
URL_PKS_Kreise <- "http://www.bka.de/SharedDocs/Downloads/DE/Publikationen/PolizeilicheKriminalstatistik/2014/BKATabellen/FaelleLaenderKreiseStaedte/tb01__FaelleGrundtabelleKreise__csv,templateId=raw,property=publicationFile.csv/tb01__FaelleGrundtabelleKreise__csv.csv"

PKS_faelle <- read.csv(URL_PKS_faelle, sep=";")
PKS_Kreise <- read.csv(URL_PKS_Kreise, sep=";")

# Viewing the Data
View(PKS_faelle)
View(PKS_Kreise)

# Finding out the class of object
class(PKS_Kreise)
class(PKS_Kreise$X1)

# Renaming variables 
VarName1 <- PKS_faelle[1,1] # Problem: also selection of level of variable 
VarName1
names(PKS_faelle)[1] <- PKS_faelle[1,1] # Problem persists

# New apptempt to rename, this time manually 
PKS_Kreise[1,]
NameofVariables <- c("Schlüsselzahl der Tat", "Straftat", "Gemeindeschlüssel", "Stadt-/Landkreis", "erfasste Fälle", "HZ", "Versuche - Anzahl", "Versuche - Anteil in %", "mit Schusswaffe gedroht", "mit Schusswaffe geschossen", "aufgeklärte Fälle", "Aufklärungsquote", "Tatverdächtige insgesamt", "Tatverdächtige - männlich", "Tatverdächtige - weiblich", "Nichtdeutsche Tatverdächtige - Anzahl", "Nichtdeutsche Tatverdächtige - Anteil in %")
names(PKS_Kreise) <- NameofVariables 

# Delete the first row (before name of variable)
PKS_Kreise <- PKS_Kreise[-c(1),]

# Delete (for now) unimportant variables
PKS_Kreise <- PKS_Kreise[,-c(1, 4, 6:17)]

# Rearranging data
PKS_Kreise <- PKS_Kreise[c(2,1,3)]

# Reformatting data 
# install.packages("tidyr")
library("tidyr")
search()

# PKS_Kreise_gather <- gather(PKS_Kreise, "Straftat", "erfasste Fälle", "Gemeindeschlüssel")
# Do I need gather or spread? 
# Do I need to reformat the data? 

# Setting the class type to numeric: error
class(PKS_Kreise$"Gemeindeschlüssel") <- numeric # Why is this not working? 

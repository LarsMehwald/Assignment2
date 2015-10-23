########################
# Lars and Daniel 
# 21 October 2015
# Working with the PKS data frame 
########################

# Setting the working directory
getwd()
setwd("D:/Eigene Dokumente/!1 Vorlesungen/!! WS 2015/Introduction to Collaborative Social Science Data Analysis/Assignment2")

# Loading required packages 
library("rio")
library("dplyr")
library("tidyr")
search()

# Scrapping the data
# URL_PKS_faelle <- "http://www.bka.de/SharedDocs/Downloads/DE/Publikationen/PolizeilicheKriminalstatistik/2014/Zeitreihen/Faelle/tb01__FaelleGrundtabelleAb1987__csv,templateId=raw,property=publicationFile.csv/tb01__FaelleGrundtabelleAb1987__csv.csv"
# URL_PKS_Kreise <- "http://www.bka.de/SharedDocs/Downloads/DE/Publikationen/PolizeilicheKriminalstatistik/2014/BKATabellen/FaelleLaenderKreiseStaedte/tb01__FaelleGrundtabelleKreise__csv,templateId=raw,property=publicationFile.csv/tb01__FaelleGrundtabelleKreise__csv.csv"
URL_PKS_Kreise_13_14 <- "http://www.bka.de/SharedDocs/Downloads/DE/Publikationen/PolizeilicheKriminalstatistik/2014/BKATabellen/FaelleLaenderKreiseStaedte/tb01__FaelleGrundtabelleKreiseFallentwicklung__csv,templateId=raw,property=publicationFile.csv/tb01__FaelleGrundtabelleKreiseFallentwicklung__csv.csv"

# PKS_faelle <- read.csv(URL_PKS_faelle, sep=";")
# PKS_Kreise <- read.csv(URL_PKS_Kreise, sep=";")
PKS_Kreise_13_14 <- read.csv(URL_PKS_Kreise_13_14, sep=";")

# rm(URL_PKS_faelle)
# rm(URL_PKS_Kreise)
rm(URL_PKS_Kreise_13_14)

########################
# Kreise 2014
########################

# Viewing the Data
View(PKS_Kreise)

# Finding out the class of object
class(PKS_Kreise)
class(PKS_Kreise$X1)

# Renaming variables 
VarName1 <- PKS_Kreise[1,1] # Problem: also selection of level of variable 
VarName1
names(PKS_Kreise)[1] <- PKS_Kreise[1,1] # Problem persists

# New apptempt to rename, this time manually 
PKS_Kreise_13_14[1,]
NameofVariables <- c("Schlüsselzahl der Tat", "Straftat", "Gemeindeschlüssel", "Stadt-/Landkreis", "erfasste Fälle", "HZ", "Versuche - Anzahl", "Versuche - Anteil in %", "mit Schusswaffe gedroht", "mit Schusswaffe geschossen", "aufgeklärte Fälle", "Aufklärungsquote", "Tatverdächtige insgesamt", "Tatverdächtige - männlich", "Tatverdächtige - weiblich", "Nichtdeutsche Tatverdächtige - Anzahl", "Nichtdeutsche Tatverdächtige - Anteil in %")
names(PKS_Kreise) <- NameofVariables 
rm(NameofVariables)

# Delete the first row (before name of variable)
PKS_Kreise <- PKS_Kreise[-c(1),]

# Delete (for now) unimportant variables
PKS_Kreise <- PKS_Kreise[,-c(1, 4, 6:17)]

# Rearranging data
PKS_Kreise <- PKS_Kreise[c(2,1,3)]

# Reformatting data 

# Do I need gather or spread? 
# Do I need to reformat the data? 

# Setting the class type to numeric: error
# class(PKS_Kreise$"Gemeindeschlüssel") <- numeric # Why is this not working? 

########################
# Kreise 2013 2014
########################

# Viewing the Data
View(PKS_Kreise_13_14)

# Delete (for now) unimportant variables
PKS_Kreise_13_14 <- PKS_Kreise_13_14[,-c(1, 4, 7:15)]

# Renaming manually 
PKS_Kreise_13_14[1,]
NameofVariables <- c("Straftat", "Gemeindeschlüssel", "2014 - erfasste Fälle", "2013 - erfasste Fälle")
names(PKS_Kreise_13_14) <- NameofVariables 
rm(NameofVariables)

# Delete the first row (before name of variable)
PKS_Kreise_13_14 <- PKS_Kreise_13_14[-c(1),]

# Rearranging data
PKS_Kreise_13_14 <- PKS_Kreise_13_14[c(2,1,4,3)]

# Splitting the data
PKS_Kreise_13_14[1,]
PKS_Kreise_13 <- PKS_Kreise_13_14[,c(1,2,3)]
PKS_Kreise_14 <- PKS_Kreise_13_14[,c(1,2,4)]
rm(PKS_Kreise_13_14)

# Spread data
PKS_Kreise_13_spread <- spread(PKS_Kreise_13, "Straftat", "2013 - erfasste Fälle")
PKS_Kreise_14_spread <- spread(PKS_Kreise_14, "Straftat", "2014 - erfasste Fälle")
rm(PKS_Kreise_13)
rm(PKS_Kreise_14)

# Adding year variable 
year13 <- 2013
PKS_Kreise_13_spread <- cbind(PKS_Kreise_13_spread, year13)
rm(year13)

year14 <- 2014
PKS_Kreise_14_spread <- cbind(PKS_Kreise_14_spread, year14)
rm(year14)

# Removing variables (crimes) not relevant to analysis
PKS_Kreise_13_spread <- PKS_Kreise_13_spread[,-c(3,4,5,6,11,12,13,14,15,16,17,18)]
PKS_Kreise_14_spread <- PKS_Kreise_14_spread[,-c(3,4,5,6,11,12,13,14,15,16,17,18)]

# Translation of variable names into English
names(PKS_Kreise_13_spread)
NameofVariables <- c("district", "bodily harm", "dangerous bodily harm", "violent crime", "murder and manslaughter", "robbery", "year")
names(PKS_Kreise_13_spread) <- NameofVariables 
names(PKS_Kreise_14_spread) <- NameofVariables 
rm(NameofVariables)

# Changing the class of variables
class(PKS_Kreise_13_spread$district) <- "numeric"
class(PKS_Kreise_13_spread$`bodily harm`) <- "numeric"
class(PKS_Kreise_13_spread$`dangerous bodily harm`) <- "numeric"
class(PKS_Kreise_13_spread$`violent crime`) <- "numeric"
class(PKS_Kreise_13_spread$`murder and manslaughter`) <- "numeric"
class(PKS_Kreise_13_spread$robbery) <- "numeric"
class(PKS_Kreise_13_spread$year) <- "numeric"

class(PKS_Kreise_14_spread$district) <- "numeric"
class(PKS_Kreise_14_spread$`bodily harm`) <- "numeric"
class(PKS_Kreise_14_spread$`dangerous bodily harm`) <- "numeric"
class(PKS_Kreise_14_spread$`violent crime`) <- "numeric"
class(PKS_Kreise_14_spread$`murder and manslaughter`) <- "numeric"
class(PKS_Kreise_14_spread$robbery) <- "numeric"
class(PKS_Kreise_14_spread$year) <- "numeric"

# Summarising data
title1 <- "These are the summary statistics for the year 2013"
print(title1)
summary(PKS_Kreise_13_spread[,-c(1,7)])
rm(title1)

title2 <- "These are the summary statistics for the year 2014"
print(title2)
summary(PKS_Kreise_14_spread[,-c(1,7)])
rm(title2)

# Saving the data 
write.csv(PKS_Kreise_13_spread, file = "PKS_Kreise_13_spread.csv", append = "TRUE")
write.csv(PKS_Kreise_14_spread, file = "PKS_Kreise_14_spread.csv", append = "TRUE")

# Removing everything from workspace
rm(list=ls()) 

#week 3 data wrangling excercises
#So these are week 3 data wrangling excercises. 
#The data is from: https://archive.ics.uci.edu/ml/datasets/Student+Performance
#Paulo Cortez, University of Minho, GuimarÃ£es, Portugal, http://www3.dsi.uminho.pt/pcortez
#"This data approach student achievement in secondary education of two Portuquese schools."
#Aino Peura

#Dear peer-reviewer, I have a long history with R and I tend to do things a 
#bit differentely than datacamp, hope this does not create extra work for you!

#libraries
library(readr)
library(tidyverse)

#Lets find out that the directory is correct and contains correct files

getwd()
list.files()

#Import datasets
mat<-read_delim("student-mat.csv", 
                ";", escape_double = FALSE, trim_ws = TRUE)

por<- read_delim("student-por.csv", 
                 ";", escape_double = FALSE, trim_ws = TRUE)

str(mat)

#We have 395 students, 33 characteristics from each. 

str(por)
#Here we have 649 students, 33 characteristics from each. 
#I don't get why to run command dim, because it just shows same things than str, 
#I mean, dimensions are also printed on str first row
#And we can see them from environment page too. 


#I think that the original solution presented in course webpage was somehow too long
#Here is my five line solution
#Hope I don't loose any points because I am not copying this from datacamp

#Lets create colnames - vector
columnit<-colnames(mat)
#Remove colnames we don't want to use for merge
columnit<- subset(columnit, is.element(columnit, c("failures", "paid", "absences", "G1", "G2", "G3"))==F)
#Observe did we get it right - oh yes
columnit

#Lets create a variable for both datasets that has all the info from variables that will be used for merge
mat$id<-apply(mat[,columnit], 1, paste, collapse = "-")
por$id<- apply(por[,columnit], 1, paste, collapse = "-")

#Lets merge datafiles
all<- merge(mat, por, by.x="id", by.y = "id")

#lets then remove duplicated columns that were only used for merge

keep<-c("failures", "paid", "absences", "G1", "G2", "G3")

keep<- c(paste(keep, ".x", sep = ""),paste(keep, ".y", sep = "") )
allthesame<- all[,c(is.element(colnames(all), keep)==F)]
#Lets then keep only the columns from one dataframe
allthesame<- allthesame[,str_detect(colnames(allthesame), ".x")==T]
colnames(allthesame)<- str_remove(colnames(allthesame), ".x")
#the sex column has not been remover properly
colnames(allthesame)[2]<- "sex"
allthesame<- allthesame[,1:27]

#lets then move to the columns that are not identical
#lets create a vector "keepcolums" that has names of those columns

#In the following code I will do following things:
#If my columns are identical, I will keep in the final dataframe only one of them
#if they differ and are numeric, I will calculate the mean
#if they differ and are non-numeric, I will keep both of them, because it would be meaningless to count anything

keepcolumns<- keep
for(i in 1:6){
  colname<- sapply(strsplit(keepcolumns[i], split= ".", fixed=T), "[[", 1)
  print(colname)
  if(identical(all[,keepcolumns[i]],   all[,paste(sapply(strsplit(keepcolumns[i], split= ".", fixed=T), "[[", 1), ".y", sep="")])==F){
    a<-cbind.data.frame(all[,keepcolumns[i]],
                        all[,paste(sapply(strsplit(keepcolumns[i],
                                                   split= ".", fixed=T),
                                          "[[", 1), ".y", sep="")])
    if(is.numeric(a[,1])==T & is.numeric(a[,2])==T){
      a2<- (a$`all[, keepcolumns[i]]`+a$`all[, paste(sapply(strsplit(keepcolumns[i], split = ".", `)/2
    }else{
      a2<- a
      colname<- c(paste(colname, "x"), paste(colname, "y"))
    }
  }else{
    a2<- all[,keepcolumns[i]]
  }
  if(i==1){
    all2<- as.data.frame(a2)
    colnames(all2)<- c(colname)
  }else{
    colname<- c(colnames(all2), colname)
    all2<- cbind.data.frame(all2, a2)
    colnames(all2)<-colname
  }
} 

#lets create the final dataframe with all the columns
Joineddata<- cbind.data.frame(allthesame, all2, all[,c(is.element(colnames(all), keep)==T)])

#and lets create alcohol columns
Joineddata$alc_use<- (Joineddata$Walc+Joineddata$Dalc)/2

Joineddata$high_use<- ifelse(Joineddata$alc_use>2, "high", "low")

#we have 370 students and 48 variables. 


write.csv(Joineddata, "data/Joineddata.csv")

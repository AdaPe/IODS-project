#Data wrangling part
#Aino Peura

#Libraries used in this code
library("tidyverse")

#In this excercise, the human data originating from United Nations is goingo to be used. 

humandata<- read.table(url("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt"), sep = ",", header = T)

summary(humandata)

#The dataframe has 195 countries and 19 parameters from them. It contains several GNI and GII-bariables and also variables about human education level and maternity status. 


#Lets make GNI numeric, first we need to replace , with . so R can see they are numbers. 

humandata$GNI<- str_replace(humandata$GNI, ",", ".")
humandata$GNI<- as.numeric(humandata$GNI)


#Lets exclude unneeded variables such as. 

human2<- humandata[,c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")] 

#Remove all rows with missing values

human3<-na.omit(human2)

#Lets remove the observations that relate to regions instead of countries

 unique(human3$Country)
 
 #We can see that the regions are in the end of our data, so we will keep rows 1:155
 
 human4<- human3[1:155,]
 unique(human4$Country)

#ALL CORRECT
#Then, lets make countries as row-names and remove the old countries column
 
 rownames(human4)<- human4$Country
 human4<-human4[,2:9]

#Then, lets save the data
 
 write.csv(human4, "human.csv")

 #The data has 155 rows and 8 columns 
  
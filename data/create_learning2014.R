#Aino Peura 14.11.2021. 
#This file contains my week two excercises, welcome!

#Libraries used for this excercise
library(readr)


#reading the file
JYTOPKYS3_data <- read_delim("~/JYTOPKYS3-data.txt", 
                             +     "\t", escape_double = FALSE, trim_ws = TRUE)

#This data has 183 rows and 60 columns, 
colnames(JYTOPKYS3_data)
summary(JYTOPKYS3_data)
#columns 1:59 are numeric, only column with title gender is character. 
#Columns 1:56 are numeric and seem to have minimal value 1 and maximal 5
#However the distribution for each column is different
#Because they have differing medians and means

#I would say (because the age and gender columns), that rows are people
#And columns are measurements from those
#So we have a data from some study with 183 participitants
#The average age is 25.58 years, maximal age is 55 and minimal 17. 
table(JYTOPKYS3_data$gender)
#There are 122 Females and 61 males in this study

#Lets "protect" the dataset and save the data as variable "data"
data<- JYTOPKYS3_data

colnames(data)
#First, lets create a new variable called Deep
#According to the file, deep-variable is a sum of variables:
#d_sm+d_ri+d_ue = deep
#d_sm is a sum of D03 + D11 + D19 + D27
#d_ri is a sum of D07 + D14 + D22 + D30
#d_ue is a sum of D06 + D15 + D23 + D31
#Therefore, deep is a sum of all of those

#Lets attach data as default so there will be less writing
attach(data)

data$deep<- (D03 + D11 + D19 +D27 + D07 + D14 + D22 + D30 + D06 + D15 + D23 + D31)

#Stra-column is creted by following calculations: 
#stra = st_os + st_tm
#stra = ST01 + ST09 + ST17 + St25 + ST04 + ST12 + ST20 + ST28
data$stra<- ST01 + ST09 + ST17 + ST25 + ST04 + ST12 + ST20 + ST28

#Surf-column is created by following calculations: 
#Surf = su_lp + su_um + su_sb
#surf = SU02 + SU10 + SU18 + SU26 + SU05 + SU13 + SU21 + SU289 + SU08+ SU16 + SU24 + SU32
data$surf<- SU02 + SU10 + SU18 + SU26 + SU05 + SU13 + SU21 + SU29 + SU08+ SU16 + SU24 + SU32

#lets see if everything went well
summary(data)
  
#And now, lets create the second level data-frame with only the variables we want
data2<- data[, c("gender", "Age", "Attitude", "deep", "stra", "surf","Points")] 

#Allright, now I think I should divide all the exam variables by the amount of points summed
data2$deep<- data$deep/12
data2$stra<- data2$stra/9
data2$surf<- data2$surf/12

#Lets exclude cases with Points == 0

data2<- subset(data2, Points !=0)

head(data2)
str(data2)
#Setting working directory
setwd("C:/Users/Aurora/Documents/IODS-project")

#saving the document
write.csv(data2, "data/learning2014.csv")






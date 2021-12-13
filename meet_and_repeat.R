#AP
#Week 6

#Data wrangling
#Libraries
library(dplyr)
library(tidyverse)

#Lets download the data
BPRS<- read.table(url("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt"), header = T)
RATS<- read.table(url("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt"))

summary(BPRS)
summary(RATS)
colnames(BPRS)

#Allright, so in BPRS-dataset we have 11 variables: 
#"treatment" either 1 or 2
#"subject"= test subjects, ranging from 1 to 20
#"week0"-8 some response throught the weeks

#Rats-dataset has following variables: 
#ID= probably the id of the rat
#Group = same as treatment probably
#WD probably weeks 1 to 64¨

# Lets the convert all of the categorical variables into factors: 

BPRS$treatment<- as.factor(BPRS$treatment)
BPRS$subject<- as.factor(BPRS$subject)

RATS$ID<- as.factor(RATS$ID)
RATS$Group <- as.factor(RATS$Group)

#All good. 

#Lets first make BPRS into a long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
#Lets include only the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(BPRSL$weeks, 5, 5)))
#Lets remove weeks-column
BPRSL$weeks<- NULL
#Then, lets do the same for RATS
RATSL <-  RATS %>% gather(key = Time, value = RATS, -ID, -Group)
#Then, lets create the time variable
RATSL<- RATSL %>% mutate(Time = as.integer(substr(RATSL$Time, 3, 4)))

write.csv(RATSL, "RATSL.csv")

write.csv(BPRSL, "BPRSL.csv")
#So, the idea of longitudinal data is that we have minimal number of columns and more rows. Instead of being visually easily 
#gatherable, longitudinal data is easier for analysis. It is being used when we have for example a matrix of values from 
#96-cell well plate and we need to analyse and plot those. I am not certain how mI am supposed to explain this, because as
#biologist I  almost always transform data into a longitudinal form. 

summary(RATSL)
summary(BPRSL)
#in the rats we have 4 columns now: 
#The ID of the rat, the group it belongs to, measuring time and value
#In the BPRSL-dataframe we have now 4 columns, Treatment, subject, week and value

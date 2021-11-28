#Aino Peura
#Data wrangling excercises

#Lets read the data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd)
str(gii)
#hd-dataset has 195 rows and 8 variables
#gii-dataset has 195 rows and 10 variables

#Summaries of variables
summary(hd)
summary(gii)

colnames(gii)

#"GII.Rank" -> GIIR     
#"Country-> stays same
#"Gender.Inequality.Index..GII." -> GII
#"Maternal.Mortality.Ratio" -> MMR                
#"Adolescent.Birth.Rate"ADBR            
#"Percent.Representation.in.Parliament" -> PercentRepParl
#"Population.with.Secondary.Education..Female."->"SecondEF"
#"Population.with.Secondary.Education..Male."  -> "SecondEM"
#"Labour.Force.Participation.Rate..Female."    ->"LabourFPRF"
#"Labour.Force.Participation.Rate..Male." -> "LabourFBRM"

colnames(gii)<- c("GIIR","Country", "GII", "MMR", "ADBR", "PercentRepParl", "SecondEF", "SecondEM", "LabourFPRF", "LabourFBRM" )

colnames(hd)

#"HDI.Rank" -> "HDIR"
#"Country" -> stays same      
#"Human.Development.Index..HDI." -> HDI   
#"Life.Expectancy.at.Birth"   -> LEAB            
#"Expected.Years.of.Education"   -> EYE         
#"Mean.Years.of.Education"       -> MEY        
#"Gross.National.Income..GNI..per.Capita" .> GNIPC
#"GNI.per.Capita.Rank.Minus.HDI.Rank" -> GNIPCmHDI
colnames(hdi)<- c("HDIR", "Country", "HDI", "LEAB", "EYE", "MEY", "GNIPC", "GNIPCmHDI")


#mutations
gii<- gii %>%
      mutate(gii, edur=SecondEF/SecondEM)
gii<- gii %>%
  mutate(gii, laborR=LabourFPRF/LabourFBRM)

#Merge (join-command)
human<- merge(gii, hd, by= "Country", all =F)

#Lets save the data
write.csv(human, "Human.csv")

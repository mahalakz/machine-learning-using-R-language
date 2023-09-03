#Reading data set 
#install.packages("readxl")
library(readxl)
df=read_excel("C:/Study Materials/DataSets/adult_salary_dataset.xlsx")

str(df)
df$Workclass=as.factor(df$Workclass)
df$occupation=as.factor(df$occupation)
df$sex=as.factor(df$sex)
df$relationship=as.factor(df$relationship)
df$race=as.factor(df$race)
df$`native country`=as.factor(df$`native country`)
df$`salary excedded`=as.factor(df$`salary excedded`)
df$education=as.factor(df$education)
df$status=as.factor(df$status)

#Imputing Missing values
anyNA(df)
anyNA(df$Age)
colSums(is.na(df))
#install.packages("imputeTS")
library(imputeTS)
new=na_mean(df)
anyNA(new)

View(new)

#create dummy values
#install.packages("fastDummies")
library(fastDummies)
Workclass=dummy_cols(new$Workclass)[-c(1,2)]
education=dummy_cols(new$education)[-c(1,2)]
status=dummy_cols(new$status)[-c(1,2)]
occupation=dummy_cols(new$occupation)[-c(1,2)]
sex=dummy_cols(new$sex)[-c(1,2)]
relationship=dummy_cols(new$relationship)[-c(1,2)]
race=dummy_cols(new$race)[-c(1,2)]
native_country=dummy_cols(new$`native country`)[-c(1,2)]

final=cbind(Workclass,education,status,occupation,sex,relationship,race,native_country,new$Age,new$fnlwgt,new$eduction_no,new$capital_gain,new$capital_loss,new$hoursperweek,new$`salary excedded`)
#View(final)
colnames(final)[101]='salary'

#Now my data is require to scale. Normalizing it.
final[,95:100]=scale(final[,95:100])

#If required we can scale our data also

#splitting   : 80:20, 75:25, 60:40   
#first we are making the shuffling of the data.
samp=sample(1:nrow(final),20000)
train=final[samp,]           
test=final[-samp,]

#data preprocessing is completed.



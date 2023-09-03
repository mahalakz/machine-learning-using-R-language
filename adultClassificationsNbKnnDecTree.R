#Reading data set 
#install.packages("readxl")
library(readxl)
df=read_excel("D:/Artificial Intelligence Batch/adult_salary_dataset.xlsx")

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

attach(train)
#Decision tree
library(C50)
dt=C5.0(salary~.,data=train)

dt_pred=predict(dt,test) #here the examination is going on in simple words.
dt_acc=mean(dt_pred==test$salary)
dt_acc


#support vector machine
library(e1071)
svm_model=svm(salary~.,data = train,kernel="linear",cost=10,scale=FALSE)
plot(svm_model,train)
svm_pred=predict(svm_model,test)
svm_acc=mean(svm_pred==test$salary)
svm_acc

#naive bayes
library(e1071)
nb_model=naiveBayes(salary~.,data = train)
nb_pred=predict(nb_model,test)

#evaluate your answer we have to compare the actual test output with predicted output.
nb_acc=mean(nb_pred==test$salary)
nb_acc


#expending our result
cm=table(nb_pred==test$salary)

#analyzing the values separately for incorrect and correct matches.
cm=table(nb_pred,test$salary)


sala=final$salary
salaList=as.vector.factor(sala)
for(i in 1:length(salaList)){
  if(salaList[i]=='<=50K'){
    salaList[i]=0
  } else{
    salaList[i]=1
  }
}


for(i in 1:length(salaList)){
  salaList[i]=as.numeric(salaList[i])
}

finalknn=final[-101]

finalwithSala=cbind(finalknn,salaList)

samp=sample(1:nrow(finalwithSala),20000)
trainknn=finalwithSala[samp,]           
testknn=finalwithSala[-samp,]


#KNN algorithm
#install.packages("class")
library(class)
prc_test_pred <- knn(train = trainknn, test = testknn,cl = trainknn$salaList, k=11)
knn_acc=mean(prc_test_pred==testknn$salaList)
knn_acc



df=read.csv("D:/desktop/R programs/Life Expectancy Data.csv")
View(df)

#preprocessing
df$Country=as.factor(df$Country)
df$Status=as.factor(df$Status)
#find &fill missing values
colSums(is.na(df))

library(imputeTS)
df=na_mean(df)
anyNA(df)

#shuffling
shuffle=sample(1:nrow(df))
df=df[shuffle,]
#Regression model
attach(df)
model=lm(Life.expectancy~.,data=df)
summary(model)
pred=predict(model,df,interval = 'predict')
pred

#for regression finding the accuracy is not possible in the same way as we have done in classification algo
#Evaluation
a=c(1:50)
plot(a,Life.expectancy[a],type='l')
plot(a,pred[a,1],type='l')


#rmse
sqrt(mean(((pred- Life.expectancy)**2)))

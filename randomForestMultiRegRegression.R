library(randomForest)
require(caTools)
library(readxl)

multiReg=read_excel("D:\\desktop\\AI Training Content\\multireg.xlsx")
head(multiReg)

shuffle_index <- sample(1:nrow(multiReg))
head(shuffle_index)

multiReg <- multiReg[shuffle_index, ]
head(multiReg)

sample = sample.split(multiReg$Year, SplitRatio = .75)
train = subset(multiReg, sample == TRUE)
test  = subset(multiReg, sample == FALSE)
dim(train)
dim(test)

rf <- randomForest(Stock_Index_Price ~ .,data=train)

predctres = predict(rf, newdata=test[-5])


#testing and evaluation of model is quite different here.
#visualization
a=c(1:6)
plot(a,predctres)
lines(a,predctres)
plot(a,test$Stock_Index_Price)
lines(a,test$Stock_Index_Price)

#rmse (root mean square error)
sqrt(mean(((predctres- test$Stock_Index_Price)**2)))



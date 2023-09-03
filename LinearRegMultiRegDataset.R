set.seed(678)
library(readxl)
multiReg=read_excel("D:/desktop/AI Training Content/multireg.xlsx")
head(multiReg)

shuffle_index <- sample(1:nrow(multiReg))
head(shuffle_index)

multiReg <- multiReg[shuffle_index, ]
head(multiReg)

#applying linear regression on regression problem.
model=lm(multiReg$Stock_Index_Price~multiReg$Year+multiReg$Month+multiReg$Interest_Rate+multiReg$Unemployment_Rate)


predctres=predict(model,newdata = multiReg,interval="predict")

predctres1=predict(model,new)


#testing and evaluation of model is quite different here.
#visualization
a=c(1:24)
plot(a,predctres[,1])
lines(a,predctres[,1])
plot(a,multiReg$Stock_Index_Price)
lines(a,multiReg$Stock_Index_Price)

#rmse (root mean square error)
sqrt(mean(((predctres- multiReg$Stock_Index_Price)**2)))



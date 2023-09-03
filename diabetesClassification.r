#install.packages("magrittr") # only needed the first time you use it
#install.packages("dplyr") 
set.seed(678)
path <- 'D:/desktop/R programs/diabetes.csv'
diabetes <-read.csv(path)
head(diabetes)

#shuffling dataset to make entries up down so all combination will cover
shuffle_index <- sample(1:nrow(diabetes))
head(shuffle_index)

#shuffling the data
diabetes <- diabetes[shuffle_index, ]
head(diabetes)

#remove null entries from data
library(magrittr)
library(dplyr)

#data splitting into training and testing set.
data(diabetes)

## 75% of the sample size
smp_size <- floor(0.75 * nrow(diabetes))

## set the seed to make your partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(diabetes)), size = smp_size)

train <- diabetes[train_ind, ]
test <- diabetes[-train_ind, ]

train$Outcome<-as.factor(train$Outcome)

#install.packages("class")
#install.packages('e1071', dependencies=TRUE)
library(class)
predicted<-knn(train = train, test = test,cl = train$Outcome, k=11)
library(caret)
pred=as.integer(as.character(predicted))
actual=test$Outcome
acc=confusionMatrix(factor(pred, levels = 1:192),factor(actual, levels = 1:192))

nb_acc=mean(pred==actual)
nb_acc

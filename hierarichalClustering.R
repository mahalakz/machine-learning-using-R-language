set.seed(678)
path <- 'C:/Users/Admin/Desktop/R programs/diabetes.csv'
diabetes <-read.csv(path)
head(diabetes)

#shuffling dataset to make entries up down so all combination will cover
shuffle_index <- sample(1:nrow(diabetes))
head(shuffle_index)

#shuffling the data
diabetes <- diabetes[shuffle_index, ]
head(diabetes)


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
#str()

library(C50)
?C5.0
trainres<-C5.0(train[],train$Outcome,data=train)




















#install.packages("ggplot2")
library(ggplot2)
#plot it to show the results
ggplot(diabetes, aes(Pregnancies,Glucose)) + 
  geom_point(alpha = 0.4, size = 3.5) + geom_point(col = clusterCut) + 
  scale_color_manual(values = c('black', 'red', 'green'))

#by complete linkage
clusters <- hclust(dist(diabetes[, 1:8]))
plot(clusters)
#to check for relevant cluster cut the tree
clusterCut <- cutree(clusters, 2)

#compare it with original outcome
table(clusterCut, diabetes$Outcome)

#plot it to show the results
ggplot(diabetes, aes(Petal.Length, Petal.Width, color = diabetes$Outcome)) + 
  geom_point(alpha = 0.4, size = 3.5) + geom_point(col = clusterCut) + 
  scale_color_manual(values = c('black', 'red', 'green'))

#by average linkage method
clusters <- hclust(dist(diabetes[, 1:2]), method = 'average')
plot(clusters)



clusters <- hclust(dist(iris[, 3:4]))
plot(clusters)



clusterCut <- cutree(clusters, 3)

table(clusterCut, iris$Species)


clusters <- hclust(dist(iris[, 3:4]), method = 'average')
plot(clusters)

clusterCut <- cutree(clusters, 3)
table(clusterCut, diabetes$Outcome)


#plot it to show the results
ggplot(diabetes, aes(Petal.Length, Petal.Width, color = diabetes$Outcome)) + 
  geom_point(alpha = 0.4, size = 3.5) + geom_point(col = clusterCut) + 
  scale_color_manual(values = c('black', 'red', 'green'))


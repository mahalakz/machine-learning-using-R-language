library(datasets)
head(iris)
#actual clusters
library(ggplot2)
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()

#k means clusters
set.seed(20)
irisCluster <- kmeans(iris[, 3:4], 4, nstart = 20)
irisCluster
table(irisCluster$cluster, iris$Species)
irisCluster$cluster <- as.factor(irisCluster$cluster)
ggplot(iris, aes(Petal.Length, Petal.Width, color = irisCluster$cluster)) + geom_point()


#now you have target now you can apply supervised learning to find some solutions.

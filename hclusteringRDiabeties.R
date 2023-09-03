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

#by complete linkage
clusters <- hclust(dist(diabetes[, 1:8]))
plot(clusters)
#to check for relevant cluster cut the tree
clusterCut <- cutree(clusters, 3)

#compare it with original outcome using confusion matrix
table(clusterCut, diabetes$Outcome)

#by average linkage method
clusters <- hclust(dist(diabetes[, 1:2]), method = 'average')
plot(clusters)




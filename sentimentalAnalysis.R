#install.packages("syuzhet")
#install.packahes("lubridate")

library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)
library(tm)

apple <- Corpus(VectorSource(text))
tweets <- iconv(apple)


s <- get_nrc_sentiment(tweets)
head(s)

get_nrc_sentiment("ugly")

barplot(colSums(s),
        las = 2,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Sentiment Scores Tweets')


#Google ratings: sentiments through paragraph/ count positive/ negative.
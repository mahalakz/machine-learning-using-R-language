library(httr)
library(rvest)
FIRST<-"https://www.flipkart.com/google-home/product-reviews/"
PID<-"itmf3xz9aa6n6urf?pid=ATNF3HF8RHDVTBHM"
URL<-paste0(FIRST, PID)
web<-GET(URL)
web_body <- read_html(web)

#Name of user
raters_names_nodes <- html_nodes(web_body, xpath=".//*[@class='_2sc7ZR _2V5EHH']") 
raters_names <- html_text(raters_names_nodes)

#Dates of ratings
ratings_dates_nodes <- html_nodes(web_body, xpath=".//*[@class='_2sc7ZR']")
ratings_dates <- html_text(ratings_dates_nodes)

#Rating given by user
rating_nodes <- html_nodes(web_body, xpath=".//*[@class='_3LWZlK _1BLPMq']")
ratings <- html_text(rating_nodes)

#link of rating page
raters_link_nodes <- html_nodes(web_body, xpath=".//nav[@class='yFHi8N']//a") 
raters_links <- html_attr(raters_link_nodes,  name = "href")

#rater's place
raters_place_nodes <- html_nodes(web_body, xpath=".//*[@class='_2mcZGG']") 
raters_place <- html_text(raters_place_nodes)

rating_tab <- data.frame(rating = ratings,
                         name = raters_names,
                         rater = raters_links,
                         date = ratings_dates,
                         place = raters_place)
head(rating_tab)
df=rating_tab

# write extracted data to excel
library(writexl)
write_xlsx(df,"D:/15 day of R programming/Data/retreving flipkart data.xlsx",col_names = TRUE)
library(readxl)
Flip=read_xlsx("D:/15 day of R programming/Data/retreving flipkart data.xlsx")
View(Flip)
library(ggplot2)
options(scipen=999)
# 1) which is the highest rating among 1,2,3,4,5
M1=ggplot(Flip, aes(x=ratings) ) +geom_bar()+ geom_bar(aes(fill=ratings))+labs(title="rating given by user")
plot(M1) #from the plot we can say that most of the user give 5 star rating to this product. 

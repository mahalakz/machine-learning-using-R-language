install.packages(c("httr", "rvest"))

# Importing packages
library(httr)
library(rvest)

BASE_URL <- "https://www.amazon.com/product-reviews/"
PRODUCT_ID <- 1453716548

URL <- paste0(BASE_URL, PRODUCT_ID)

# fetch the website via a HTTP GET request
resp <- GET(URL)

# parse the content of the response (the html code)
resp_body <- read_html(resp) # or, alternatively: resp_body <- content(resp)


# extract the data of interest
# a) dates of ratings
ratings_dates_nodes <- html_nodes(resp_body, xpath=".//*[@data-hook='review-date']")
ratings_dates <- html_text(ratings_dates_nodes)
# b) ratings
rating_nodes <- html_nodes(resp_body, xpath=".//*[@data-hook='review-star-rating']/span")
ratings <- html_text(rating_nodes)
# c) User who gave Ratings
raters_names_nodes <- html_nodes(resp_body, xpath=".//*[@class='a-profile-name']")[-1:-2] 
raters_names <- html_text(raters_names_nodes)
# d) links to raters' profiles (this can also serve as unique rater-ids)
raters_link_nodes <- html_nodes(resp_body, xpath=".//a[@class='a-profile']")[-1:-2] 
raters_links <- html_attr(raters_link_nodes,  name = "href")


# Arrange the extracted data in a data frame
rating_tab <- data.frame(rating = ratings,
                         name = raters_names,
                         rater = raters_links,
                         date = ratings_dates)

head(rating_tab)

# write extracted data to csv
write.csv(rating_tab, file="D:/desktop/Content DS/reviewDataWebMining.csv", row.names = FALSE)

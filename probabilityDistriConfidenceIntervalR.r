#Measure of Central Tendency

a=c(12,34,45,56,3,4,23,56,67,8,565,34,1,2,3,34,45,5,55)
mean(a)
median(a)

################################################Mode Method 1##################################
# Create the function.
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# Create the vector with numbers.
v <- c(2,1,2,3,1,2,3,4,1,5,5,3,2,3)

# Calculate the mode using the user function.
result <- getmode(v)
print(result)

# Create the vector with characters.
charv <- c("o","it","the","it","it")

# Calculate the mode using the user function.
result <- getmode(charv)
print(result)

################################################Mode Method 2####################################
mode = function(){
  return(sort(-table(charv))[1])
}
mode()



#Measure of Dispersion
sd(a)
var(a)


#Inferntial Statistics

#Sampling 

sample(a,5) #Simple Random sampling

#Stratified (Selecting 10 people from each country country)

data <- data.frame(Level = rep(c("India", "China", "Japan", "America"), each=10),
                   Score = rnorm(400, mean=45, sd=2.2))


#systematic sampling (Placing data systematically and then choosing value randomly with equal interval)
###############################Creating fake data##################
#create simple function to generate random last names
randomNames <- function(n = 5000) {
  do.call(paste0, replicate(5, sample(LETTERS, n, TRUE), FALSE))
}

#create data frame
df <- data.frame(last_name = randomNames(500),
                 gpa = rnorm(500, mean=82, sd=3))

#view first six rows of data frame
head(df,9)

#########################Sampling 
#define function to obtain systematic sample
obtain_sys = function(N,n){
  k = ceiling(N/n)
  r = sample(1:k, 1)
  seq(r, r + k*(n-1), k)
}

#obtain systematic sample and selecting 10 names
sys_sample_df = df[obtain_sys(nrow(df), 10), ]

#view first six rows of data frame
head(sys_sample_df)


#sampling error
#Average length of guy in India is 5.5(Parameter) Feet Long. Assume to have some sample and find the error.
height=c(4,4,7,6,6.5,6.7,5.5,5.7,7.1)  #this is the sample I have collected
meanHeight=mean(height)
mu=5.5   #average height from population parameter
samplingError=mu-meanHeight

meanHeight-samplingError
meanHeight+samplingError


#Hypothesis testing

#Hypothesis testing for one population mean when sd known (One mean Z-test)
#Taking 14 students from the  population
students <- read.csv("https://userpage.fu-berlin.de/soga/200/2010_data_sets/students.csv")
mu0 <- 70.8  #given from population
sigma <- sd(students$weight)   #let suppose the standard deviation of sample is near to sd of population
n <- 14 #taking data of 14 students
# random sampling 
x.weight <- sample(x = students$weight, size = n)
# calculate sample mean
x.bar <- mean(x.weight)
x.bar

#Now the hypothesis statement mean of weight student = mean of population
#Now the other hypothesis statement can be when HA weight student != mean of population
#Now the other hypothesis statement can be when HA weight student < mean of population
#Now the other hypothesis statement can be when HA weight student > mean of population

#significance level =0.05 (alpha)
alpha <- 0.05

z <- (x.bar-mu0) / sigma*sqrt(n)

#compute critial value
z.HA.1 <- qnorm(1 - alpha/2)                                      #WHEN HA!=70.8
z.HA.2 <- qnorm(1 - alpha, lower.tail = FALSE)                    #when HA<70.8
z.HA.3 <- qnorm(1 - alpha)                                        #when HA>70.8

# upper limit
# Reject?
print(z > abs(z.HA.1))

#lower limit
# Reject?
print(z < -abs(z.HA.1))

# Reject?
print(z < z.HA.2)

# Reject?
print(z > z.HA.3)


# Calculate the z-score
z <- (x_bar - mu0) / (sigma / sqrt(n))

# Calculate p-values for different hypotheses
p_value_two_sided <- 2 * (1 - pnorm(abs(z)))
p_value_left <- pnorm(z)
p_value_right <- 1 - pnorm(z)

# Significance level
alpha <- 0.05

#Now the hypothesis statement mean of weight student = mean of population
#Now the other hypothesis statement can be when HA weight student != mean of population
#Now the other hypothesis statement can be when HA weight student < mean of population
#Now the other hypothesis statement can be when HA weight student > mean of population

# Compare p-values with the significance level
reject_two_sided <- p_value_two_sided <= alpha
reject_left <- p_value_left <= alpha
reject_right <- p_value_right <= alpha

print("Two-sided test - Reject H0?")
print(reject_two_sided)
print("Left-sided test - Reject H0?")
print(reject_left)
print("Right-sided test - Reject H0?")
print(reject_right)


################Hypothesis testing when sd is unknown. Need to use T distribution in place of standard normal distribution (Z distribution)
simple.ttest <- function(x, mu0, alpha, method='two-sided'){
  n <- length(x)
  xbar <- mean(x)
  s <- sd(x)
  # calculate test statistic
  tstat <- (xbar-mu0)/(s/sqrt(n))
  
  # calculate critical value
  df <- n-1
  # for left-tailed test
  if (method=='left'){
    #inverse probability cumulative density of the Student t-distribution
    crit.val <- qt(p = 0.05, df = df, lower.tail = TRUE)
    #evaluate rejection region
    if (tstat < crit.val){
      reject = TRUE
    } else{
      reject = FALSE
    }
  }
  # for right-tailed test
  else if (method=='right'){
    crit.val <- qt(p = alpha, df = df, lower.tail = FALSE)
    #evaluate rejection region
    if (tstat > crit.val){
      reject = TRUE
    } else {
      reject = FALSE
    }
  }
  # for two-sided test (default)
  else {
    crit.val <- qt(p = alpha/2, df = df, lower.tail = FALSE)
    #evaluate rejection region
    if (abs(tstat) > abs(crit.val) | -abs(tstat) < -abs(crit.val)){
      reject = TRUE
    } else{
      reject = FALSE
    }
  }
  # print out summary and evaluation
  print(paste('Significance level:',alpha))
  print(paste('Degrees of freedom:',df))
  print(paste('Test statistic:',round(tstat,4)))
  print(paste('Critical value:',round(crit.val,4)))
  print(paste('Reject H0:',reject))
}

students <- read.csv("https://userpage.fu-berlin.de/soga/200/2010_data_sets/students.csv")
mu0 <- 70.8 
n <- 9
x <- sample(x = students$weight, size = n)

alpha=0.05

simple.ttest(x, mu0, alpha)                     #Two tailed

simple.ttest(x, mu0, alpha, method = 'right')   #right tailed

simple.ttest(x, mu0, alpha, method = 'left')   #left tailed





#Correlation in R
data=read.csv("D:/desktop/content ML/multireg.csv")
cor(data$Interest_Rate,data$Stock_Index_Price)
cor.test(data$Interest_Rate,data$Unemployment_Rate)

#Covariance in R
# Data vectors
x <- c(1, 3, 5, 10)

y <- c(2, 4, 6, 20)

# Print covariance using different methods
print(cov(x, y))
print(cov(x, y, method = "pearson"))
print(cov(x, y, method = "kendall"))
print(cov(x, y, method = "spearman"))

#Confidence interval in R
#starting the confidence interval calculation. Let suppose I got value v1. There is a possibility of some error into it.
qnorm(0.975)      #alpha=0.05       1-alpha/2=0.975

a <- 5 #mean
s <- 2  #sd
n <- 20  #sample size
error <- qnorm(0.975)*s/sqrt(n)
left <- a-error
right <- a+error

#bias 
#install.packages("Metrics")
library(Metrics)
actual <- c(1.1, 1.9, 3.0, 4.4, 5.0, 5.6)
predicted <- c(0.9, 1.8, 2.5, 4.5, 5.0, 6.2)
bias(actual, predicted)


#skewness and kurtosis
#Positive skew
library(moments)
#library(e1071)

# Defining data vector
x <- c(40, 41, 42, 43, 50)

# Print skewness of distribution
print(skewness(x))

# Histogram of distribution
hist(x)


#zero skew
library(moments)

# Defining normally distributed data vector
x <- rnorm(50, 10, 10)

# Print skewness of distribution
print(skewness(x))

# Histogram of distribution
hist(x)


#Negative skew
library(moments)

# Defining data vector
x <- c(10, 11, 21, 22, 23, 25)

# Print skewness of distribution
print(skewness(x))

# Histogram of distribution
hist(x)


#Kurtosis
a=c(123,34,34,435,45,534,46,4554,6575664353,575754546435425,354534432532)
kurtosis(a)




#Normal Distribution
mu=3.39
sigma=0.55
#95% of the distribution lie between +- 1.96

lower=mu - (1.96 * sigma)  
upper=mu + (1.96 * sigma)


#Computing Z score
#A survey of daily travel time had these results (in minutes):
time=c(26, 33, 65, 28, 34, 55, 25, 44, 50, 36, 26, 37, 43, 62, 35, 38, 45, 32, 28, 34)
timemean=mean(time)
sdtime=sd(time)

#To convert 1st value of time vector in z score:

value=time[1] - timemean

zscore=value/sdtime



#Probability distribution

pnorm(40,mean=72,sd=15.2,lower.tail=F) #accumulated
dnorm(70,mean=72,sd=15.2) #density freq

#sequence of probability values between 0 and 2
q=seq(0,2,by=0.1)
qnorm(q,mean=3,sd=1)
qnorm(0.5,mean=1,sd=1) #sample



#binomial distribution:
pbinom(4,size=12,prob=0.2,lower.tail=FALSE)

#how many head will have a prob of 0.50 when a toss is done for 51 times
qbinom(0.25,51,0.5)

#find 8 random values from a sample of 150 with prob of 0.4
rbinom(8,150,0.4)

#Poission distribution:
ppois(9500,lambda=3468,lower.tail=F)
dpois(17,lambda=12) #lambda which we know already




#T-test
# set parameter
#Recall, the sample is a vector of weights (x), ??0=70.8, given as mu0, n=9, given as n, and ??=0.05, given as alpha
mu0 <- 70.8 
alpha <- 0.05
n <- 9
x <- sample(x = students$weight, size = n)
# call t.test() function
t.test(x = x, mu = mu0, alpha = alpha, alternative = 'two.sided')

#data preprocess
students <- read.csv("https://userpage.fu-berlin.de/soga/200/2010_data_sets/students.csv")
graduates = subset(students, graduated==1)
male <- subset(graduates, gender=='Male')
female <- subset(graduates, gender=='Female')

n <- 50
male.sample <- sample(male$salary, n) 
female.sample <- sample(female$salary, n)
#For two population mean
t.test(x = male.sample, y = female.sample, var.equal = TRUE, alternative = 'greater')


#Paired sample t test
tutorial = subset(students, online.tutorial==1)

n <- 65
random.index <- sample(1:nrow(tutorial), size = n) 

score1.sample <- tutorial$score1[random.index]
score2.sample <- tutorial$score2[random.index]

t.test(x = score1.sample, y = score2.sample, paired = TRUE, alternative = 'less')





df=iris
str(df)
attach(df)

#labels are making here
df$Species = factor(df$Species, levels = c(as.character(unique(df$Species))), labels = c(1:length(unique(df$Species))))


#ttest we can find the p value and according to it we need to take some decisions. Threshold value of p is 0.05. Like if >0.05 it means input and output are related otherwise they are not significant.
t.test(df$Sepal.Length,as.numeric(df$Species))
t.test(Sepal.Width,as.numeric(Species))
t.test(Petal.Length,as.numeric(Species))
t.test(Petal.Length,as.numeric(Species))

#chi square test

table1=table(df$Sepal.Length,df$Species)
chisq.test(table1)

table2=table(Petal.Length,Species)
chisq.test(table2)


df$Species=as.numeric(Species)
#anova
anov=aov(Species~Sepal.Length,data=df)
summary(anov)


















#THis window is the scripting mode of R programming
#below window is the console window where we have our interpreter which interpretes the code.

#topics:

#features: 

"comment: You can explain any line of code. # for single line comment for multi line comment

# hello this is a comment
# this is also a comment.

#\n,\,\r

#its an interpreter based: converts high level language into low level language.

compile: 1 2 3 error:  1,2,3 error

interpreter: 1 error solve

#it contains curley brackets to define the scope of something.{}

#we dnt need to use semicoln here.
"

#mathematical:

5 - 2
a=5+3
5/2
6*2
5%%3    #reminder
5%/%3   #quotient
5+3/2*2   #BODMAS    Bracket   division  multi add sub
max(1,3,6)
min(55,33,11)
sqrt(45)
ceiling(3.3)
floor(3.7)
abs(-34)
factorial(4)

#String: collection of numbers/characters/symbols/special characters.
"hello"

a<-'hello how are you'     #left arrow operator(<-)
b= 'i am good'             

#length
nchar(a)

#if you needs to check a string
grep('hello',a)

#escape method to use in string

a="hello this is"Someone",with no limit to stop"

a="hello this is\"Someone\",with no limit to stop"

cat(a)

paste(a,b)  #concenate both the string here.


#Variables in R programming: are the memory locations where you can store your values

a<-10  #local declaration of variable

a<<-10 #Global declaration of a variable (for making the value changes you have to use <<-)

a<-'hello'

a<-b<-c<-10


# Data types

1) Numeric   110,110.34 
2) Integer   100L,55L
3) Character  "string",'string'
4) Booleon     FALSE, TRUE 

#Operators in R programming
1) Arithmetic: +, - , *, /, %%, %/%,
2) Relational: <,<=,>,>=,!=,==
3) Logical: Bit wise: &,|  Byteiwse: &&(and),||(or)
4) Assignment: =,<-,<<-
5) Miscellaneous: : a=1:10, %in% (array/list), %*% (matrix multiplication)

a=c('hello','how','are','you')  #this is vector declaration
"hello" %in% a


#collection of data

#vectors

name=c(elements)

a<-c(6,2,4,6,7,4,24)
sort(a)

#if we need to repeat something 
rep(c(1,2,3),times=5)


#Creating a vector with a sequence
seq(from=0,to=100,by=15)

a[1]
a[1]=44

#list : it can handle multiple type of data under same name

b<-list(1,'hello',20.21)

b[2]

length(b) #finds the length of list

'hello' %in% b

#adding items into the list
b<-append(b,'bye')

#adding anyitem aty a specific position
b<-append(b,'into',after=2)


#remove something from  a list
b<-b[-1]

#Matrices: we can have data in two dimension. Here our data is written in row and column format

a<-matrix(c(1,2,3,4,5,6),nrow=2,ncol=3)

#accessing the value matrixName[row,column]

a[1,2]

a[1,]

a[,2]

#more than one column
a[,c(2,3)]

#combining more values to row and columns  cbind,rbind

a<-cbind(a,c(11,22))

a<-rbind(a,c(9,8,7,6))

a[-c(1),-c(1)]

dim(a)

length(a)  #total elemnts

#array: we use it when dimensionality is 2 or more than that
vect=c(1,2,3,4,5,6,7,8,9,0)
aa=array(vect,dim=c(5,1,2))
dim(aa)
aa[row,column,frames]

#Data Frame: We have the data written here in the form of a table

df=data.frame(
  Sno=c(1,2,3,4,5),
  Name=c('qwe','wer','asd','sdf','fgh'),
  time=c(12,23,34,12,42)
)


#to find the summary of your table
summary(df)

#accessing data
df[2]

df[['Name']]

df$Name

levels(df$Name)

nrow(df)
ncol(df)


#Factors: This we mainly use when we have to categories our data

song<-factor(c('pop','jazz','bass','classic','classic','pop','bass'))

levels(song)

song[1]='extra bass' #this will not going to happen because extra bass is not there

song[1]='classic'


#Inputting and outputting

#inputting
a<-readline()
a<-readline(prompt='Please enter your name ')
a<-readline(prompt='Please enter any number ')

#to check your data type
class(a)

#type casting
a<-as.integer(a)
a<-as.character(a)
a<-as.numeric(a)

#outputting
print("THis is just for testing")

paste("THis is just for testing",a)  #when we have multiple type to print then use paste.

#Write some basic program of additon of two number, multiplication of two number, adding two matrix., average of 5 numbers.

Examples to do:
  addition of five number
  multiplication of two number
  divide two numbers and print the solution.    
  degree into farenhiet
  km into miles,feet,meter,cm
  rectangle breadth/height  area.
  Currency conversion

#Functions these are the bulding block of a program which helps in reducing the complexity length of a program and makes error detection easy

functionName<-function(){   #declaration of a function
  body of function          #defination of function
}

functionName()             #calling part of a function


func<-function(){
  print("This is a part of a function")
}

func()


#addition of two number program in function

func<-function(){
  a=readline(prompt="Enter first value")
  b=readline(prompt="Enter second value")
  a=as.integer(a)
  b=as.integer(b)
  c=a+b
  print( paste("Sum of a and b is",c))

}

func()



a=readline(prompt="Enter first value")
b=readline(prompt="Enter second value")
a=as.integer(a)
b=as.integer(b)
c=a+b
print( paste("Sum of a and b is",c))


#Arguments with the function

func<-function(a){
  print( paste("This is a part of a function",a))
  return(100+a)
  print("This is after return statement")
}

bb<-func(34)


#you can make the argument bydefault

func<-function(name='Japan'){
  print( paste(name))
}

func()
func('India')


How function reduces the length of a program.
program 

1 to 1000 lines   we are performing 10 different task

1   200    10
2   100    10
3   50     10
4   400    10
5   20
....

10+10+10+10=40 lines

Now what we can do 0 task 10 lines

0   10 lines


1   200    1 line will call task 0
2   100    1
3   50     1
4   400    1
5   20
....

1+1+1+1+10=14 lines


How it makes the error detection easy.

1  f1    error in this function. display   100 lines.
2  f2                            input
3  f3                            calculation
4  f4                            debugging

If we have error in function f1 it should not effect anyother function in the program.

But if we have 1 to 1000 lines written without a function it might be possible that these lines are
related to each other.

How it reduces the complexity in a program.

1 to 1000 lines now we have to make some modification in it. Client purchased 3 more machine and 
they want to input the data of that machines.
Programmer needs to search where the lines of machines are written.

1   200    
2   100    
3   50     
4   400    machine task.
5   20
....



#Return part

func<-function(){
  print("This is a part of a function")
  return(100)
}

a<-func()

#variables
func<-function(){
  bbc<<-120        
  paste("This is a part of a function",bbc)
}
bbc<-100  #local variable
func()
bb

#take input outside function and make the calculation and display inside the function.


#Statements: If, Ifelse, Elseif

if(condition){
  #body of if
} else {
  #body of else
}

a=11
if(a==10){
  print("The value of a is 10")
} else{
  print("The value is a is not 10")
}

a=readline(prompt='Enter a number for a ')
a=as.integer(a)
if(a==20){
  print("Value of a is 20")
  if(a==20){
    print("value of a is still 20")
  }
} else{
  print("Value of a is not 20")
}


a=31
if(a==20){
  print("Value of a is 20")
} else if(a==30){
  print("Value of a is 30")
} else{
  print("Wrong value entered")
}

#eg

# Define a function to generate n random numbers for
# a specified distribution

my.ran <- function(n, distribution, shape = NULL){
  if(distribution == "gamma" && shape == "NULL"){
    stop("Specify shape parameter")
  } else if(distribution == "gamma"){
    return(rgamma(n, shape))
  } else if(distribution == "exp"){
    return(rexp(n))
  } else if(distribution == "norm"){
    return(rnorm(n))
  } else{
    stop(cat("distribution must be \"gamma\", \"exp\", or \"norm\""))
  }
}
my.ran(30, "exp", NULL)

# Check number even or odd.
# Create a password authentication system.
# Check leap year
# Finding the largest number.
# checking number whether it is prime or not
# Find a prime number from a series. Loops/Condition statement.
# Check number if it is positive or negative
# Program to create a scientific calculator.
# Project: Office management system. different employee of the company if needs to enter they have to put their login credentials. welcome name. In into the office.


# Matrix program: Two matrix addition/multiplication/division/subtraction.


#Switch statement in R: To prevent multiple else in if condition switch is use

# Define a function to generate n random numbers for
# a specified distribution

my.ran2 <- function(n, distribution, shape = NULL) {
  if(distribution == "gamma" && shape == "NULL"){
    stop("Specify shape parameter")
  }
  switch(distribution,
         gamma = rgamma(n,shape),
         exp = rexp(n),
         norm = rnorm(n),
         stop("distribution must be either \"gamma\",\"exp\", or \"norm\""))
}

my.ran2(10, "exp", NULL)

#loops in R programming. Something we use to repeat a task.

for, while, repeat
  
repeat{
  print("Hello world")
}


while loops: these are the condition loops

a=0
while(a<5){
  print("hello world")
  a=a+1
}

#Use of break and next statement
a=0
while(a<5){
  if(a==3){
    break   #condition stop of a loop
  }
  print("hello world")
  a=a+1
}

#next will make your current iteration stop and makes the loop to execute with next itegration

a=0
while(a<5){
  if(a==3){
    a=a+1
    next
  }
  print(a)
  a=a+1
}



for loops: countable loop
  
for(variable in collection of type){
  body of for loop
}


a=c(1,2,3,4,5)
for(i in a){
  print(i)
}


for(i in 1:10){
  print(i)
}

a=list('sdef',32,434.434)
for(i in a){
  print(i)
}


#you can use break and next statement as we use in while loop

a=c(1,2,3,4,5)
for(i in a){
  if(i==3){
    break
  }
    print(i)
}


a=c(1,2,3,4,5,3,9,3,7,5)
for(i in a){
  if(i==3){
    next
  }
  print(i)
}



#finding the prime number. input some value finds their prime in r programming.




"""
Stock market: 23,3,4,52,33,434,...........,34,45,42,4,33,54,5   10k values?

Find the ans of so many question here?
1) when we have max stock value?
2) min stock value
3) fluctuation happening in stock value?
4) max value of stock repeating?   26
6) min value of stock repeating?
......

large show easily? graph.
"""
  

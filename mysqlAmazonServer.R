#install.packages("RMySQL")
library(RMySQL)

mydb = dbConnect(MySQL(), user='admin', password='sushilsoni123', port=3306, 
                 host='database-2.cav6hcgjycmc.us-east-1.rds.amazonaws.com',dbname="database-2")



#dbSendQuery(mydb, 'create database FDPSQL')

dbSendQuery(mydb, 'create table mytablenew(id int identity primary key,name varchar(55),address varchar(255))')

dbSendQuery(mydb, 'insert into mytablenew(id,name,address) values(5,"Ram","Jaipur"),(6,"Shyam","Chennai")')

var=dbSendQuery(mydb, 'select * from mytablenew')



dbFetch(var)



dbSendQuery(mydb, 'alter table mytablenew add email varchar(150)')
dbSendQuery(mydb, 'alter table mytablenew drop email')

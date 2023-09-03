install.packages("RODBC")

library(RODBC)

uat_conn = odbcConnect("mayODBC")

sqlQuery(uat_conn,"select name from master.sys.sysdatabases where dbid > 4")


sqlQuery(uat_conn,"create table tablemine(id int,name varchar(50))")

sqlQuery(uat_conn,"insert into tablemine(id,name) values(1,'RAM'),(2,'Raman')")

df=sqlQuery(uat_conn,"select name from tablemine where name='RAM'")

#collected the data from sql and now you can do the data preprocessing.

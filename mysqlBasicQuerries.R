
#install.packages("RMySQL")
library(RMySQL)

mydb = dbConnect(MySQL(), user='root', password='mysql',  host='localhost')


tab = dbSendQuery(mydb, 'Show tables')

#To fetch data
dbFetch(tab)




#Connecting to MySQL:
mydb = dbConnect(MySQL(), user='root', password='mysql', dbname='DataScience', host='localhost')

#Listing Tables and Fields:
dbListTables(mydb)
#This will return a list of the tables in our connection.
dbListFields(mydb, 'irisDataSet')
#This will return a list of the fields in some_table.

#Running Queries:
#  Queries can be run using the dbSendQuery function.
tab = dbSendQuery(mydb, 'Select * from irisDataSet')

#To fetch data
dbFetch(tab)

#close the connection
dbDisconnect(mydb)

dbSendQuery(mydb, 'drop table if exists Churn')

#create a table
dbSendQuery(mydb,'create table newTesting (id INT,name VARCHAR(244))')

#Making tables:
dbWriteTable(mydb, name='newTesting', value=data.frame.name)

#Retrieving data from MySQL:
rs = dbSendQuery(mydb, "select * from some_table")

data = fetch(rs, n=-1) #using n=-1 retrieves all pending records.


dbSendQuery(mydb, "insert into newTesting values(13,'world')")
rs = dbSendQuery(mydb, "select * from newTesting")
dbFetch(rs)



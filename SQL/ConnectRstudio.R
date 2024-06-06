library(DBI)
library(stringr)
library(readr)
library(tidyverse)
con <- dbConnect(odbc::odbc(), .connection_string = "Driver={MySQL ODBC 8.2 Unicode Driver};", 
                 Server = "localhost", Database = "tktdb", UID = "root", PWD = "to09092022")

setwd("E:/DC/MySQL/")
data.name<-list.files()
data.name<-data.name[str_sub(data.name,-3)=="csv"]

Bill<-as.data.frame(read.csv("Bill Information 1.csv",row.names = NULL))
Policy<-as.data.frame(read.csv("Policy Information 1.csv",row.names = NULL))
Life<-as.data.frame(read.csv("Life Insured Information 1.csv",row.names = NULL))

Bill<-Bill[0,]
BiLife<-Life[0,]
Policy<-Policy[0,]


for (datname in data.name){
  if(substr(datname,1,1)=="B"){
    Newdat<-as.data.frame(read.csv(datname,row.names = NULL))
    Bill<-rbind(Bill,Newdat)
  }  
  if(substr(datname,1,1)=="L"){
    Newdat<-as.data.frame(read.csv(datname,row.names = NULL))
    Life<-rbind(Life,Newdat)
  }  
  if(substr(datname,1,1)=="P"){
    Newdat<-as.data.frame(read.csv(datname,row.names = NULL))
    Policy<-rbind(Policy,Newdat)
  }  
}

start<-proc.time()
dbWriteTable(con,"Bill",Bill,row.names=FALSE)
proc.time()-start

start<-proc.time()
dbWriteTable(con,"Life",Life,row.names=FALSE)
proc.time()-start

start<-proc.time()

dbWriteTable(con,"Policy",Policy,row.names=FALSE)
proc.time()-start

library(DBI)
sql<-"SELECT * 
FROM life 
WHERE Li_DOB ='1970-01-01'
ORDER BY Li_DOB;"
dat<-dbGetQuery(con,sql)



sql1<-"SELECT *
FROM policy
WHERE Effective_Date ='2001-02-01' 
and Coverage_Name IN ('END1','END2','END3');"
dat<-dbGetQuery(con,sql1)
dat

library(ggplot2)
ggplot(dat,aes(Sum_Assured))+geom_histogram(,col="darkred")+facet_wrap(~Coverage_Name)
dat%>%ggplot()+geom_boxplot(aes(Coverage_Name,Sum_Assured))


sql2<-"Select *
from Policy
where Effective_Date = '2001-02-01'
and Coverage_Name LIKE 'EN%' ;"
dat<-dbGetQuery(con,sql2)
dat

sql3<-"Select *
from Policy
where Effective_Date = '2001-02-01'
and Coverage_Name LIKE '%UL%' ;"
dat<-dbGetQuery(con,sql3)
dat


sql4<-"Select *
  from Policy
where Effective_Date = '2001-02-01'
LIMIT 5;"
dat<-dbGetQuery(con,sql4)

sql5<-"Select *
  from Policy
where Effective_Date = '2001-02-01'
LIMIT 10, 3;"
dat<-dbGetQuery(con,sql5)



sql6<-"Select Policy.*, Li_DOB, Li_Gender, Li_OccupationClass
from Policy
JOIN Life
on Policy.Li_ID = Life.Li_ID;"
dat<-dbGetQuery(con,sql6)


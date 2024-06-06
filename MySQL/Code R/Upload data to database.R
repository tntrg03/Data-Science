library(DBI)
library(stringr)
library(readr)
library(tidyverse)
con <- dbConnect(odbc::odbc(), .connection_string = "Driver={MySQL ODBC 8.0 Unicode Driver};", 
                 Server = "localhost", Database = "tktdb", UID = "root", PWD = "123456@")

setwd("C:/Users/AD/Desktop/Tex file/Thu latex/Introduction to R Act 60/Datasets/MySQL")
data.name<-list.files()
data.name<-data.name[str_sub(data.name,-3)=="csv"]

Bill<-as.data.frame(read.csv("Bill Information 1.csv",row.names = NULL))
Policy<-as.data.frame(read.csv("Policy Information 1.csv",row.names = NULL))
Life<-as.data.frame(read.csv("Life Insured Information 1.csv",row.names = NULL))

Bill<-Bill[0,]
Life<-Life[0,]
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
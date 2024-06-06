
setwd("E:/DC/MySQL")

#-----------------------------------------------------------------------------#
#                          DU LIEU HOP DONG

N<-2000000 # so hop dong
M<-1000000 # so nguoi duoc bao ve

k<-20 # so file
n<-N/k # So hop dong trong 1 file

for (i in 1:k){
  
  v1<-paste0("P",((n*i):(n*(i+1)-1)))
  
  u1<-runif(n,0,1)
  u2<-runif(n,0,1)
  v2<-paste0(ifelse(u1<0.333,"TL",
                    ifelse(u1<0.666,"END","UL")),sample(1:3,n,replace=TRUE))
  v3<-paste0("LI",sample(1:M,n,replace=TRUE)) 
  v4<-sample(100:1000,n,replace=TRUE)*10^6
  
  dd<-paste0(2000+i,"-01-01")
  aaa<-as.numeric(as.Date(dd))
  v5<-as.Date(aaa+sample(1:365,n,replace=TRUE),origin = "1970-01-01")
  
  u1<-runif(n,0,1)
  v6<-ifelse(u1<0.5,"Agency","Banca")
  
  dat<-data.frame(Policy_Number=v1,
                  Coverage_Name = v2,
                  Li_ID = v3,
                  Sum_Assured = v4,
                  Effective_Date = v5,
                  Chanel = v6)
  write.csv(dat,file=paste0("Policy Information ",i,".csv"),row.names = FALSE)
  
}
#------------------------------------------------------------------------------#
#                     Du lieu nguoi duoc bao ve

k<-20 # so file
m<-M/k # So hop dong trong 1 file

for (i in 1:k){
  
  v1<-paste0("LI",((m*i):(m*(i+1)-1)))
  
  u1<-runif(m,0,1)
  v2<-ifelse(u1<0.5,"Male","Female")
  
  dd<-paste0(1960+i,"-01-01")
  aaa<-as.numeric(as.Date(dd))
  v3<-as.Date(aaa+sample(1:365,m,replace=TRUE),origin = "1970-01-01")             
  
  v4<-paste0("00",sample(1:4,m,replace=TRUE))
  
  dat<-data.frame(Li_ID=v1,
                  Li_Gender = v2,
                  Li_DOB = v3,
                  Li_OccupationClass = v4)
  
  write.csv(dat,file=paste0("Life Insured Information ",i,".csv"),row.names = FALSE)
  
}

#-----------------------------------------------------------------------------#
#                    THONG TIN DONG PHI TU NAM 2021

B<-5000000
k<-20
b<-B/k

for (i in 1:k){
  
  v1<-paste0("B",((b*i):(b*(i+1)-1)))
  
  v2<-sample(100:10000,b,replace=TRUE)*1000
  
  dd<-paste0(2021,"-01-01")
  aaa<-as.numeric(as.Date(dd))
  v3<-as.Date(aaa+sample(1:365,b,replace=TRUE),origin = "1970-01-01") 
  
  v4<-paste0("P",sample(1:N,b,replace=TRUE))
  
  dat<-data.frame(Bill_ID=v1,
                  Bill_Date = v3,
                  Premium_Amount = v2,
                  Policy_Number = v4)
  
  write.csv(dat,file=paste0("Bill Information ",i,".csv"),row.names = FALSE)
  
}



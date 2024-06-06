
library(randomForest)
library(MASS)
dat=Boston
library(caret)
library(tidyverse)

K=5
set.seed(10)
index=createFolds(dat$medv,k=K)
saiso=rep(0,K)


for (i in 1:k){
  test.index=index$Fold1
  train=dat[-test.index,]
  test=dat[test.index,]
  rf1=randomForest(medv~.,data=train,mtry = 6, ntree= 200)
  medv.pred=predict(rf1,newdata=test)
  saiso=sqrt(mean((test$medv-medv.pred)^2))
}
mean(saiso)
#mtry:số lượng biến đưa vào mô hình để dự đoán
#ntree:số cây khi xây dựng mô hình


K=5
set.seed(10)
index=createFolds(dat$medv,k=K)
saiso=rep(0,K)

v.mtry=c(2,4,6,8)
v.ntree=c(300,600,900,1200)

#Dùng vòng lặp quét qua từng giá trị mtry và ntree
for(j1 in 1:length(v.mtry)){
  for(j2 in 1:length(v.ntree)){
    for (i in 1:k){
      test.index=index$Fold1
      train=dat[-test.index,]
      test=dat[test.index,]
      rf1=randomForest(medv~.,data=train,mtry = v.mtry[j1], ntree= v.ntree[j2])
      medv.pred=predict(rf1,newdata=test)
      saiso=sqrt(mean((test$medv-medv.pred)^2))
    } 
    print(paste("Số biến:",v.mtry[j1],",Số cây:",v.ntree[j2],",Sai số cross-validation:",mean(saiso)))
  }
}

## Boosting

library(gbm)
K=5
set.seed(10)
index=createFolds(dat$medv,k=K)
saiso=rep(0,K)


for (i in 1:k){
  test.index=index$Fold1
  train=dat[-test.index,]
  test=dat[test.index,]
  
  #rf1=randomForest(medv~.,data=train,mtry = 6, ntree= 200)
  
  medv.pred=predict(rf1,newdata=test)
  saiso=sqrt(mean((test$medv-medv.pred)^2))
}
mean(saiso)


## Classification 
purity=function(x,option="Gini"){
  p=table(x)/length(x)
  if (option =="Test error"){
    return(1-max(p))
  }
  if (option == "Gini"){
    return(sum(p*(1-p)))
  }
  if (option == "Entropy"){
    return(-sum(p*log(p)))
  }
}

x1=c(rep(1,7),rep(2,3))
x2=c(rep(1,7),c(2,3,4))
purity(x1,option="Gini")
purity(x2,option="Gini")
purity(x1,option="Test error")
purity(x2,option="Test error")
purity(x1,option="Entropy")
purity(x2,option = "Entropy")


# Xây dựng mô hình cây phân loại sao cho tìm điểm cắt dữ liệu,sau đó xây dựng mô hình trên tập dự liệu
#tính chỉ số Gini hoặc Entropy là nhỏ nhất

library(ISLR)
library(tree)
dim(Default)
str(Default) # Dữ liệu về nợ thẻ tín dụng

# xây dựng mô hình classification tree biến default phụ thuộc vào biến balance
# Tìm số c sao cho khi balance được chia thành 2 cây L1(<c) và L2(>c) để Gini(L1)+Gini(L2)nhỏ nhất

tree1=tree(default~balance,data=Default)
tree1=prune.tree(tree1,best = 2)
plot(tree1)
text(tree1,pretty = 0)

tree1=tree(default~balance,data=Default)
plot(tree1)
text(tree1,pretty = 0)

attach(Default)
tree1=tree(default~.,data=Default,
           control = tree.control(nobs = nrow(Default),
                                  mincut = 2,
                                  minsize = 4,
                                  mindev = 0.002))
tree1=prune.tree(tree1,best = 2)
plot(tree1)
text(tree1,pretty = 0)


# P3:
library(ggplot2)
library(dslabs)
library(dplyr)

us_contagious_diseases
p1<-us_contagious_diseases%>%filter(disease=="Measles")%>%
  mutate(rate=count*1000/population)%>%
  ggplot(aes(year,state,fill=rate))+geom_tile(color="grey")
p1+scale_fill_gradientn(colors = c(rgb(1,1,1),rgb(1,0,0),
                                   rgb(0.8,0,0)),trans = "sqrt")+
  geom_vline(xintercept=1963, col = "green", size=2) +
  scale_x_continuous(expand=c(0,0))+
  theme_minimal()+
  theme(panel.grid = element_blank(),
        legend.position="bottom",
        text = element_text(size = 12))+
  xlab(label="")+
  ylab(label="")

# 3 tphan bắt buộc :data,cấu phần(aes),goem()
str(gapminder)
datagap<-gapminder%>%mutate(gdp_per_capita=gdp/population)%>%filter(year=="2010")
ggplot(datagap,aes(x=fertility,y=gdp_per_capita)+geom_point()#đồ thị dải điểm
ggplot(datagap,aes(x=infant_mortality,y=life_expectancy))+geom_point(,col="darkblue")


#
ggplot(mpg,aes(cty,hwy))+geom_point()
ggplot(diamonds,aes(carat,price))+geom_point()
ggplot(economics,aes(date,unemploy))+geom_line(,lwd=1.5)
ggplot(datagap,aes(gdp_per_capita))+geom_histogram(,col="darkblue")

#
ggplot(datagap,aes(x=fertility,y=gdp_per_capita,shape=continent))+geom_point()
ggplot(datagap,aes(x=fertility,y=gdp_per_capita,color=continent))+geom_point()
ggplot(datagap,aes(x=fertility,y=gdp_per_capita,size=continent))+geom_point()

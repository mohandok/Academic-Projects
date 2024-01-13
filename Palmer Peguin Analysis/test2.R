library(forecast)
# ts.plot() will create a time series plot
ts.plot(my.penguins[,3],main="Bill Length", col="red",xlab="rate", ylab="Bill length values",lwd=2)
text(20,30,"Maximum",col="blue")# will add text to our graph

boxplot(my.penguins[,4],col="green",main="BoxPlot attacs",xlab="Count")

par(mfrow=c(2,2))
h<-hist(my.penguins$bill_length_mm,col="green",main="",xlab="number of attacs",ylab="Freq")
xfit <- seq(min(my.penguins$bill_length_mm), max(my.penguins$bill_length_mm), length = 40)
yfit <- dnorm(xfit, mean = mean(my.penguins$bill_length_mm), sd = sd(my.penguins$bill_length_mm))
yfit <- yfit * diff(p$mids[1:2]) * length(my.penguins$bill_length_mm)
lines(xfit, yfit, col = "black", lwd = 2)

a<-hist(my.penguins$bill_depth_mm,col="green",main="Histogram attacs",xlab="number of attacs",ylab="Freq")
xfit <- seq(min(my.penguins$flipper_length_mm), max(my.penguins$flipper_length_mm), length = 40)
yfit <- dnorm(xfit, mean = mean(my.penguins$flipper_length_mm), sd = sd(my.penguins$flipper_length_mm))
yfit <- yfit * diff(p$mids[1:2]) * length(my.penguins$flipper_length_mm)
lines(xfit, yfit, col = "black", lwd = 2)

p<-hist(my.penguins$flipper_length_mm,col="green",main="Histogram attacs",xlab="number of attacs",ylab="Freq")
xfit <- seq(min(my.penguins$flipper_length_mm), max(my.penguins$flipper_length_mm), length = 40)
yfit <- dnorm(xfit, mean = mean(my.penguins$flipper_length_mm), sd = sd(my.penguins$flipper_length_mm))
yfit <- yfit * diff(p$mids[1:2]) * length(my.penguins$flipper_length_mm)
lines(xfit, yfit, col = "black", lwd = 2)


d<-hist(my.penguins$body_mass_g,col="green",main="count of penguins with Body mass",xlab="Penguins body mass",ylab="Count of Penguins")
xfit <- seq(min(my.penguins$body_mass_g), max(my.penguins$body_mass_g), length = 40)
yfit <- dnorm(xfit, mean = mean(my.penguins$body_mass_g), sd = sd(my.penguins$body_mass_g))
yfit <- yfit * diff(d$mids[1:2]) * length(my.penguins$body_mass_g)
lines(xfit, yfit, col = "black", lwd = 2)

density(my.penguins$body_mass_g, col="red")


hist(my.penguins[,2],col="orange",main="Histogram av.length",xlab="time")

library(ggplot2)
library(fitdistrplus)
library(dplyr)
library(tidyverse)
plotdist(data=my.penguins$bill_length_mm, histo = TRUE, demp = TRUE)
d <- density(my.penguins$flipper_length_mm)
plot(d, type="n", main="robbery")
polygon(d, col="lightgray", border="gray")
rug(my.penguins$body_mass_g, col="red")

par(mfrow = c(2, 2))
ggplot(my.penguins, aes(x=bill_length_mm, fill=sex)) +
  geom_density(alpha=0.2)+
  scale_fill_manual(values=c("orange2", "indianred2"))+
  xlab("Bill length(mm)")+
  labs(title = "                                Distribution plot With Bill length(mm)")

ggplot(my.penguins, aes(x=bill_depth_mm, fill=sex)) +
  geom_density(alpha=0.2)+
  scale_fill_manual(values=c("orange2", "indianred2"))+
  xlab("Bill length(mm)")+
  labs(title = "                                Distribution plot With Bill length(mm)")

ggplot(my.penguins, aes(x=flipper_length_mm, fill=sex)) +
  geom_density(alpha=0.2)

ggplot(my.penguins, aes(x=body_mass_g, fill=sex)) +
  geom_density(alpha=0.2)
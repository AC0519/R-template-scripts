library(ISLR)
library(MASS)

lda.fit <- lda(Direction~Lag1+Lag2, data=Smarket, subset=Year<2005)
lda.fit
plot(lda.fit)

smarket.2005 <- subset(Smarket, Year==2005)
lda.pred<- predict(lda.fit, smarket.2005)
lda.pred[1:5,] #This does not work since it is not in a matrix format
class(lda.pred)
data.frame(lda.pred)[1:5,]
table(lda.pred$class, smarket.2005$Direction)
mean(lda.pred$class==smarket.2005$Direction)

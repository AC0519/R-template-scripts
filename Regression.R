library(MASS)
library(ISLR)

##################
###Simple Linear Regression
##################
names(Boston)
?Boston

#Plot median value as a function of lower status of population
plot(medv~lstat, Boston)


#Fit linear model to this data

fit1<- lm(medv~lstat, Boston)
fit1
summary(fit1)

#add linear model fit to the plot
abline(fit1, col="red", lwd=3)

#Confidence intervals for the fit
confint(fit1)

#Predict for three different values and ask for confidence interval.  This gives us the fit at those values and the lower and upper confidence intervals for each.
predict(fit1, data.frame(lstat=c(5,10,15)), interval = 'confidence')


##################
###Multiple Linear Regression
##################
fit2 <- lm(medv~lstat+age, Boston)
summary(fit2)

fit3<-lm(medv~., Boston)
summary(fit3)

#Four plots get produced when you do a plot so we will first tell it to do a 2x2 layout and then plot the data
par(mfrow=c(2,2))
plot(fit3) #The first plot shows us that there is some non-linearity in the data

#We are updating the 'fit3' model by subtracting out the variables that the model showed are not significant

fit4 <- update(fit3, ~. -age -indus)
summary(fit4)


#################
###Nonlinear terns and Interactions
#################
#put an interaction between lstat and age and then model it
fit5 <- lm(medv~lstat*age, Boston)
summary(fit5)

#We saw that there is a non-linear scatter plot between medv and lstat so we are going to explicitly put in a quadratic term
fit6 <- lm(medv~lstat +I(lstat^2), Boston)
summary(fit6)

#plot data.  We can't use abline since that only works with a straight line fit.  Therfore we will use the points command to plot a 'curve line' of points.  pch controls how these points are displayed.  If you want to change the size of the points, you can use the 'cex' command
attach(Boston) #This means that the named variables of this data set are avialable in our data space
par(mfrow=c(1,1))
plot(medv~lstat)
points(lstat, fitted(fit6), col='red', pch=20)

#an easier way to fit polynomials.  In this case we will fit medv as a 4th degree polynomial of lstat and plot it as a blue 'line'
fit7<- lm(medv~poly(lstat, 4))
points(lstat, fitted(fit7), col='blue', pch=20)


###################
###Qualitative Predictors
###################
names(Carseats)
summary(Carseats)

#Fit a model for the sales of carseats data based on everything and with an interaction between income/advertising and age/price
fit1<- lm(Sales~.+Income:Advertising+Age:Price, Carseats)
summary(fit1)

#The contrasts function shows how R will code a qualitative variable when used in a model
contrasts(Carseats$ShelveLoc)

#####################
###Write R function to fit a model and make a plot
#####################

#The '...' in the functional input below allows you to enter extra arguements if you want
regplot<- function(x,y,...){
  fit=lm(y~x)
  plot(x,y,...)
  abline(fit, col='red')
}

attach(Carseats)
regplot(Price, Sales, xlab="Price", ylab="Sales", col="blue", pch=20)













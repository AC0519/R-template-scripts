library(readr)
library(dplyr)
library(sqldf)
library(ggplot2)
library(tibble)


#########
#Load in and select data
#########

inflation <- read_csv("C:/Users/Anthony.Crespo/Desktop/inflation_consumer_prices.csv")

inflation <- rename(inflation, "Country" = "Country Name", "Code"= "Country Code", "IndicatorN" = "Indicator Name", "IndicatorC" = "Indicator Code")

Venezuela <- sqldf("SELECT * FROM inflation
WHERE Country = 'Venezuela, RB';")


###########
# Transpose data for time series analysis
##########

Venezuela <- select(Venezuela, -Country, -Code, -IndicatorN, -IndicatorC)

Venezuela <- t(Venezuela)

Venezuela <- as.data.frame(Venezuela)

#add a new index to transposed data
Venezuela <- rownames_to_column(Venezuela, "Year")

colnames(Venezuela)[2] <- "Inflation_Rate"

#I added values for 2017 "fix()" command

#set Year to Date
Venezuela$Year <- as.Date(Venezuela$Year, "%Y")

#set Inflation rate to numeric
Venezuela$Inflation_Rate <- as.numeric(Venezuela$Inflation_Rate)


#######
#Plot inflation data
#######

#Select data starting from 1995
Venezuela <- sqldf("SELECT * FROM Venezuela
WHERE Year >= 1995;")


ggplot(Venezuela, aes(Year, Inflation_Rate, group=1))+
  geom_line()+
  ylim(0,1200)+
  ylab("Percent Inflation")+
  theme(panel.background = element_blank())+
  theme(panel.grid.major.y = element_line(color = 'grey'))+
  ggtitle("Venezuelan Inflation", subtitle = "Source: World Bank")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme(plot.subtitle = element_text(hjust = 0.5))




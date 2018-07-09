library(readr)
library(dplyr)
library(sqldf)
library(ggplot2)
library(tibble)

#########
#Load in and select data
#########

inflation <- read_csv(".../inflation_consumer_prices.csv")

inflation <- inflation_consumer_prices

inflation <- rename(inflation, "Country" = "Country Name", "Code"= "Country Code", "IndicatorN" = "Indicator Name", "IndicatorC" = "Indicator Code")

Venezuela <- sqldf("SELECT * FROM inflation
                   WHERE Country = 'Venezuela, RB';")


###########
# Transpose data for time series analysis
##########

Venezuela <- select(Venezuela, -Country, -Code, -IndicatorN, -IndicatorC)

Venezuela <- t(Venezuela)

Venezuela <- as.data.frame(Venezuela, stringsAsFactors=F)

#add a new index to transposed data
Venezuela <- rownames_to_column(Venezuela, "Year")

colnames(Venezuela)[2] <- "Inflation_Rate"

#Select data starting from 2007
Venezuela <- sqldf("SELECT * FROM Venezuela
                   WHERE Year >= 2007;")

#I added a value of 1087.53 for 2017 using "fix(Venezuela)" command

#set Year to Date
Venezuela$Year <- as.Date(Venezuela$Year, "%Y")

#set Inflation rate to numeric
Venezuela$Inflation_Rate <- as.numeric(as.character(Venezuela$Inflation_Rate))


#######
#Plot inflation data
#######

ggplot(Venezuela, aes(Year, Inflation_Rate, group=1))+
  geom_line()+
  ylim(0,1200)+
  ylab("Percent Inflation")+
  theme(panel.background = element_blank())+
  theme(panel.grid.major.y = element_line(color = 'grey'))+
  ggtitle("Venezuelan Inflation", subtitle = "Source: World Bank")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme(plot.subtitle = element_text(hjust = 0.5))



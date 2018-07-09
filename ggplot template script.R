library(tidyverse)
library(ggmap)

##########################################################
##############Load in data and conduct elementary EDA
######################################################

college <- read_csv("C:/Users/Anthony.Crespo/Desktop/ggplot2/college.csv")

summary(college)

college <- college %>%
  mutate(state=as.factor(state), region=as.factor(region), highest_degree=as.factor(highest_degree), control=as.factor(control), gender=as.factor(gender))


unique(college$loan_default_rate) #R is reading this as a charachter string because there is a "null" value listed.  A null value in R to be read as numeric needs to be "NA".

college <- college %>% 
  mutate(loan_default_rate=as.numeric(loan_default_rate))


################################################################
############Visualize the data
########################################################

#plot sat average as a function of tuition while using size of dot to consider the number of undergrads and the color of the dot to differentiate between public and private schools.  
ggplot(college) +geom_point(aes(tuition, sat_avg, color=control, size=undergrads, alpha=.25)) 

#same plot as a line geometry without point size or alpha
ggplot(college) +geom_line(aes(tuition, sat_avg, color=control)) 

#same plot as point and  line geometry without point size or alpha
ggplot(college) +geom_line(aes(tuition, sat_avg, color=control)) +geom_point(aes(tuition, sat_avg, color=control)) 

#specify details at the plot level to clean up the code
ggplot(college, aes(x=tuition, y=sat_avg, color=control)) +geom_point() +geom_line()


#fit a line to the data
ggplot(college, aes(x=tuition, y=sat_avg, color=control)) +geom_point(alpha=.1) +geom_smooth(se=F)

#Bar graph: how many schools are in each of the four regions of the U.S.
ggplot(college) +geom_bar(aes(x=region))

#Stacked bar: showing the above data by public and private schools
ggplot(college) +geom_bar(aes(x=region, fill=control))

#Create new variable and Geom_Col: average tuition by region
college %>% group_by(region) %>%
  summarize(average_tuition=mean(tuition)) %>%
  ggplot() +geom_col(aes(x=region, y=average_tuition))

#Histogram: number of institutions by undergrad population
ggplot(college) + geom_histogram(aes(x=undergrads), orgin=0, binwidth=10000)

#Boxplot: how tuition varies from public to private universities
ggplot(college) +geom_boxplot(aes(x=control, y=tuition))


##############################################################
#############Beautifying Visualizations
#####################################################

########Modifying the Background


#initial data:
ggplot(college) +geom_bar(aes(x=region, fill=control))
#make background purple
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(plot.background = element_rect(fill='purple'))

#make panel background purple
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(panel.background = element_rect(fill='purple'))

#no background at all
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(plot.background = element_blank())+theme(panel.background = element_blank())

#no background but grey plot lines
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(plot.background = element_blank())+theme(panel.background = element_blank()) +theme(panel.grid.major = element_line(color = "grey"))

#no background but grey plot lines on the y axis only
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(plot.background = element_blank())+theme(panel.background = element_blank()) +theme(panel.grid.major.y = element_line(color = "grey"))
  

#####Working with Axes

#initial data:
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(plot.background = element_blank())+theme(panel.background = element_blank())

#modify axis labels
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(plot.background = element_blank())+theme(panel.background = element_blank()) + ylab("Number of Schools") +xlab ("Region")

#specify limits of Y-axis
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(plot.background = element_blank())+theme(panel.background = element_blank()) + ylab("Number of Schools") +xlab ("Region")+ylim(0,500)
  

######Changing Scales

#initial data:
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(plot.background = element_blank())+theme(panel.background = element_blank())
  
#Modify x-axis using the scale function
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(plot.background = element_blank())+theme(panel.background = element_blank()) +scale_x_discrete(name="Region")

#modify the name of the y-axis
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(plot.background = element_blank())+theme(panel.background = element_blank())+scale_y_continuous(name="Number of Schools")

#Change limits of y-axis
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(plot.background = element_blank())+theme(panel.background = element_blank())+scale_y_continuous(name="Number of Schools", limits=c(0,500))

#Change fill colors
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(plot.background = element_blank())+theme(panel.background = element_blank())+scale_y_continuous(name="Number of Schools", limits=c(0,500)) + scale_fill_manual(values=c("blue","red"))


#########Cleaning up legends
#initial data
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(plot.background = element_blank())+theme(panel.background = element_blank())+scale_x_discrete(name="Region")+scale_y_continuous(name="Number of Schools", limits=c(0,500)) + scale_fill_manual(values=c("blue","red"))

#editing the legend
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(plot.background = element_blank())+theme(panel.background = element_blank())+scale_y_continuous(name="Number of Schools", limits=c(0,500)) + scale_fill_manual(values=c("blue","red"), guide=guide_legend(title="Institution Type", nrow = 1, label.position = "bottom", keywidth = 2.5))

#Move the legend
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(plot.background = element_blank())+theme(panel.background = element_blank())+scale_y_continuous(name="Number of Schools", limits=c(0,500)) + scale_fill_manual(values=c("blue","red"), guide=guide_legend(title="Institution Type", nrow = 1, label.position = "bottom", keywidth = 2.5))+theme(legend.position = "top")


########Annotating Visualizations
#initial data
ggplot(college) +geom_point(aes(tuition, sat_avg, color=control, size=undergrads, alpha=.25)) 

#Box off the top right corner and annotate it as "elite private".
ggplot(college) +geom_point(aes(tuition, sat_avg, color=control, size=undergrads, alpha=.25)) +annotate("text", label="Elite Privates", x=45000, y=1450)

#add mean SAT score across all schools
ggplot(college) +geom_point(aes(tuition, sat_avg, color=control, size=undergrads, alpha=.25)) +annotate("text", label="Elite Privates", x=45000, y=1450)+geom_hline(yintercept = mean(college$sat_avg))

#add label to this line
ggplot(college) +geom_point(aes(tuition, sat_avg, color=control, size=undergrads, alpha=.25)) +annotate("text", label="Elite Privates", x=45000, y=1450)+geom_hline(yintercept = mean(college$sat_avg))+annotate("text", label="Mean SAT", x=47000, y=mean(college$sat_avg)-15)

#add vertical line showing mean tuition and add label
ggplot(college) +geom_point(aes(tuition, sat_avg, color=control, size=undergrads, alpha=.25)) +annotate("text", label="Elite Privates", x=45000, y=1450)+geom_hline(yintercept = mean(college$sat_avg))+annotate("text", label="Mean SAT", x=47000, y=mean(college$sat_avg)-15) +geom_vline(xintercept = mean(college$tuition))+ annotate("text", label="Mean Tuition",y=700, x=mean(college$tuition)+8500)

#remove panel background and legend key to be blank and rename axis and legends
ggplot(college)+
geom_point(aes(tuition, sat_avg, color=control, size=undergrads))+
annotate("text", label="Elite Privates", x=44000, y=1450)+
geom_hline(yintercept = mean(college$sat_avg))+
annotate("text", label="Mean SAT", x=44500, y=mean(college$sat_avg)-15)+
geom_vline(xintercept = mean(college$tuition))+ 
annotate("text", label="Mean Tuition",y=700, x=mean(college$tuition)+9500)+
theme(panel.background = element_blank(), legend.key = element_blank())+
scale_color_discrete(name = "Institution Type")+
scale_size_continuous(name = "Undergraduates")+
scale_x_continuous(name = "Tuition")+
scale_y_continuous(name = "SAT Score")

#adding titles
ggplot(college) +geom_bar(aes(x=region, fill=control))+theme(plot.background = element_blank())+theme(panel.background = element_blank())+scale_y_continuous(name="Number of Schools", limits=c(0,500)) + scale_fill_manual(values=c("blue","red"), guide=guide_legend(title="Institution Type", nrow = 1, label.position = "bottom", keywidth = 2.5))+theme(legend.position = "bottom")+ ggtitle("Most Colleges in the Southern U.S.", subtitle = "Source: U.S. Department of Education")


##############################################################
#############Geospatial Visualizations
#####################################################

##########Intro

#initial data
flu <- read_csv("C:/Users/Anthony.Crespo/Desktop/ggplot2/FluViewPhase8_Season_Week40-51_Data.csv")

qmap("New York, NY", zoom=10)

nyc_map <- get_map("New York, NY")
ggmap(nyc_map)

###########Geocoding Points
NYC <- geocode("New York, NY")

lynda <- geocode("Lynda.com")
ggmap(get_map(lynda))


#############Changing Map Types
nyc <- geocode("New York, NY")
ggmap(get_map(nys, maptype = "roadmap"))

nyc <- geocode("New York, NY")
ggmap(get_map(nys, maptype = "terrainmap"))
#many other map types to take a look at.

###########Plotting points on a map

#Plot NYC on a map of the US
nyc <- geocode("New York, NY")
usa <- geocode("United States")

ggmap(get_map(usa, zoom=4)) + geom_point(aes(x=lon, y=lat), color='red', data=nyc)

#plot multiple place names
placenames <- c("New York, NY", "White House", "Lynda.com", "Mt. Rushmore", "The Alamo")

locations <- geocode(placenames)

places <- tibble(name=placenames, lat=locations$lat, lon=locations$lon)

ggmap(get_map(usa, zoom=4)) + geom_point(aes(x=lon, y=lat), color='red', data=places)

#label points

ggmap(get_map(usa, zoom=4, maptype = "toner-background")) + geom_point(aes(x=lon, y=lat), color='red', data=nyc)+
  geom_text(mapping=aes(x=lon, y=lat, label=name), color="red", data=places, nudge_y = 1)
  #"nudge_y=1" is used so the name is not placed directly on top of the dot.

#############Build a map manually
states <- map_data("state")

ggplot(states, aes(x=long, y=lat, group=group)) +geom_polygon()

#tell ggplot this is map data so it renders correctly
ggplot(states, aes(x=long, y=lat, group=group)) +geom_polygon()+ coord_map()

#unclutter
ggplot(states, aes(x=long, y=lat, group=group)) +geom_polygon()+ coord_map()+ theme(axis.ticks = element_blank(),axis.text = element_blank(), axis.title = element_blank(), panel.background = element_blank())

############Create a Choropleth Map
#initial data will be the college data and the states data that is already loaded

#Color code states based on how many universities are in each state
  #First count the number of schools in each state
college_summary <- college %>%
  group_by(state) %>%
  summarize(schools=n())
  #wrangle state name data
college_summary <- college_summary %>%
  mutate(region=as.character(setNames(str_to_lower(state.name),state.abb)[as.character(state)]))

college_summary <- college_summary %>%
  mutate(region=ifelse(as.character(state)=="DC", "district of columbia", region))

#merge the college summary and states tibbles

mapdata<- merge(states, college_summary, by="region")

#create map
ggplot(mapdata)+
geom_polygon(aes(x=long, y=lat, group=group, fill=schools))+
coord_map()+ 
theme(axis.ticks = element_blank(),axis.text = element_blank(), axis.title = element_blank(), panel.background = element_blank(), plot.background = element_blank())+ scale_fill_gradient(low="beige", high="red")
















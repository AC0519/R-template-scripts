library("tidyverse")
library(leaflet)

africa_data_points <- tibble(
  lat = rnorm(26, mean = 6.9, sd = 10),
  lng = rnorm(26, mean = 17.7, sd = 10),
  size = runif(26, 5, 10),
  label = letters
)

leaflet() %>%
  addTiles() %>%
  addCircleMarkers(data = africa_data_points, 
                   radius = ~size, 
                   label = ~paste("Size: ", size,  
                                  "Label: ", letters))


capital_cities <- read_csv("data/capitals_with_locations.csv")

colnames(capital_cities)

capital_cities %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(lng = ~capital.longitude, 
                   lat = ~capital.latitude,
                   radius = ~country.population/100000000,
                   popup = ~paste("Country: ", Country, "<br/>",
                                  "Capital: ", Capital))
  
  
  
  
  
  
  
  
  
  
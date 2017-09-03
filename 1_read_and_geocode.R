library(tidyverse)
library(forcats)
library(magrittr)
library(scales)


library(ggmap) # geocode function

mydata = read_csv("r4ds_regsitrations_google_drive.csv")

locations = mydata %>%
  select(location) %>% 
  separate(location,
           into = c("first", "second"),
           sep = " and ",                               
           remove = FALSE) %>% 
  select(location = first) %>% # some people entered e.g. "UK and Switzerland", will take the first one
  mutate(location = ifelse(location == "" | is.na(location), "Missing", location))
  
geocoded = geocode(locations$location, output = "more")

#write_csv(geocoded, path = "geocoded_locations.csv")
save(geocoded, file = "geocoded_locations.rda")

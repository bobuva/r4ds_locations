library(tidyverse)
library(emoGG)
library(gridExtra)
load("geocoded_locations.rda")

mydata = read_csv("r4ds_regsitrations_google_drive.csv")

geocoded$type = mydata$type

base_map = ggplot(geocoded, aes(x = lon, y = lat)) +
  borders("world", colour="#367ABD", fill="#367ABD") +
  theme_void() +
  theme(aspect.ratio = 0.5)

learners_map = base_map + 
  geom_emoji(data = geocoded %>% filter(type == "Learner"), emoji = "1f423") +
  ggtitle("#R4DS Learners")
  

mentors_map = base_map +
  geom_emoji(data = geocoded %>% filter(type == "Mentor"), emoji = "1f414") +
  ggtitle("#R4DS Mentors")

my_map_width = 7
ggsave("learners_map.png", learners_map,  width = my_map_width, height = 0.52*my_map_width)
ggsave("mentors_map.png",  mentors_map,   width = my_map_width, height = 0.52*my_map_width)



ggsave("combined_map.png", 
       grid.arrange(learners_map, mentors_map, ncol = 1),
       width = my_map_width,
       height = 1.04*my_map_width)
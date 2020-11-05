
#step 1 - load the tidyverse package
library(tidyverse)

#step 2 - load the coronavirus data
covid_mar22 <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/03-22-2020.csv")

#step 3 - load polygons of a map of the world
world <- map_data("world")

#step 4 - make map
ggplot() +
  geom_polygon(data = world, aes(x = long, y = lat, group = group)) +
  geom_point(data = covid_mar22, aes(x = Longitude, y = Latitude,
                                     size = Confirmed),
             color = "grey50",fill = "red", alpha = 0.4, shape = 21) +
  theme_void() +
  theme(panel.background = element_rect(fill = "black")) +
  scale_size_continuous(range = c(2, 15))

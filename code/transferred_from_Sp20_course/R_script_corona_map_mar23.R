library(tidyverse)

#download the data

covid_mar23 <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/03-22-2020.csv")


world <- map_data("world")


#make the plot

ggplot() +
  geom_polygon(data = world, aes(x = long, y = lat, group = group)) +
  geom_point(data = covid_mar23, aes(x = Longitude, y = Latitude, 
                                     size = Confirmed),
             alpha = 0.4, shape = 21, color = "grey20", fill = "red") +
  theme_void() +
  theme(panel.background = element_rect(fill = "black")) +
  scale_size_continuous(range = c(1, 15))

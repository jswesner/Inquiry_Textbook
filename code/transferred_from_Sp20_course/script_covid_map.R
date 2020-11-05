library(tidyverse)

covid_mar22 <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/03-21-2020.csv")

world <- map_data("world")

ggplot() +
  geom_polygon(data = world, aes(x = long, y = lat, group = group),
               fill = "grey30") +
  geom_point(data = covid_mar22, aes(x = Longitude, y = Latitude, size = Confirmed),
             color = "grey50", fill = "red", shape = 21, alpha = 0.4) +
  theme_void() +
  theme(panel.background = element_rect(fill = "black"),
        panel.grid = element_blank()) +
  scale_size_continuous(range = c(2,15)) 

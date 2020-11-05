library(tidyverse)

mag <- Life_Expectancy_1980_1985 %>% 
  gather(sex, life_expectancy, -Location) #make a new column called "sex" that contains the categories for Male and Female. Also make a new column called "life_expectancy" that contains the values of life expectancy for each locaiton x sex combination.

#This one plots each country on the x-axis
mag %>% 
  ggplot(aes(x = Location, y = life_expectancy, color = sex)) + 
  geom_point()

#This one plots all data by just male and female
mag %>% 
  ggplot(aes(x = sex, y = life_expectancy)) + 
  geom_point(position = position_jitter(width = 0.05))

  
library(tidyverse) #call the tidyverse library

#load the data from the github website
measles <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-25/measles.csv')


#basic plot with color from Tuesday March 3, 2020
ggplot(data = measles, aes(x = mmr, y = state, color = type)) + #this line says: make a ggplot of measles with values from the mmr column on the y-axis and corresponding state values on the y-axis. Make different color for each category in the type column
  geom_point() #this line says: add data as points.









# More ways to plot it ----------------------------------------------------

#basic plot
# remove states without "-1" (i.e removes states that didn't report data) - can you see that in the code?)
ggplot(data = measles %>% filter(mmr >= 0),
       aes(x = mmr, y = state, color = type)) +
  geom_point()


#basic plot
# remove states with "-1" - can you see that in the code?)
# reorder the states from highest to lowest (can you see that in the code?)
ggplot(data = measles %>% filter(mmr >= 0),
       aes(x = mmr, y = reorder(state, mmr), color = type)) + #reorder(state,mmr) just sorts states on the y-axis by the first encountered value of mmr for that state.
  geom_point()


#basic plot
# remove states with "-1" - can you see that in the code?)
# reorder the states from highest to lowest (can you see that in the code?)
# jitter the dots to reveal overlapping values (can you see that in the code?)
ggplot(data = measles %>% filter(mmr >= 0),
       aes(x = mmr, y = reorder(state, mmr), color = type)) +
  geom_point(position = position_jitter())



#basic plot
# remove states with "-1" - can you see that in the code?)
# reorder the states from highest to lowest (can you see that in the code?)
# jitter the dots to reveal overlapping values (can you see that in the code?)
# change the size of the dots - we'll make the smaller in this case
ggplot(data = measles %>% filter(mmr >= 0),
       aes(x = mmr, y = reorder(state, mmr), color = type)) +
  geom_point(position = position_jitter(), size = .5)


#basic plot
# remove states with "-1" - can you see that in the code?)
# reorder the states from highest to lowest (can you see that in the code?)
# jitter the dots to reveal overlapping values (can you see that in the code?)
# change the size of the dots - we'll make the smaller in this case (can you see that in the code?)
# make the dots more transparent to lessen the visual impact of the few number of low vaccination schools (can you see that in the code?)
ggplot(data = measles %>% filter(mmr >= 0),
       aes(x = mmr, y = reorder(state, mmr), color = type)) +
  geom_point(position = position_jitter(), size = .5, alpha = 0.2)


#basic plot
# remove states with "-1" - can you see that in the code?)
# reorder the states from highest to lowest (can you see that in the code?)
# jitter the dots to reveal overlapping values (can you see that in the code?)
# change the size of the dots - we'll make the smaller in this case (can you see that in the code?)
# make the dots more transparent to lessen the visual impact of the few number of low vaccination schools (can you see that in the code?)
# rename the x and y axes (can you see that in the code?)
ggplot(data = measles %>% filter(mmr >= 0),
       aes(x = mmr, y = reorder(state, mmr), color = type)) +
  geom_point(position = position_jitter(), size = .5, alpha = 0.2) +
  ylab("State") +
  xlab("Vaccination Rate (measles, mumps, rubella)")


#basic plot
# remove states with "-1" - can you see that in the code?)
# reorder the states from highest to lowest (can you see that in the code?)
# jitter the dots to reveal overlapping values (can you see that in the code?)
# change the size of the dots - we'll make the smaller in this case (can you see that in the code?)
# make the dots more transparent to lessen the visual impact of the few number of low vaccination schools (can you see that in the code?)
# rename the x and y axes (can you see that in the code?)
# Change the background (can you see that in the code?)
ggplot(data = measles %>% filter(mmr >= 0),
       aes(x = mmr, y = reorder(state, mmr), color = type)) +
  geom_point(position = position_jitter(), size = .5, alpha = 0.2) +
  ylab("State") +
  xlab("Vaccination Rate (measles, mumps, rubella)") +
  theme_classic()

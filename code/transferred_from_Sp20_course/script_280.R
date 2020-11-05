#1) download data (download children_per_woman dataset from gapminder.org/data)
#2) Open R Studio and create a project (File -> New Project -> Existing Directory -> your_folder)
#3) install and load packages
install.packages("tidyverse")
install.packages("janitor")
install.packages("gapminder")
library(tidyverse)
library(janitor)
library(gapminder)

#4) Rename the data
total_fertility <- children_per_woman_total_fertility

#5) Tidy the data - i.e. reshape it from wide to long format
total_fertility_long <- total_fertility %>% gather(year, children_per_woman, -country)

#6) Plot it
ggplot(total_fertility_long, aes(x=as.numeric(year), y = children_per_woman))+
  geom_point(alpha=0.1)

#7) replot only data since 1950
tot_fert_last50 <- total_fertility_long %>% 
  filter(year >=1950)

ggplot(tot_fert_last50, aes(x=as.numeric(year), y = children_per_woman))+
  geom_point(alpha=0.1)

#8) add a boxplot
ggplot(tot_fert_last50, aes(x=as.numeric(year), y = children_per_woman, group = year))+
  geom_point(alpha=0.1) +
  geom_boxplot()

#9) summarize the median birth rate in each year
tot_fert_last50 %>% 
  group_by(year) %>% 
  summarize(median_br = median(children_per_woman)) %>% 
  print(n = Inf)

#10) plot a trendline
ggplot(tot_fert_last50, aes(x=as.numeric(year), y = children_per_woman))+
  geom_point(alpha=0.1) +
  geom_smooth(method = "lm")

#11) run a linear regression
my_model <- lm(children_per_woman ~ as.numeric(year), data = tot_fert_last50)
summary(my_model)

#12) merge data and run a regression
data(gapminder_unfiltered)
pop_br <- gapminder_unfiltered %>% merge(total_fertility_long)
pop_br1950 <- pop_br %>% filter(year==1950)

ggplot(pop_br1950, aes(x = children_per_woman, y = pop)) + 
  geom_point() +
  geom_smooth(method = "lm")

my_model2 <- lm(pop ~ children_per_woman, data = pop_br1950)
summary(my_model2)

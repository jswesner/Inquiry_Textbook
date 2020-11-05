library(tidyverse)

bmi <- read_csv("body_mass_index_bmi_men_kgperm2.csv")
life_exp <- read_csv("life_expectancy_years.csv")

bmi_d <- bmi %>% 
  gather(year,bmi,-country)

life_exp <- life_exp %>% 
  gather(year,life_exp, -country)


bmi_life <- merge(bmi_d, life_exp) %>% 
  mutate(year = as.numeric(year))

bmi_life %>% 
  mutate(year = as.numeric(year)) %>% 
  filter(year==2008) %>% 
  ggplot(aes(x=bmi, y=life_exp))+
  geom_point(size=2) +
  #geom_smooth(method="lm")+
  NULL


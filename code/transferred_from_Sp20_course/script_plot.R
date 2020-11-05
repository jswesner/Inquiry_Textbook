library(tidyverse)
library(gapminder)

gapminder

gapminder %>% 
  filter(year == 1987) %>% 
  ggplot(aes(y = lifeExp, x = gdpPercap)) +
  geom_smooth(method = "lm")+
  #geom_point()+
  theme_classic()+
  theme(text = element_text(size = 20))+
  coord_cartesian(ylim = c(30,90))+
  ylab("Life Expectancy")+
  xlab("GDP per capita")


gapminder %>% 
  filter(year == 1987) %>% 
  summarize(mean_le = mean(lifeExp),
            sd_le = sd(lifeExp),
            min_le = min(lifeExp),
            max_le = max(lifeExp))



gapminder %>% 
  filter(year == 1987) %>% 
  summarize(mean_le = mean(gdpPercap),
            sd_le = sd(gdpPercap),
            min_le = min(gdpPercap),
            max_le = max(gdpPercap))

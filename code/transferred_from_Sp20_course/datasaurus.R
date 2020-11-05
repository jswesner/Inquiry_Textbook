library(tidyverse)
library(gapminder)

#run a linear regression

d <- DatasaurusDozen


with_dots <- d %>% 
  filter(dataset == "away" | dataset == "slant_up" | dataset == "dino") %>% 
ggplot(aes(x = x, y = y)) +
  geom_smooth(method = "lm") +
  facet_wrap(~dataset, scales = "free") +
  geom_point()+
    theme_classic()+
  theme(text =element_text(size = 25))+
  coord_cartesian(ylim = c(0,100))

without_dots <- d %>% 
  filter(dataset == "away" | dataset == "slant_up" | dataset == "dino") %>% 
  ggplot(aes(x = x, y = y)) +
  geom_smooth(method = "lm") +
  facet_wrap(~dataset, scales = "free") +
  #geom_point()+
  theme_classic()+
  theme(text =element_text(size = 25))+
  coord_cartesian(ylim = c(0,100))


ggsave(with_dots, file = "with_dots.jpg", dpi = 600)
ggsave(without_dots, file = "without_dots.jpg", dpi = 600)

summary(lm(y ~ x, data = subset(d, dataset == "dino")))


br <- children_per_woman_total_fertility %>% gather(key, value, -country)

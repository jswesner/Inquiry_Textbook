library(tidyverse)
library(ggthemes)
library(cowplot)
library(patchwork)

d <- read.csv("data/children_per_woman_total_fertility.csv") %>% 
  pivot_longer(cols = -country) %>% 
  mutate(year = extract_numeric(name))


plot <- d %>% 
  filter(row_number() %% 20 == 1) %>% 
  ggplot(aes(x = year, y = value)) +
  geom_point(size = 0.4, alpha = 0.5) +
  geom_smooth() +
  labs(x = "",
       y = "Number of Children Born Per Woman",
       caption = "Data Source: www.gapminder.org") +
  theme(text = element_text(size = 9)) +
  theme_solarized()


ggsave(plot, file = "figures/bookcover_plot.jpg", dpi = 600, width = 6, height = 3.5)

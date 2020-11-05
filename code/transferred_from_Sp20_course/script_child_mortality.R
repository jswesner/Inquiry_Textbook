library(tidyverse)

child_mortality <- read_csv("child_mortality_0_5_year_olds_dying_per_1000_born.csv") %>% 
  gather(year, mort_per_1000, -country)


child_mort <- child_mortality %>% 
  group_by(year) %>% 
  filter(year <= 2020) %>% 
  summarize(mean = mean(mort_per_1000, na.rm = T)) %>%
  mutate(year = as.numeric(year)) %>% 
  ggplot(aes(x = year, y = mean/10)) +
  geom_line(size = 1.4) +
  theme_classic() +
  labs(title = "Child mortality rates (0-5 years)",
       y = "% dying before 5 years old",
       caption = "Data source: https://gapminder.org/tools")

ggsave(child_mort, file = "child_mort.jpg", dpi = 300, width = 3.5, height = 3)

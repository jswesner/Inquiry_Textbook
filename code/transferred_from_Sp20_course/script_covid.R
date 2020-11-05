library(tidyverse)
library(gapminder)
library(cowplot)


covid_mar22 <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/03-21-2020.csv")

population_total2019 <- read_csv("population_total.csv") %>% 
  mutate(Country.Region = case_when(country == "United States" ~ "US",
                                    TRUE ~ country)) %>% 
  gather(year, pop, -c(Country.Region,country)) %>% 
  filter(year == 2020) %>% 
  select(Country.Region, pop) 

prop_country <- covid_mar22 %>% left_join(population_total2019) %>% 
  group_by(Country.Region, pop) %>% 
  summarize(total_cases = sum(Confirmed)) %>% 
  mutate(correction = case_when(Country.Region == "US" ~ 200,
                                TRUE ~ 20)) %>% 
  mutate(prop_pop = total_cases/pop,
         color = case_when(Country.Region == "US" ~ "US",
                           TRUE ~ "other")) %>% 
  filter(total_cases > 0)

per_capita <- prop_country %>% 
  filter(prop_pop >=0.00001) %>% 
  ggplot(aes(x = reorder(Country.Region, total_cases*correction/pop), 
             y = total_cases*correction/pop, fill = color)) +
  geom_bar(stat = "identity", width = .8) +
  scale_fill_manual(values = c("grey20", "red")) +
  coord_flip() +
  labs(title = "COVID-19 per capita",
       caption = paste("Data: Johns Hopkins", Sys.Date())) +
  theme_classic() +
  theme(axis.title.y = element_blank(),
        text = element_text(size = 8)) +
  ylab("COVID-19 Confirmed Cases per capita") +
  guides(fill = F)


total_cases <- prop_country %>% 
  filter(prop_pop >=0.00001) %>% 
  ggplot(aes(x = reorder(Country.Region, total_cases*correction), 
             y = total_cases*correction, fill = color)) +
  geom_bar(stat = "identity", width = 0.8) +
  scale_fill_manual(values = c("grey20", "red")) +
  coord_flip() +
  labs(title = "COVID-19 total cases",
       caption = paste("Data: Johns Hopkins", Sys.Date())) +
  theme_classic() +
  theme(axis.title.y = element_blank(),
        text = element_text(size = 8)) +
  ylab("COVID-19 Confirmed Cases total") +
  guides(fill = F)

plot_COVID19 <- plot_grid(per_capita, total_cases)
plot_COVID19

ggsave(plot_COVID19, file = "plot_COVID19.pdf", width = 8, height = 10)

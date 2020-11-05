library(tidyverse)
library(janitor)
library(lubridate)

population_total2019 <- read_csv("population_total.csv") %>% 
  mutate(country_region = case_when(country == "United States" ~ "US",
                                    TRUE ~ country)) %>% 
  gather(year, pop, -c(country_region,country)) %>% 
  filter(year == 2020) %>% 
  select(country_region, pop) 

covid_time <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv") %>% 
  clean_names() %>% 
  gather(date, confirmed_cases, c(-province_state, -country_region, -lat,-long)) %>% 
  left_join(population_total2019) %>% 
  mutate(date = mdy(str_sub(date, 2, 20)))

covid_time %>% 
  group_by(country_region, date, pop) %>% 
  summarize(confirmed_cases = sum(confirmed_cases)) %>% 
  mutate(confirmed_percapita = confirmed_cases/pop,
         color = case_when(country_region == "China" ~ "China",
                           country_region == "US" ~ "US",
                           country_region == "Italy" ~ "Italy",
                           TRUE ~ "other")) %>% 
  group_by(country_region) %>% 
  # filter(country_region == "China") %>% 
  mutate(lag_time = lag(confirmed_cases),
         confirmed_perday = confirmed_cases - lag_time,
         correction = case_when(country_region == "US" ~ 1000,
                                TRUE ~ 100)) %>% 
  ggplot(aes(x = date, y = confirmed_cases)) +
  geom_line(aes(group = country_region,
                color = color)) +
  scale_color_manual(values = c("red", "green","grey80","purple")) +
  geom_smooth() +
  scale_y_log10() +
  NULL




covidts <- covid_time %>% 
  filter(country_region == "US")

tsData = ts(covidts$confirmed_cases, start = c(2020,22), frequency = 365)

arima(tsData)



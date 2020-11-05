library(tidyverse)
library(gapminder)

gapminder
as_tibble(data_all)

pop <- read_csv("C:/Users/Jeff.Wesner/OneDrive - The University of South Dakota/USD/R_teaching/population_total.csv")

pop_g <- pop %>% 
  gather(year,pop,-country)

cont <- gapminder %>% 
  select(country, continent) %>% 
  distinct(country, continent)

merge(pop_g,cont)

install.packages("countrycode")
library(countrycode)
df <- data.frame(country = c("Afghanistan",
                             "Algeria",
                             "USA",
                             "France",
                             "New Zealand",
                             "Fantasyland"))

countries <- data.frame(country = unique(pop_g$country))

countries$ioc <- countrycode(sourcevar = pop$country,
                            origin = "country.name",
                            destination = "genc3c")


iocs <- continents %>% 
  select(Continent_Name, Three_Letter_Country_Code) %>% 
  mutate(ioc = Three_Letter_Country_Code,
         continent = Continent_Name) %>% 
  select(continent, ioc)

temp <- countries %>% 
  select(country, ioc) %>% 
  right_join(iocs) %>% 
  select(country, continent) %>% 
  drop_na() %>% 
  filter(country != "Palestine")

child_gb <- merge(child_g, temp)

continent <- temp %>% 
  left_join(child_g) 

child_g <- child %>% 
  gather(year, br, -country)

continent %>% 
  distinct(continent, country)

continent %>% 
  filter(year<=2019)
  ggplot(aes(x = year, y = pop))+
  geom_point(size = 0.1)+
  facet_wrap(~continent)


write.csv(temp, file = "continents.csv")
write.csv(birth_rate_with_continent, file = "birth_rate_with_contine")

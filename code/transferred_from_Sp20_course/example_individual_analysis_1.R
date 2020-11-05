library(tidyverse)

tuition_cost <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/tuition_cost.csv')

# Where does USD rank in tuition? -----------------------------------------
#in-state
tuition_cost %>% 
  filter(name == "University of South Dakota") %>%  #in-state_tuition is 9061
  select(in_state_tuition)

#out-of-state
tuition_cost %>% 
  summarize(mean = mean(in_state_tuition),
            sd = sd(in_state_tuition))     # average tuition is 16491 with sd of 14774

#out of state
tuition_cost %>% 
  filter(name == "University of South Dakota") %>%  #in-state_tuition is 9061
  select(out_of_state_tuition)

tuition_cost %>% 
  summarize(mean = mean(out_of_state_tuition),
            sd = sd(out_of_state_tuition))     # average tuition is 16491 with sd of 14774







# Most and least expensive schools and overall average ----------------------------------------
#least expensive
tuition_cost %>% 
  slice(which.min(out_of_state_tuition)) %>% 
  select(name,out_of_state_tuition)    #Haskell indian Nations University $480 per year

#most expensive
tuition_cost %>% 
  slice(which.max(out_of_state_tuition)) %>% 
  select(name, out_of_state_tuition)   #Columbia University $59,985 per year






# Plot of tuition by school type ------------------------------------------
#first gather so that in-state and out-of state are in one column with an identifier
#then create a column that is used to color code USD.
tuition_gathered <- tuition_cost %>% gather(tuition_type, dollars_per_year, 
                                            c("in_state_tuition", "out_of_state_tuition")) %>% 
  mutate(USD = case_when(name == "University of South Dakota" ~ "USD",
                         TRUE ~ "Other")) 

plot_tuition <- ggplot(data = tuition_gathered %>% filter(degree_length == "4 Year",
                                          type != "Other"), 
       aes(x = reorder(state_code,-dollars_per_year), y = dollars_per_year,
           color = USD)) +
  geom_point(size = 1) +
  facet_grid(tuition_type~type) +
  xlab("") +
  ylab("US Dollars per year") +
  theme_bw() +
  theme(axis.text.x = element_text(size = 5, angle = 90, hjust = 1))

ggsave(plot_tuition, file = "plot_tuition.jpg", dpi = 300, width = 7.5, height = 3)

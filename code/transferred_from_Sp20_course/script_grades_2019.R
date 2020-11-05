library(tidyverse)
library(janitor)
library(readxl)

grades_raw <- read_csv("2020 Spring - Inquiry & Analysis in Biology (BIOL-280-U15)_GradesExport_2020-05-13-17-14.csv") %>% 
  clean_names() %>% 
  select(-end_of_line_indicator) %>% 
  mutate(percentage = calculated_final_grade_numerator/calculated_final_grade_denominator,
         letter_grade = cut(percentage, breaks = c(1.5,0.88,0.78,0.68,0.58,0),
                            labels = c("F","D","C","B","A")),
         last_first = paste(last_name,", ",first_name))

grades_raw %>% 
  ggplot(aes(x = reorder(last_first,percentage), y = percentage, color = letter_grade)) +
  geom_point() +
  coord_flip() +
  ylim(0,1)

grades_2020 <- read_csv("2020 Spring - Inquiry & Analysis in Biology (BIOL-280-U15)_GradesExport_2020-05-13-17-14.csv") %>% 
  clean_names() %>% 
  select(-end_of_line_indicator) %>% 
  gather(item, points, c(-org_defined_id, -last_name, -first_name)) %>% 
  mutate(out_of = parse_number(str_sub(item, -20,-18)),
         out_of = case_when(is.na(out_of) ~ parse_number(item),
                            TRUE ~ out_of),
         item_general = str_sub(item, 1, 10),
         out_of = case_when(grepl("bonus", item) ~ 0,
                            grepl("seminar", item) ~ 0,
                            grepl("Seminar", item) ~ 0,
                            grepl("BONUS", item) ~ 0,
                            TRUE ~ out_of)) %>% 
  rename(id = org_defined_id) %>% 
  drop_na(out_of)
  # separate(item, c("class", "item","max_points"))



final_grades2020 <- grades_2020 %>% 
  mutate(max_points = out_of,
         max_points = if_else(grepl("bonus",item),0,max_points)) %>%
  replace_na(list(points = 0, max_points = 0)) %>% 
  group_by(id, item_general) %>% 
  arrange(desc(points)) %>% 
  slice(1:5) %>% 
  ungroup() %>% 
  group_by(id, last_name, first_name) %>% 
  summarize(max_points = sum(max_points),
            earned_points = sum(points)) %>% 
  mutate(percentage = earned_points/max_points,
         letter_grade = cut(percentage, breaks = c(1.5,0.87,0.77,0.67,0.57,0),
             labels = c("F","D","C","B","A")),
         last_first = paste(last_name,", ",first_name)) %>% as_tibble()


ggplot(final_grades2020, aes(x = reorder(last_first, percentage), y = percentage, color = letter_grade)) + 
  geom_point()+
  coord_flip()+
  ylim(0,1)


teams <-  grades_2020 %>% select(last_first, section,team) %>% 
  distinct(last_first, section, team)

final_grades <- right_join(teams, final_grades2020)

write.csv(final_grades, file = "final_grades2020.csv")

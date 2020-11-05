library(tidyverse)

classlist_2020 <- X2020_classlist %>% 
  separate(emails, c("name","domain"), sep = "@", remove = F) %>% 
  select(-domain)

write.csv(classlist_2020, file = "classlist_2020.csv")

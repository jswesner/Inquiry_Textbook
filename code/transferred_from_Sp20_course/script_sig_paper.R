library(tidyverse)
library(ggpubr)
library(simglm)

non_smokers <- rnorm(100, 45.8, 35.1 )
smokers <- rnorm(100, 34.2, 18.5)

aioki_data <- data.frame(non_smokers = non_smokers, 
                         smokers = smokers) %>% 
  gather()

ggplot(data = aioki_data, aes(x = key, y = value)) +
  geom_point(position = position_jitter(width = 0.1)) +
  stat_summary(fun.y = mean, geom = "point", size = 4,
               color = "red") +
  stat_summary(fun.data = mean_sd, geom = "errorbar") +
  ylab("beta_carotene") +
  xlab("treatments")

library(tidyverse)
library(ggpubr)
library(simglm)

set.seed(449)
westriver_200 = rnorm(200, 87, 5)
eastriver_200 = rnorm(200, 86, 5)
westriver_50 = rnorm(50, 87, 5)
eastriver_50 = rnorm(50, 86, 5)
westriver_10 = rnorm(10, 87, 5)
eastriver_10 = rnorm(10, 86, 5)

fake_dat <- as.data.frame(cbind(westriver_10 = westriver_10[1:200], westriver_200,
                  eastriver_10 = eastriver_10[1:200], eastriver_200,
                  westriver_50 = westriver_50[1:200],
                  eastriver_50 = eastriver_50[1:200])) %>% 
  gather() %>% 
  separate(key, c("group", "reps")) %>% 
  mutate(reps = as.numeric(reps))

means = data.frame(group = c("eastriver", "westriver"),
                   y = c(86,87),
                   sd = 5)

plot_sig <- fake_dat %>% 
ggplot(aes(x = group, y = value))+
  # geom_point(position = position_jitter(width = 0.12),shape = 1, size = 2) +
  facet_wrap(~reps) +
  geom_crossbar(data = means, aes(x = group, y = y,
                                    ymin = y-sd, ymax = y+sd),
                  color = "purple", size = 1) +
  stat_compare_means(method = "anova", size = 7) +
  # stat_summary(fun.y = mean, geom = "point", size = 4, 
  #              color = "red") + 
  # # stat_summary(fun.data = mean_se, geom = "errorbar") + 
  # stat_summary(geom = "errorbar", fun.data = mean_sd, 
  #              color = "red", position = "dodge") +
  ylim(70,105) +
  ylab("Score on quiz 5") +
  theme(axis.title.x = element_blank(), 
        text = element_text(size = 25))

ggsave(plot_sig, file = "plot_sig.svg", dpi = 400, width = 10, height = 6)



set.seed(449)
plot_sigse <- fake_dat %>% 
  ggplot(aes(x = group, y = value))+
  geom_point(position = position_jitter(width = 0.12),shape = 1, size = 2) +
  facet_wrap(~reps) +
  # geom_crossbar(data = means, aes(x = group, y = y,
  #                                 ymin = y-sd, ymax = y+sd),
  #               color = "purple", size = 1) +
  stat_compare_means(method = "anova", size = 7) +
  stat_summary(fun.y = mean, geom = "point", size = 4,
               color = "red") +
  stat_summary(fun.data = mean_se, geom = "errorbar",
               color = "red") +
  # stat_summary(geom = "errorbar", fun.data = mean_sd,
  #              color = "red", position = "dodge") +
  ylim(70,105) +
  ylab("Score on quiz 5") +
  theme(axis.title.x = element_blank(), 
        text = element_text(size = 25))

ggsave(plot_sigse, file = "plot_sigse.svg", dpi = 400, width = 10, height = 6)



set.seed(449)
plot_sigsd <- fake_dat %>% 
  ggplot(aes(x = group, y = value))+
  geom_point(position = position_jitter(width = 0.12),shape = 1, size = 2) +
  facet_wrap(~reps) +
  # geom_crossbar(data = means, aes(x = group, y = y,
  #                                 ymin = y-sd, ymax = y+sd),
  #               color = "purple", size = 1) +
  stat_compare_means(method = "anova", size = 7) +
  stat_summary(fun.y = mean, geom = "point", size = 4,
               color = "red") +
  # stat_summary(fun.data = mean_se, geom = "errorbar",
  #              color = "red") +
  stat_summary(geom = "errorbar", fun.data = mean_sd,
               color = "red", position = "dodge") +
  ylim(70,105) +
  ylab("Score on quiz 5") +
  theme(axis.title.x = element_blank(), 
        text = element_text(size = 25))

ggsave(plot_sigsd, file = "plot_sigsd.svg", dpi = 400, width = 10, height = 6)




set.seed(449)
westriver_200b = rnorm(200, 87, 10)
eastriver_200b = rnorm(200, 66, 15)
westriver_50b = rnorm(50, 87, 5)
eastriver_50b = rnorm(50, 66, 5)
westriver_10b = rnorm(10, 87, 5)
eastriver_10b = rnorm(10, 86, 5)

fake_datb <- as.data.frame(cbind(westriver_10b = westriver_10b[1:200], westriver_200b,
                                eastriver_10b = eastriver_10b[1:200], eastriver_200b,
                                westriver_50b = westriver_50b[1:200],
                                eastriver_50b = eastriver_50b[1:200])) %>% 
  gather() %>% 
  separate(key, c("group", "reps")) %>% 
  mutate(reps = as.numeric(str_replace(reps, "b", "")))

meansb = data.frame(group = c("eastriver", "westriver"),
                   y = c(86,87),
                   sd = 5)

plot_sigb <- fake_datb %>% 
  ggplot(aes(x = group, y = value))+
  geom_point(position = position_jitter(width = 0.12),shape = 1, size = 2) +
  facet_wrap(~reps) +
  stat_compare_means(method = "anova", size = 7) +
  stat_summary(fun.y = mean, geom = "point", size = 4,
               color = "red") +
  # stat_summary(fun.data = mean_se, geom = "errorbar") + 
  stat_summary(geom = "errorbar", fun.data = mean_sd,
               color = "red", position = "dodge") +
  ylim(70,105) +
  ylab("Score on quiz 5") +
  theme(axis.title.x = element_blank(), 
        text = element_text(size = 25))

plot_sigb

ggsave(plot_sigb, file = "plot_sigb.svg", dpi = 400, width = 10, height = 6)





# Regression --------------------------------------------------------------
set.seed(449)

int = 10
sd = 0.05


sim_arguments <- list(
  formula = y ~ 1 + x,
  fixed = list(x = list(var_type = 'continuous', mean = 180, sd = 30)),
  error = list(variance = 25),
  sample_size = 10,
  reg_weights = c(int, sd))

test10 <- simulate_fixed(data = NULL, sim_arguments) %>%
  simulate_error(sim_arguments) %>%
  generate_response(sim_arguments) %>% 
  select(x,y) %>% 
  mutate(group = 10)


sim_arguments <- list(
  formula = y ~ 1 + x,
  fixed = list(x = list(var_type = 'continuous', mean = 180, sd = 30)),
  error = list(variance = 25),
  sample_size = 50,
  reg_weights = c(int, sd))

test50 <- simulate_fixed(data = NULL, sim_arguments) %>%
  simulate_error(sim_arguments) %>%
  generate_response(sim_arguments) %>% 
  select(x,y) %>% 
  mutate(group = 50)



sim_arguments <- list(
  formula = y ~ 1 + x,
  fixed = list(x = list(var_type = 'continuous', mean = 180, sd = 30)),
  error = list(variance = 25),
  sample_size = 100,
  reg_weights = c(int, sd))

test100 <- simulate_fixed(data = NULL, sim_arguments) %>%
  simulate_error(sim_arguments) %>%
  generate_response(sim_arguments) %>% 
  select(x,y) %>% 
  mutate(group = 100)


fake_reg <- bind_rows(test10, test50, test100)

plot_sig_rega <- fake_reg %>% 
  ggplot(aes(x = x, y = y)) +
  # geom_smooth(method = "lm") +
  geom_point() +
  # stat_cor() +
  facet_wrap(~group) +
  xlab("Number of drinks per year") +
  ylab("Health score") +
  theme(text = element_text(size = 25))

plot_sig_regb <- fake_reg %>% 
  ggplot(aes(x = x, y = y)) +
  geom_smooth(method = "lm") +
  geom_point() +
  stat_cor() +
  facet_wrap(~group) +
  xlab("Number of drinks per year") +
  ylab("Health score") +
  theme(text = element_text(size = 25))

ggsave(plot_sig_rega, file = "plot_sig_rega.svg", dpi = 400, width = 10, height = 6)

ggsave(plot_sig_regb, file = "plot_sig_regb.svg", dpi = 400, width = 10, height = 6)


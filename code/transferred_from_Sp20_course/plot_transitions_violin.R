d_2 <- as_tibble(d) %>% 
  mutate(a_1 = 100,
         a_2 = 100*a_bioavail,
         b = a_2*b_insect_trophic,
         c = b*c_insect_metamorph,
         d = c*d_bird_trophic,
         f_egg_concentration = d*e_egg_transfer) %>% 
  select(a_1, a_2,b,c,d,f_egg_concentration) %>% 
  mutate(iteration = 1:length(d)) %>% 
  rename(inflow = a_1,
         bioavailable = a_2,
         larval_uptake = b,
         metamorphosis_retention = c,
         bird_consumption = d,
         egg_transfer = f_egg_concentration) %>% 
  pivot_longer(cols = -iteration,
               names_to = "step",
               values_to = "proportion") %>% 
  mutate(step = fct_relevel(step, c("inflow","bioavailable",
                                    "larval_uptake","metamorphosis_retention",
                                    "bird_consumption")),
         model = "before")

d_2 %>% 
  ggplot(aes(x = step, y = proportion))+
  geom_point(shape = 1)+
  geom_line(aes(group = iteration), alpha = 0.1)+
  geom_violin()+
  theme_classic()+
  ylab("Se retained through each transition") + 
  xlab("")




bioavail_2 <- data.frame(bioavail_2 = rbeta(1000,300,1000))
d$bioavail_2 <- bioavail_2$bioavail_2

d_3 <- as_tibble(d) %>% 
  mutate(a_1 = 100,
         a_2 = 100*bioavail_2,
         b = a_2*b_insect_trophic,
         c = b*c_insect_metamorph,
         d = c*d_bird_trophic,
         f_egg_concentration = d*e_egg_transfer) %>% 
  select(a_1, a_2,b,c,d,f_egg_concentration) %>% 
  mutate(iteration = 1:length(d)) %>% 
  rename(inflow = a_1,
         bioavailable = a_2,
         larval_uptake = b,
         metamorphosis_retention = c,
         bird_consumption = d,
         egg_transfer = f_egg_concentration) %>% 
  pivot_longer(cols = -iteration,
               names_to = "step",
               values_to = "proportion") %>% 
  mutate(step = fct_relevel(step, c("inflow","bioavailable",
                                    "larval_uptake","metamorphosis_retention",
                                    "bird_consumption")),
         model = "after")


both <- rbind(d_3,d_2) %>% 
  mutate(model = fct_relevel(model, c("before","after")))

both_plot <- both %>% 
  ggplot(aes(x = step, y = proportion))+
  geom_point(shape = 1)+
  geom_line(aes(group = iteration), alpha = 0.1)+
  geom_violin()+
  theme_classic()+
  ylab("Se retained through each transition") + 
  xlab("") +
  facet_wrap(~model) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


ggsave(both_plot, file = "both_plot.jpg")

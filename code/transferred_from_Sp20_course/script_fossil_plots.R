# Energy_production -------------------------------------------------------



fossil_fuel %>% 
  filter(energy_source == "Natural Gas" | energy_source == "Crude Oil" | energy_source == "Coal") %>% 
  ggplot(aes(x = reorder(state, -production), y = production, fill = energy_source))+
  geom_bar(stat = "identity", position = "dodge")+
  #facet_wrap(~energy_source)+
  scale_fill_brewer(type = "qual", palette = 3)+
  #coord_flip()+
  theme_minimal()+
  theme(strip.text = element_text(size = 20),
        axis.text.x = element_text(size = 8),
        axis.title.x = element_blank(),
        legend.position = "top",
        legend.title = element_blank()) + 
  ylab("trillion btu") +
  ggtitle("Energy Production")+
  ylim(c(0,10000))+
  NULL



fossil_fuel %>% 
  filter(energy_source != "Natural Gas" & energy_source != "Crude Oil" & energy_source != "Coal" &
           energy_source != "Electric") %>% 
  ggplot(aes(x = reorder(state, -production), y = production, fill = energy_source))+
  geom_bar(stat = "identity", position = "dodge")+
  #facet_wrap(~energy_source)+
  scale_fill_brewer(type = "qual", palette = 5)+
  #coord_flip()+
  theme_minimal()+
  theme(strip.text = element_text(size = 20),
        axis.text.x = element_text(size = 8),
        axis.title.x = element_blank(),
        legend.position = "top",
        legend.title = element_blank()) + 
  ylab("trillion btu") +
  ggtitle("Energy Production")+
  ylim(c(0,10000))+
  NULL



fossil_fuel %>% 
  filter(state == "TX") %>% 
  ggplot(aes(x = reorder(state, -production), y = production, fill = energy_source))+
  geom_bar(stat = "identity", position = "dodge")+
  #facet_wrap(~energy_source)+
  scale_fill_brewer(type = "qual", palette = 3)+
  #coord_flip()+
  theme_minimal()+
  theme(strip.text = element_text(size = 20),
        axis.text.x = element_text(size = 20),
        axis.title.x = element_blank(),
        legend.position = "top",
        legend.title = element_blank()) + 
  ylab("trillion btu") +
  ggtitle("Energy Production in Texas")+
  ylim(c(0,10000))+
  NULL


fossil_fuel %>% 
  filter(state == "SD") %>% 
  ggplot(aes(x = reorder(state, -production), y = production, fill = energy_source))+
  geom_bar(stat = "identity", position = "dodge")+
  #facet_wrap(~energy_source)+
  scale_fill_brewer(type = "qual", palette = 3)+
  #coord_flip()+
  theme_minimal()+
  theme(strip.text = element_text(size = 20),
        axis.text.x = element_text(size = 20),
        axis.title.x = element_blank(),
        legend.position = "top",
        legend.title = element_blank()) + 
  ylab("trillion btu") +
  ggtitle("Energy Production in South Dakota")+
  #ylim(c(0,10000))+
  NULL



# Energy Consumption ------------------------------------------------------


fossil_fuel %>% 
  filter(energy_source == "Natural Gas" | energy_source == "Crude Oil" | energy_source == "Coal") %>% 
  ggplot(aes(x = reorder(state, -production), y = consumption, fill = energy_source))+
  geom_bar(stat = "identity", position = "dodge")+
  #facet_wrap(~energy_source)+
  scale_fill_brewer(type = "qual", palette = 3)+
  #coord_flip()+
  theme_minimal()+
  theme(strip.text = element_text(size = 20),
        axis.text.x = element_text(size = 8),
        axis.title.x = element_blank(),
        legend.position = "top",
        legend.title = element_blank()) + 
  ylab("trillion btu") +
  ggtitle("Energy Consumption")+
  ylim(c(0,10000))+
  NULL



fossil_fuel %>% 
  filter(energy_source != "Natural Gas" & energy_source != "Crude Oil" & energy_source != "Coal" &
           energy_source != "Electric") %>% 
  ggplot(aes(x = reorder(state, -production), y = consumption, fill = energy_source))+
  geom_bar(stat = "identity", position = "dodge")+
  #facet_wrap(~energy_source)+
  scale_fill_brewer(type = "qual", palette = 5)+
  #coord_flip()+
  theme_minimal()+
  theme(strip.text = element_text(size = 20),
        axis.text.x = element_text(size = 8),
        axis.title.x = element_blank(),
        legend.position = "top",
        legend.title = element_blank()) + 
  ylab("trillion btu") +
  ggtitle("Energy Consumption")+
  ylim(c(0,10000))+
  NULL



fossil_fuel %>% 
  filter(state == "TX") %>% 
  ggplot(aes(x = reorder(state, -production), y = consumption, fill = energy_source))+
  geom_bar(stat = "identity", position = "dodge")+
  #facet_wrap(~energy_source)+
  scale_fill_brewer(type = "qual", palette = 3)+
  #coord_flip()+
  theme_minimal()+
  theme(strip.text = element_text(size = 20),
        axis.text.x = element_text(size = 20),
        axis.title.x = element_blank(),
        legend.position = "top",
        legend.title = element_blank()) + 
  ylab("trillion btu") +
  ggtitle("Energy Consumption in Texas")+
  ylim(c(0,10000))+
  NULL


fossil_fuel %>% 
  filter(state == "SD") %>% 
  ggplot(aes(x = reorder(state, -production), y = consumption, fill = energy_source))+
  geom_bar(stat = "identity", position = "dodge")+
  #facet_wrap(~energy_source)+
  scale_fill_brewer(type = "qual", palette = 3)+
  #coord_flip()+
  theme_minimal()+
  theme(strip.text = element_text(size = 20),
        axis.text.x = element_text(size = 20),
        axis.title.x = element_blank(),
        legend.position = "top",
        legend.title = element_blank()) + 
  ylab("trillion btu") +
  ggtitle("Energy Consumption in South Dakota")+
  #ylim(c(0,10000))+
  NULL

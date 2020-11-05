
library(tidyverse)


#renaming all data sets after importing

mmr <- maternal_mortality_ratio_per_100000_live_births
doctors <- medical_doctors_per_1000_people
ghs <- government_health_spending_per_person_us
#continents is fine as continents


#gathering data sets from wide to long format for merging and filtering

mmr_long <- mmr %>% 
  gather(year, "MMR", -country)

doctors_long <- doctors %>% 
  gather(year, "Num_Doctors", -country)

ghs_long <- ghs %>% 
  gather(year, "Gov_Spending", -country)

#continents is already in the long format



#merging all four data sets into one mega-data set

mmr_doctor <- merge(mmr_long, doctors_long)
mmr_doctor_ghs <- merge(mmr_doctor, ghs_long)
full_data <- merge(mmr_doctor_ghs, continents)


#filtering down to three years (2000, 2005, 2010) and two continents (Africa and Europe) for comparison
filtered_data <- full_data %>% 
  filter(continent == "Africa" | continent == "Europe") %>% 
  filter(year == "2000" | year == "2005" | year == "2010")



#running a linear model:
#In theory I feel like I should be able to run one big model with all four variables (government spending, number of doctors, continent, and year), but I have no idea how to interpret the output nor if it is accurate with this many variables

Big_Model <- lm(MMR ~ Gov_Spending + Num_Doctors + continent + year, data=filtered_data)
summary(Big_Model)


gov <- lm(log(MMR) ~ log(Gov_Spending), data= subset(filtered_data, year == 2010))
doc <- lm(MMR ~ Num_Doctors, data= subset(filtered_data, year == 2010))

summary(gov)
summary(doc)

filtered_data %>% 
  ggplot(aes(x = log(Gov_Spending), y = log(MMR))) +
  geom_point() +
  facet_wrap(~year) +
  geom_smooth(method = "lm") 


#I started doubting everything after first I did separate out Africa and Europe and tried to run year as one of the variables as well as just one of the continuous variables (government spending or number of doctors) and obtained different results than when I filtered out more data sets by year and ran a bunch of small models I put below.


#filtering data
mmr_africa <- filtered_data %>% 
  filter(continent == "Africa")

mmr_europe <- filtered_data %>% 
  filter(continent == "Europe")

mmr_africa_2000 <- mmr_africa %>% 
  filter(year == "2000")
mmr_africa_2005 <- mmr_africa %>% 
  filter(year == "2005")
mmr_africa_2010 <- mmr_africa %>% 
  filter(year == "2010")

#Slightly larger models
Africa_MMR_Model_GHS <- lm(MMR ~ Gov_Spending + year, data = mmr_africa)
summary(Africa_MMR_Model_GHS)

Africa_MMR_Model_Doc <- lm(MMR~Num_Doctors+year, data=mmr_africa)
summary(Africa_MMR_Model_Doc)

#What I though the interpretation of Africa_MMR_Model_GHS output was:
#First, the (Intercept) Estimate: When government health spending per person equals zero, the maternal mortality 
#ratio in Africa will equal 688.18 +/- 42.96. 
#Next, the Gov_Spending Estimate: In Africa in the year 2000, as the average health expenditure per person that had been
#paid for by government entitites in US dollars increased by one dollar, the maternal mortality ratio decreased by
#1.59 +/- 0.297.
#Next, the Gov_Spending Estimate: In Africa in the year 2005, as the average health expenditure per person that had been
#paid for by government entitites in US dollars increased by one dollar, the maternal mortality ratio decreased by
#92.39 +/- 60.74.
#Next, the Gov_Spending Estimate: In Africa in the year 2010, as the average health expenditure per person that had been
#paid for by government entitites in US dollars increased by one dollar, the maternam mortality ratio decreased by
#123.78 +/- 62.33.




#Tons of small models
Africa_MMR_Model_GHS_2000 <- lm(MMR~Gov_Spending, data=mmr_africa_2000)
summary(Africa_MMR_Model_GHS_2000)

Africa_MMR_Model_GHS_2005 <- lm(MMR~Gov_Spending, data=mmr_africa_2005)
summary(Africa_MMR_Model_GHS_2005)

Africa_MMR_Model_GHS_2010 <- lm(MMR~Gov_Spending, data=mmr_africa_2010)
summary(Africa_MMR_Model_GHS_2010)



Africa_MMR_Model_Doc_2000 <- lm(MMR~Num_Doctors, data=mmr_africa_2000)
summary(Africa_MMR_Model_Doc_2000)

Africa_MMR_Model_Doc_2005 <- lm(MMR~Num_Doctors, data=mmr_africa_2005)
summary(Africa_MMR_Model_Doc_2005)

Africa_MMR_Model_Doc_2010 <- lm(MMR~Num_Doctors, data=mmr_africa_2010)
summary(Africa_MMR_Model_Doc_2010)



Africa_MMR_Model_GHS_Doc_2000 <- lm(MMR~Gov_Spending+Num_Doctors, data=mmr_africa_2000)
summary(Africa_MMR_Model_GHS_Doc_2000)

Africa_MMR_Model_GHS_Doc_2005 <- lm(MMR~Gov_Spending+Num_Doctors, data=mmr_africa_2005)
summary(Africa_MMR_Model_GHS_Doc_2005)

Africa_MMR_Model_GHS_Doc_2010 <- lm(MMR~Gov_Spending+Num_Doctors, data=mmr_africa_2010)
summary(Africa_MMR_Model_GHS_Doc_2010)


#Tons of plot codes that might be helpful in looking at the data

ggplot(mmr_africa, aes(Gov_Spending, MMR))+
  geom_point()+
  geom_smooth(method="lm")+
  facet_wrap(~year)+
  ylim(0,2500)

#keeping continents on the same plot and dividing out by year - scatter plots to see individual countries
ggplot(filtered_data, aes(Num_Doctors, MMR, color=continent))+
  geom_point()+
  facet_wrap(~year)

ggplot(filtered_data, aes(Gov_Spending, MMR, color=continent))+
  geom_point()+
  facet_wrap(~year)

#keeping continents on the same plot and dividing out by year - box plots to compare means and sd of continents
ggplot(filtered_data, aes(Num_Doctors, MMR, fill=continent))+
  geom_boxplot()+
  facet_wrap(~year)

ggplot(filtered_data, aes(Gov_Spending, MMR, fill=continent))+
  geom_boxplot()+
  facet_wrap(~year)

#keeping years on the same plot and dividing out by continents - scatter plots to see individual years
ggplot(filtered_data, aes(Num_Doctors, MMR, color=year))+
  geom_point()+
  facet_wrap(~continent)

ggplot(filtered_data, aes(Gov_Spending, MMR, color=year))+
  geom_point()+
  facet_wrap(~continent)

#keeping years on the same plot and dividing out by continents - box plots to compare means and sd of years
ggplot(filtered_data, aes(Num_Doctors, MMR, fill=year))+
  geom_boxplot()+
  facet_wrap(~continent)

ggplot(filtered_data, aes(Gov_Spending, MMR, fill=year))+
  geom_boxplot()+
  facet_wrap(~continent)



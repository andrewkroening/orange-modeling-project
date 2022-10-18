packages <- (c("tidyverse", "stargazer", "ggfortify", "caTools", "car"))

# Install packages not yet installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Packages loading
invisible(lapply(packages, library, character.only = TRUE))

le <- read.csv('~/Desktop/orange-modeling-project/_00_Datasets/Life_Expectancy_Data.csv') %>%
  filter(Year == 2014)

q1_cols <- c('Country', 'Status', 'Population', 'Life.expectancy', 'percentage.expenditure', 'Hepatitis.B', 'Measles', 'Polio', 'HIV.AIDS', 'Diphtheria', 'GDP', 'Schooling', 'Income.composition.of.resources')

le_q1 <- le[,q1_cols]

le_q1_sum <- summary(le_q1)
le_q1_sum

names(le_q1)[names(le_q1) == 'Income.composition.of.resources'] <- 'Income'
names(le_q1)[names(le_q1) == 'percentage.expenditure'] <- 'Expenditure'

# count rows with na values
le_q1 %>% summarise_all(~ sum(is.na(.)))

# We are missing 41 population figures, 10 Hep.B, 28 GDPs, 10 Schools, and 10 Incomes

# Trying a tidyverse plot of some sort

theme_set(
  theme_bw() +
    theme(legend.position = "top")
)

le_q1.gathered <- le_q1 %>%
  as_tibble() %>%
  gather(key = "variable", value = "value",
         -Status, -Life.expectancy)

head(le_q1.gathered)

ggplot(le_q1.gathered, aes(x = value, y = Life.expectancy)) +
  geom_point() +
  facet_wrap(~variable)+
  scale_color_viridis_d()



# drop NA values
le_q1_clean <- le_q1 %>%
  drop_na()

le_q1_clean_sum <- summary(le_q1_clean)
le_q1_clean_sum

le_q1_clean.gathered <- le_q1_clean %>%
  as_tibble() %>%
  gather(key = "variable", value = "value",
         -Status, -Life.expectancy)

head(le_q1_clean.gathered)

ggplot(le_q1_clean.gathered, aes(x = value, y = Life.expectancy)) +
  geom_point() +
  facet_wrap(~variable)+
  scale_color_viridis_d()

# Good plots
plot(le_q1_clean$Income, le_q1_clean$Life.expectancy)

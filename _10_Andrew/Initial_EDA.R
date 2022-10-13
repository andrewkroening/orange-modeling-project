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

q1_cols <- c('Country', 'Year', 'Status', 'Population', 'Life.expectancy', 'Percentage.expenditure', 'Hepatitis.B', 'Measles', 'Polio', 'HIV.AIDS', 'Diptheria', 'GDP', 'Schooling', 'Income.composition.of.resources')

q1_test <- c('Country', 'Year')

le_q1 <- le[,q1_test]

le$Life.expectancy

le_sum <- summary(le)
le_sum

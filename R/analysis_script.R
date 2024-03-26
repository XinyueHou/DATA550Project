library(dplyr)
library(tidyverse)
library(readr)

# Load the data
dhds_data <- read.csv("C:/Users/Monica/Downloads/Disability_and_Health_Data_System__DHDS__20240219.csv")

## Analysis & images
# Prevalence of Disabilities by State
state_prevalence <- dhds_data %>%
  group_by(LocationDesc, Indicator) %>%
  summarise(AveragePrevalence = mean(Data_Value, na.rm = TRUE), .groups = 'drop') %>%
  arrange(desc(AveragePrevalence))

# Overall Distribution of Disability Types
disability_distribution <- dhds_data %>%
  group_by(Indicator) %>%
  summarise(TotalPrevalence = sum(Data_Value, na.rm = TRUE), .groups = 'drop') %>%
  arrange(desc(TotalPrevalence))

# Comparisons Between Different Demographics
demographic_comparison <- dhds_data %>%
  group_by(Stratification1, Indicator) %>%
  summarise(AveragePrevalence = mean(Data_Value, na.rm = TRUE), .groups = 'drop') %>%
  pivot_wider(names_from = Indicator, values_from = AveragePrevalence)

# Plotting Example
ggplot(disability_distribution, aes(x = reorder(Indicator, -TotalPrevalence), y = TotalPrevalence)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Distribution of Disability Types", x = "Disability Type", y = "Total Prevalence (%)") +
  coord_flip()








# Prevalence of Disabilities by State
# Assuming 'Data_Value' represents the prevalence percentage
state_prevalence <- dhds_data %>%
  group_by(LocationDesc, Indicator) %>%
  summarise(AveragePrevalence = mean(Data_Value, na.rm = TRUE)) %>%
  filter(!is.na(AveragePrevalence)) %>%
  arrange(desc(AveragePrevalence))

# Overall Distribution of Disability Types
disability_distribution <- dhds_data %>%
  group_by(Indicator) %>%
  summarise(TotalPrevalence = sum(Data_Value, na.rm = TRUE)) %>%
  arrange(desc(TotalPrevalence))

# Comparisons Between Different Demographics
demographic_comparison <- dhds_data %>%
  group_by(Stratification1, Indicator) %>%
  summarise(AveragePrevalence = mean(Data_Value, na.rm = TRUE)) %>%
  filter(!is.na(AveragePrevalence)) %>%
  spread(key = Indicator, value = AveragePrevalence)

# Plotting the Distribution of Disability Types
ggplot(disability_distribution, aes(x = reorder(Indicator, -TotalPrevalence), y = TotalPrevalence)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Distribution of Disability Types", x = "Disability Type", y = "Total Prevalence (%)") +
  coord_flip()


## Tables
library(knitr)
library(kableExtra)

# Overall Distribution of Disability Types
kable(disability_distribution, format = "html", caption = "Overall Distribution of Disability Types") %>%
  kable_styling(bootstrap_options = c("striped", "hover"))


# Comparisons Between Different Demographics
kable(demographic_comparison, format = "html", caption = "Comparison of Disability Prevalence Across Different Demographics") %>%
  kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>%
  column_spec(1, bold = T, border_right = TRUE)
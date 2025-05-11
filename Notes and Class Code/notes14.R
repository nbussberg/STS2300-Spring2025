## Notes 14 - Hypothesis Testing for Differences

library(ggplot2)
library(infer)
library(dplyr)

 
### Hypothesis Tests for p1 - p2

## Step 2 - Gathering data
library(readr)
ACA_survey <- read_delim("https://www.openintro.org/data/tab-delimited/healthcare_law_survey.txt", "\t", 
                         escape_double = FALSE, 
                         trim_ws = TRUE) %>%
  mutate(response = ifelse(response == "approve", "approve", "dont"))


# Create bar graph to summarize the data

ggplot(ACA_survey) + 
  geom_bar(aes(x = order, fill = response))

ggplot(data = ACA_survey, aes(x = order, fill = response)) + 
  geom_bar(position = "fill")


ACA_obsphatdiff <- ACA_survey |> 
  specify(formula = response ~ order, success = "approve") |> 
  calculate(stat = "diff in props", 
            order = c("cannot_afford_second", "penalty_second"))

ACA_obsphatdiff


## Step 3 - simulate a null distribution and calculate p-value

# simulate and visualize the null distribution with p-value shaded

set.seed(100731)
ACA_null <- ACA_survey %>%
  specify(formula = response ~ order, success = "approve") %>%
  hypothesize(null = "independence") %>%
  generate(reps = 1000, type = "permute") %>%
  calculate(stat = "diff in props", 
            order = c("cannot_afford_second", "penalty_second"))

visualize(ACA_null) + 
  shade_p_value(obs_stat = ACA_obsphatdiff, direction = "both")

# Calculate p-value

ACA_null |> 
  get_p_value(obs_stat = ACA_obsphatdiff, direction = "both")


### Hypothesis tests for µ1 - µ2

## Step 2

# Load data
esp <- read.csv("https://raw.githubusercontent.com/nbussberg/STS2300-Fall2024/refs/heads/main/Data/esp.csv")

# Calculate difference in sample means

esp_diff <- esp |> 
  specify(formula = Matches ~ Group) |> 
  calculate(stat = "diff in means", order = c("believer", "skeptic"))
esp_diff

ggplot(esp) +
  geom_boxplot(aes(x = Group, y = Matches))


## Step 3 - simulate null distribution and calculate p-value

set.seed(7)
esp_null <- esp |> 
  specify(formula = Matches ~ Group) |> 
  hypothesize(null = "independence") |> 
  generate(reps = 1000, type = "permute") |> 
  calculate(stat = "diff in means", order = c("believer", "skeptic"))

visualize(esp_null) + 
  shade_p_value(obs_stat = esp_diff, direction = "right")

# calculate the p-value
esp_null |> 
  get_p_value(obs_stat = esp_diff, direction = "right")


## Theory based intervals

# prop.test for diff in proportions
table(ACA_survey$order, ACA_survey$response)
prop.test(x = c(365, 249), n = c(365+406, 249+483), 
          alternative = "two.sided")

# t.test for diff in means
t.test(Matches ~ Group, data = esp, alternative = "greater")
# or
t.test(esp$Matches ~ esp$Group, alternative = "greater")




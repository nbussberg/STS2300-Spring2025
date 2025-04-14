## Notes 09 - Using infer for Confidence Intervals

library(ggplot2)
library(dplyr)
library(infer)


## HoR Example

house_of_reps <- read.csv("https://raw.githubusercontent.com/nbussberg/STS2300-Spring2025/refs/heads/main/Data/house_of_reps.csv")

set.seed(82720)
mysamp <- sample_n(house_of_reps, size = 30)
table(mysamp$party)

HoR_boot <- mysamp |> 
  specify(party ~ NULL, success = "Democratic") |> 
  generate(reps = 1000, type = "bootstrap") |> 
  calculate(stat = "prop")

visualize(HoR_boot)


# Update a sample with more than 2 categories to have only 2
mysamp <- mysamp |> 
  mutate(party = ifelse(party == "Democratic",
                        "Democratic",
                        "Not Democratic"))

## Confidence Interval Approaches

# Theory-based approach

phat <- mean(mysamp$party == "Democratic")
phat

ci_theory <- c(phat - 1.645 * sqrt(phat * (1 - phat) / 30),
               phat + 1.645 * sqrt(phat * (1 - phat) / 30))
ci_theory



# Standard Error Method
boot_sd <- sd(HoR_boot$stat)

ci_se_manual <- c(phat - 1.645 * boot_sd,
                  phat + 1.645 * boot_sd)
ci_se_manual

ci_se <- HoR_boot |> 
  get_ci(level = 0.9, type = "se", point_estimate = phat)
ci_se


# Percentile Method
ci_perc <- HoR_boot |> 
  get_ci(level = 0.9, type = "percentile")
ci_perc


ci_theory
ci_se
ci_perc


## Graphing confidence intervals
library(patchwork)

se <- visualize(HoR_boot) + 
  shade_ci(ci_se)
perc <- visualize(HoR_boot) + 
  shade_ci(ci_perc, fill = "violet", color = "lightpink")

se + perc



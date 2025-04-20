## Notes 10 - Confidence Intervals for a Single Value

library(ggplot2)
library(dplyr)
library(infer)
library(palmerpenguins)


## Constructing confidence intervals for p

# Using a bootstrap distribution

house_of_reps <- read.csv("https://raw.githubusercontent.com/nbussberg/STS2300-Spring2025/refs/heads/main/Data/house_of_reps.csv")

set.seed(82720)
HOR_samp <- sample_n(house_of_reps, size = 30)

HOR_boot <- HOR_samp |> 
  specify(formula = party ~ NULL, success = "Democratic") |> 
  generate(reps = 1000, type = "bootstrap") |> 
  calculate(stat = "prop")


# Practice: Calculate 90% CI using SE and percentile methods

# SE Method

phat <- mean(HOR_samp$party == "Democratic")
phat

get_ci(HOR_boot, level = 0.9, type = "se", point_estimate = phat)


# Percentile Method
get_ci(HOR_boot, level = 0.9, type = "percentile")


# Theory-based Method
table(HOR_samp$party)
prop.test(x = 17, n = 30, conf.level = 0.9)



## Confidence intervals for µ

# calculate a point estimate
bill_xbar <- mean(penguins$bill_length_mm, na.rm = TRUE)
bill_xbar

# generate a bootstrap distribution
set.seed(4392)
bill_boot <- penguins |> 
  specify(formula = bill_length_mm ~ NULL) |> 
  generate(reps = 1000, type = "bootstrap") |> 
  calculate(stat = "mean")

visualize(bill_boot)

# Practice: calculate 95% CI using SE method or percentile method

# SE method
bill_boot |> 
  get_ci(level = 0.95, type = "se", point_estimate = bill_xbar)

# Percentile
get_ci(bill_boot, level = 0.95, type = "percentile")


# Theory-based CI method
t.test(x = penguins$bill_length_mm, conf.level = 0.95)



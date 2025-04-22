## Notes 11 - Confidence Intervals for Differences

library(ggplot2)
library(dplyr)
library(infer)
library(palmerpenguins)


## Constructing confidence intervals for p1 - p2

covid_dog <- data.frame(ID = c(rep("positive", 157), rep("negative", 792),
                               rep("positive", 33), rep("negative", 30)),
                        actual = c(rep("positive", 157), rep("negative", 792),
                                   rep("negative", 33), rep("positive", 30))) %>%
  mutate(correct = ifelse(ID == actual, "yes", "no"))


# Using a bootstrap distribution

set.seed(112300)
dog_boot <- covid_dog |> 
  specify(formula = correct ~ actual, success = "yes") |> 
  generate(reps = 1000, type = "bootstrap") |> 
  calculate(stat = "diff in props", order = c("positive", "negative"))

visualize(dog_boot)
  

# Get a 99% CI using percentile method

get_ci(dog_boot, level = 0.99, type = "percentile")


# Get a 99% CI using theory-based method

table(covid_dog$correct, covid_dog$actual, deparse.level = 2)

prop.test(x = c(157, 792), 
          n = c(157+30, 792+33), 
          conf.level = 0.99)

## Constructing confidence intervals for difference in means

adelie <- filter(penguins, species == "Adelie", !is.na(sex))

# Using a bootstrap distribution

set.seed(2000)
adelie_boot <- adelie |> 
  specify(formula = bill_length_mm ~ sex) |> 
  generate(reps = 1000, type = "bootstrap") |> 
  calculate(stat = "diff in means", order = c("male", "female"))

visualize(adelie_boot)


# Calculate 90% CI using the Standard Error method

# using the infer package to calculate the point estimate: 
  # difference is sample means
adelie_est <- adelie |> 
  specify(formula = bill_length_mm ~ sex) |> 
  calculate(stat = "diff in means", order = c("male", "female"))

adelie_est

get_ci(adelie_boot, level = 0.9, type = "se", 
       point_estimate = adelie_est)

# Theory-based 90% CI

t.test(bill_length_mm ~ sex, data = adelie, conf.level = 0.9)










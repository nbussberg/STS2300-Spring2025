## Notes 12 - Hypothesis Testing and Null Distributions

library(ggplot2)
library(infer)


## Hypothesis Testing Overview

# Step 2 - Gathering and summarizing data

# Create/load data

layoffs <- data.frame(age = c(25, 33, 35, 38, 48, 55, 55, 55, 56, 64),
                      laidoff = c("No", "No", "No", "No", "No",
                                  "Yes", "Yes", "No", "No", "Yes"))


# Calculate sample statistic

obs_xbardiff <- layoffs |> 
  specify(formula = age ~ laidoff) |> 
  calculate(stat = "diff in means", order = c("Yes", "No"))

obs_xbardiff


# Calculate t statistic

obs_t <- layoffs |> 
  specify(formula = age ~ laidoff) |> 
  calculate(stat = "t", order = c("Yes", "No"))

obs_t


## Using the infer package

layoff_perm <- layoffs %>%
  specify(formula = age ~ laidoff) %>%
  hypothesize(null = "independence") %>%
  generate(reps = 1000, type = "permute") %>%
  calculate(stat = "diff in means", order = c("Yes", "No"))

visualize(layoff_perm) + 
  shade_pvalue(obs_stat = obs_xbardiff,
               direction = "right")

layoff_perm %>% 
  get_p_value(obs_stat = obs_xbardiff,
              direction = "right")











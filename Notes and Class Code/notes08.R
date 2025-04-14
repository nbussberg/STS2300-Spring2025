## Notes 08 - Sampling Distributions and Bootstrap Resampling

library(ggplot2)
library(dplyr)
library(moderndive)
library(patchwork)


## House of Reps Example

house_of_reps <- read.csv("https://raw.githubusercontent.com/nbussberg/STS2300-Spring2025/refs/heads/main/Data/house_of_reps.csv")

pop_dist <- ggplot(house_of_reps) + 
  geom_bar(aes(x = party, fill = party),
           show.legend = FALSE) + 
  theme_classic() + 
  scale_fill_manual(values = c("blue", "red", "black"))

pop_dist + labs(title = "House of Reps Seats (Our Population)",
                subtitle = "As of October 2024")


# A single sample of 30 seats

set.seed(82720)
mysamp <- rep_sample_n(house_of_reps, size = 30)
table(mysamp$party)

sample_dist <- ggplot(mysamp) + 
  geom_bar(aes(x = party, fill = party),
           show.legend = FALSE) + 
  theme_classic() + 
  scale_fill_manual(values = c("blue", "red", "black"))

sample_dist + labs(title = "Sample of 30 House of Reps Seats",
                subtitle = "As of October 2024")


## Sampling Distributions

true_p <- mean(house_of_reps$party == "Democratic")

my_samples_n30 <- house_of_reps  |> 
  rep_sample_n(size = 30, reps = 1000)

my_phats_n30 <- my_samples_n30 |> 
  summarize(prop_dem = mean(party=="Democratic"))

sampling_dist_n30 <- ggplot(my_phats_n30) + 
  geom_histogram(aes(x = prop_dem),
                 binwidth = 1/30,
                 color = "white") + 
  theme_classic() + 
  scale_fill_manual(values = c("blue", "red", "black"))+ 
  labs(title = "Sampling distribution for the proportion of Dems in 30 HoR Seats",
       subtitle = "Estimated from 1000 random samples",
       caption = "Blue line is the population proportion of Dem seats") + 
  geom_vline(xintercept = true_p, 
             color = "blue")

sampling_dist_n30

# Find the standard error

sd(my_phats_n30$prop_dem)



## Sample Size and Standard Error

my_samples_n50 <- house_of_reps  |> 
  rep_sample_n(size = 50, reps = 1000)

my_phats_n50 <- my_samples_n50 |> 
  summarize(prop_dem = mean(party=="Democratic"))

sampling_dist_n50 <- ggplot(my_phats_n50) + 
  geom_histogram(aes(x = prop_dem),
                 binwidth = 1/30,
                 color = "white") + 
  theme_classic() + 
  scale_fill_manual(values = c("blue", "red", "black")) + 
  labs(title = "Sampling distribution for the proportion of Dems in 50 HoR Seats",
       subtitle = "Estimated from 1000 random samples",
       caption = "Blue line is the population proportion of Dem seats") + 
  geom_vline(xintercept = true_p, 
             color = "blue")

sampling_dist_n50


my_samples_n100 <- house_of_reps  |> 
  rep_sample_n(size = 100, reps = 1000)

my_phats_n100 <- my_samples_n100 |> 
  summarize(prop_dem = mean(party=="Democratic"))

sampling_dist_n100 <- ggplot(my_phats_n100) + 
  geom_histogram(aes(x = prop_dem),
                 binwidth = 1/30,
                 color = "white") + 
  theme_classic() + 
  scale_fill_manual(values = c("blue", "red", "black")) + 
  labs(title = "Sampling distribution for the proportion of Dems in 100 HoR Seats",
       subtitle = "Estimated from 1000 random samples",
       caption = "Blue line is the population proportion of Dem seats") + 
  geom_vline(xintercept = true_p, 
             color = "blue")

sampling_dist_n100

sampling_dist_n30 / sampling_dist_n50 / sampling_dist_n100

se30 <- sd(my_phats_n30$prop_dem)
se50 <- sd(my_phats_n50$prop_dem)
se100 <- sd(my_phats_n100$prop_dem)

data.frame(n = c(30, 50, 100), 
           SE = c(se30, se50, se100))


## Bootstrap distributions

phat <- mean(mysamp$party == "Democratic")

myboot <- mysamp |> 
  ungroup() |> 
  select(-replicate) |> 
  rep_sample_n(size = 30, reps = 1000, 
               replace = TRUE) |> 
  summarize(prop_dem = mean(party=="Democratic"))

boot_dist <- ggplot(myboot) + 
  geom_histogram(aes(x = prop_dem),
                 binwidth = 1/30, 
                 color = "white") + 
  theme_classic() + 
  scale_fill_manual(values = c("blue" , "red", "black")) + 
  geom_vline(xintercept = true_p, color = "blue") + 
  geom_vline(xintercept = phat, color = "orange")

boot_dist + 
  labs(title = "Bootstrap Distribution for Proportion of Dems in 30 HoR Seats",
       subtitle = "Estimated from 1000 bootstramp re-samples",
       caption = "Blue line: population prop. Orange line: sample prop.")
  


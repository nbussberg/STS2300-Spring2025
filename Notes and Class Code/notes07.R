## Notes 07 - Multiple Linear Regression

library(ggplot2)
library(dplyr)
library(patchwork)
library(Lock5Data)


## Visualizing the Car Mileage for different variables

cars <- Cars2015 %>%
  select(HwyMPG, Length, Height, Acc060, Weight)

g <- ggplot(cars, aes(y = HwyMPG))

g1 <- g + geom_point(aes(x = Length)) + theme_classic()
g2 <- g + geom_point(aes(x = Height)) + theme_classic()
g3 <- g + geom_point(aes(x = Acc060)) + theme_classic()
g4 <- g + geom_point(aes(x = Weight)) + theme_classic()

(g1 + g2) / (g3 + g4)


## MLR Line

lm(HwyMPG ~ Length + Height + Acc060 + Weight, data = cars)



## Making Predications with MLR Models

cars.lm <- lm(HwyMPG ~ Length + Height + Acc060 + Weight, data = cars)

predict(cars.lm, newdata = data.frame(Length = 192,
                                      Height = 72, 
                                      Acc060 = 7.7,
                                      Weight = 4505))

# Calculate the residual (residual = actual - predicted)

25 - 24.66


# Plot the predicated values against the actual values

cars$predictedHwyMPG <- predict(cars.lm)

ggplot(cars) + 
  geom_point(aes(x = HwyMPG, y = predictedHwyMPG)) + 
  geom_abline(slope = 1) +
  labs(title = "Actual vs. predicted MPG", 
       x = "Actual Highway MPG",
       y = "Predicted Highway MPG")
  


## Backwards selection

Cars2015 %>% 
  lm(HwyMPG ~ Length + Width + Height + Weight + Acc030 + Acc060, 
     data = .) %>%
  summary()
  # Acc030 had the largest p-value and wasn't significant, so remove it

Cars2015 %>% 
  lm(HwyMPG ~ Length + Width + Height + Weight + Acc060, 
     data = .) %>%
  summary()
  # Width had the largest p-value and wasn't significant, so remove it

Cars2015 %>% 
  lm(HwyMPG ~ Length + Height + Weight + Acc060, 
     data = .) %>%
  summary()



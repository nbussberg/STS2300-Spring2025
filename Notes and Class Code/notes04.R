### Code for Notes 04

# Load ggplot2 package
library(ggplot2)

## The ggplot2 package intro

ggplot(data = mtcars) + 
  geom_point(aes(x = wt, y = mpg))


# Practice Question 2 - scatter plot for hp vs. mpg

ggplot(data = mtcars) + 
  geom_point(aes(x = hp, y = mpg))


# Practice Question 3 - bar graph for transmission (am)

ggplot(data = mtcars) + 
  geom_bar(aes(x = am))


## Scatterplots

# Practice problem - change color, size, shape, and transparency

ggplot(data = mtcars) + 
  geom_point(aes(x = hp, y = mpg),
             color = "purple",
             size = 2, 
             shape = 17,
             alpha = 0.5)




## Histograms

# Practice problem - write code to match the graph

ggplot(airquality) + 
  geom_histogram(aes(x = Temp), 
                 fill = "darkorange", 
                 color = "white",
                 binwidth = 5, 
                 boundary = 55)



## Boxplots

# Practice problem - reproduce the boxplot in the notes

ggplot(data = ToothGrowth) +
  geom_boxplot(aes(x = supp, y = len), 
               fill = "black", 
               color = "pink")



## Bar Graphs

# Practice problem - replicate the graph in the notes

View(diamonds)
  # looks like each row is an individual diamond,
  # which means we have a raw data format

ggplot(diamonds) + 
  geom_bar(aes(x = cut, fill = cut),
           color = "black")


## Adding variables to graphs

ggplot(data = mtcars) + 
  geom_point(aes(x = wt, y = mpg,
                 color = drat,
                 shape = as.factor(am)))

ggplot(data = mtcars) + 
  geom_point(aes(x = wt, y = mpg,
                 color = as.factor(am),
                 alpha = drat))



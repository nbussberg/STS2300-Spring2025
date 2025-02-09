###  Notes 01 Companion Code from Class

## Use R to do basic calculations
1+3

4*6

## Writing Code in R

# store numbers and vectors as objects in the environment
myexponent <- 5^7 # this is a scalar object

mynumbers <- c(4, 8, 14, 15, 23, 42) # this is a vector object

mynumbers

mynumbers * 2

max(mynumbers)
max(mynumbers * 2)


# R is case sensitive and the following will not work
Max(mynumbers)

# Getting help in R
?max
help(mtcars)

## Data Frames and Exploring a Data Set
# Load mtcars dataset into memory
data(mtcars)

# Look at the first 5 rows (observations)
head(mtcars, n = 5)

# Look at the last 10 rows (observations)
tail(mtcars, n = 10)

# Look at summaries of the dataset
summary(mtcars)
View(mtcars)

# The following summary functions come from packages. 
# Packages must be installed either in the Packages section of the Viewer pane, or
  # through the following command: install.packages("skimr")
# Note: we don't keep the install.packages() functions in our scripts, because
  # we don't need to re-install them every time we run the script. 

# To load packages into the system, we do need to run library() in each script
  # for each function
library(dplyr)
glimpse(mtcars)

library(skimr)
skim(mtcars)


## The $ Operator to Look at Specific Variables
mtcars$hp
mean(mtcars$hp)

# print a list of car weights
mtcars$wt

# find the minimum miles per gallon
min(mtcars$mpg)



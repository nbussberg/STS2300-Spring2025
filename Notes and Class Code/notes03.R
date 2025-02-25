## Notes 03 - Data Import and Wrangling

# Check where my current working directory is
getwd()

library(readr)
NC_Bridges <- read_csv("NC Bridges.csv")
View(NC_Bridges)


## Pipe Operator

# Default, long way of coding
library(dplyr)

auto <- filter(mtcars, am==0)

auto <- mutate(auto, wt_lbs = 1000 * wt)

mean_wt_by_cyl <- summarize(auto,
                            mean_wt = mean(wt_lbs),
                            .by = cyl)

mean_wt_by_cyl <- arrange(mean_wt_by_cyl, cyl)

mean_wt_by_cyl

# A little more streamlined example

mean_wt_by_cyl <- arrange(summarize(mutate(filter(mtcars,
                                                  am==0),
                                           wt_lbs = 1000*wt),
                                    mean_wt = mean(wt_lbs),
                                    .by = cyl),
                          cyl)

mean_wt_by_cyl

# the pipe operator way

mean_wt_by_cyl <- mtcars |>
  filter(am == 0) |>
  mutate(wt_lbs = 1000 * wt) |>
  summarize(mean_wt = mean(wt_lbs), .by = cyl) |>
  arrange(cyl)

mean_wt_by_cyl


## Subsetting data by rows and columns

# filter() function to select rows

auto <- filter(mtcars, am == 0)
auto
  
# practice 1: subset of bridges only in Alamance
alam_bridges <- filter(NC_Bridges, COUNTY == "ALAMANCE")

table(alam_bridges$COUNTY)

# practice 2: subset of bridges SD and FO
struct_defic <- filter(NC_Bridges, 
                       STRUCTURALLYDEFICIENT == "SD",
                       FUNCTIONALLYOBSOLETE == "FO")
table(struct_defic$STRUCTURALLYDEFICIENT)
table(struct_defic$FUNCTIONALLYOBSOLETE)

table(struct_defic$STRUCTURALLYDEFICIENT,
      struct_defic$FUNCTIONALLYOBSOLETE)

# Practice 3
alam_funct_bridges <- filter(alam_bridges,
                             STRUCTURALLYDEFICIENT == "SD" | 
                               FUNCTIONALLYOBSOLETE == "FO")
alam_funct_bridges2 <- filter(NC_Bridges,
                              COUNTY == "ALAMANCE",
                              STRUCTURALLYDEFICIENT == "SD" | 
                                FUNCTIONALLYOBSOLETE == "FO")

# Use select() to choose variables

alam_bridges2 <- select(alam_bridges, 
                        ROUTE, ACROSS, YEARBUILT, SR)


## Using mutate() to create new variables

mycars <- mutate(mtcars, wt_lbs = wt * 1000)

mycars |> 
  select(wt, wt_lbs) |> 
  head(n = 5)

# Practice: create a new variable AGE for NC Bridges data
bridge_ages <- mutate(NC_Bridges, AGE = 2025 - YEARBUILT)

# Print AGE and YEARBUILT for the last 10 bridges
bridge_ages |> 
  select(YEARBUILT, AGE) |> 
  tail(n = 10)


## Long vs. Wide Data

# Load in datasets from Github using link
birds_wide <- read.csv("https://raw.githubusercontent.com/nbussberg/STS2300-Spring2025/main/Data/nestbox_lands_wide.csv")
birds_long <- read.csv("https://raw.githubusercontent.com/nbussberg/STS2300-Spring2025/main/Data/nestbox_lands_long.csv")

library(tidyr)

# Convert wide format to long format
birds_wide |> 
  pivot_longer(cols = -Species, 
               names_to = "Year",
               values_to = "Fledged") |> 
  head(n = 5)

# Convert long format to wide format
birds_long |> 
  pivot_wider(names_from = Year,
              values_from = Fledged)




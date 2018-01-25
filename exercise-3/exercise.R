# Exercise 3: using the pipe operator

# Install (if needed) and load the "dplyr" library
library("dplyr")

# Install (if needed) and load the "fueleconomy" package
#install.packages('devtools')
#devtools::install_github("hadley/fueleconomy")
library(fueleconomy)

# Which 2015 Acura model has the best hwy MGH? (Use dplyr, but without method
# chaining or pipes)
vehicles.year <- filter(vehicles, year == 2015)
vehicles.year.make <- filter(vehicles.year, make == "Acura")
vehicles.year.best <- filter(vehicles.year.make, hwy == max(hwy))
vehicles.year.model <- select(vehicles.year.best, model)

# Which 2015 Acura model has the best hwy MPG? (Use dplyr, nesting functions)
vehicles.year.model <- select(
  filter(
    filter(
      filter(vehicles, year == 2015)
    , make == "Acura")
  , hwy == max(hwy))
, model)

# Which 2015 Acura model has the best hwy MPG? (Use dplyr and the pipe operator)
vehicles.year.model <- filter(vehicles, year == 2015) %>% 
  filter(make == "Acura") %>% 
  filter(hwy == max(hwy)) %>% 
  select(model)


### Bonus

# Write 3 functions, one for each approach.  Then,
# Test how long it takes to perform each one 1000 times

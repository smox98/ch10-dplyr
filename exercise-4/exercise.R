# Exercise 4: practicing with dplyr

# Install the `nycflights13` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
install.packages('nycflights13')
library(nycflights13)
library("dplyr")

# The data.frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
nrow(flights)
ncol(flights)

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained in the air
flights <- mutate(flights, time.gained = arr_delay - dep_delay)

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
flights <- arrange(flights, -time.gained)

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables and reload the library 
# to "reset" it.
flights <- mutate(flights, time.gained = arr_delay - dep_delay) %>% 
  arrange(-time.gained)

# Make a histogram of the amount of time gained using the `hist()` function
time.gained.hist <- hist(flights$time.gained)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
time.gained.summary <- mean(flights$time.gained, na.rm = TRUE)

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain" column you just created
to.sea <- select(flights, origin, dest, time.gained) %>% 
  filter(dest == 'SEA')

# On average, did flights to SeaTac gain or loose time?
mean(to.sea$time.gained, na.rm = TRUE) #lose

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
jfk.to.sea <- flights %>% filter(origin == 'JFK', dest == 'SEA') %>% 
  summarize(
    average.airtime = mean(air_time, na.rm = TRUE),
    max.air.time = max(air_time, na.rm = TRUE),
    min.air.time = min(air_time, na.rm = TRUE)
  )

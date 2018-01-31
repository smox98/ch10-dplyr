# Exercise 5: dplyr grouped operations

# Install the `nycflights13` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library(nycflights13)
library(dplyr)

# What was the average department delay in each month?
# Save this as a data frame `dep.delay.by.month`
# Hint: you'll have to perform a grouping operation before summarizing your data
dep.delay.by.month <- flights %>% 
  group_by(month) %>% 
  summarize(avg_delay = mean(dep_delay, na.rm = TRUE))

# Which month had the greatest average departure delay?
greatest.avg.delay <- dep.delay.by.month %>% 
  filter(avg_delay == max(avg_delay))
print(greatest.avg.delay$month)

# If your above data frame contains just two columns (e.g., "month", and "delay"
# in that order), you can create a scatterplot by passing that data frame to the
# 'plot()' function
plot(dep.delay.by.month)

# To which destinations were the average arrival delays the highest?
# Hint: you'll have to perform a grouping operation before summarizing your data
dest.avg.arr.delays <- flights %>% 
  group_by(dest) %>% 
  summarize(arr_delay_avg = mean(arr_delay, na.rm = TRUE)) %>% 
  arrange(-arr_delay_avg)

# You can look up these airports in the `airports` data frame!
filter(airports, faa == dest.avg.arr.delays$dest[1])

# Which city was flown to with the highest average speed?
avg.speed.dest <- flights %>% 
  mutate(speed = distance/air_time * 60) %>% 
  group_by(dest) %>% 
  summarize(avg_speed = mean(speed, na.rm = TRUE)) %>% 
  arrange(-avg_speed)
city.highest.speed <- filter(airports, faa == avg.speed.dest$dest[1])
print(city.highest.speed$name)

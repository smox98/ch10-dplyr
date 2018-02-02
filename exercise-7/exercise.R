# Exercise 7: using dplyr on external data

# Load the dplyr library
library(dplyr)

# Use the `read.csv()` function to read in the included data set. Remember to
# save it as a variable.
teams <- read.csv("data/nba_teams_2016.csv", stringsAsFactors = FALSE)

# View the data frame you loaded, and get some basic information about the 
# number of rows/columns. 
# Note the "X" preceding some of the column titles as well as the "*" following
# the names of teams that made it to the playoffs that year.
View(teams)

# Add a column that gives the turnovers to steals ratio (TOV / STL) for each team
teams <- teams %>% mutate(tov_stl_ratio = TOV / STL)

# Sort the teams from lowest turnover/steal ratio to highest
# Which team has the lowest ratio?
teams <- arrange(teams, tov_stl_ratio)
print(teams$Team[1])

# Using the pipe operator, create a new column of assists per game (AST / G) 
# AND sort the data.frame by this new column in descending order.
teams <- teams %>% 
  mutate(assists_game = AST /G) %>% 
  arrange(-assists_game)

# Create a data frame called `good.offense` of teams that scored more than 
# 8700 points (PTS) in the season
good.offense <- filter(teams, PTS > 8700)

# Create a data frame called `good.defense` of teams that had more than 
# 470 blocks (BLK)
good.defense <- filter(teams, BLK > 470)

# Create a data.frame called `offense.stats` that only shows offensive 
# rebounds (ORB), field-goal % (FG.), and assists (AST) along with the team name.
offense.stats <- select(teams, Team, ORB, FG., AST)

# Create a data frame called `defense.stats` that only shows defensive 
# rebounds (DRB), steals (STL), and blocks (BLK) along with the team name.
defense.stats <- select(teams, Team, DRB, STL, BLK)

# Create a function called `BetterShooters` that takes in two teams and returns
# a data frame of the team with the better field-goal percentage. Include the team name, 
# field-goal percentage, and total points in your resulting data frame
BetterShooters <- function(team1, team2) {
  both <- teams %>% filter(Team == team1 | Team == team2)
  better <- both %>% filter(FG. == max(FG.))
  better <- better %>% select(Team, FG., PTS)
  return(better)
}

# Call the function on two teams to compare them (remember the `*` if needed)
BetterShooters("Sacramento Kings", "Denver Nuggets")

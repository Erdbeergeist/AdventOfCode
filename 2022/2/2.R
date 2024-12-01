# Advent of Code - Day 2

library(tidyverse)

input <- read_delim('2/input.txt', delim = ' ', col_names = c('Opponent', 'Me'), skip_empty_rows = FALSE) 

RPS <- data.frame(Name = c('Rock', 'Paper', 'Scissors'), 
                  Value = seq(1,3,1), 
                  ID1 = c('A', 'B', 'C'),
                  ID2 = c('X', 'Y', 'Z'),
                  Wins = c('C', 'A', 'B'),
                  Loses = c('B', 'C', 'A'))

# Part 1

p1 <- input %>% 
  left_join(RPS %>% select(-Name, -Loses), by = c('Opponent' =  'ID1')) %>% 
  left_join(RPS %>% select(Value, ID1, ID2, -Loses), by = c('Me' = 'ID2')) %>% 
  select(-Me, Me = ID1, -ID2) %>% 
  mutate(Points = case_when(Me == Wins ~ Value.y,
                            Opponent == Me ~ Value.y + 3,
                            Opponent != Me ~ Value.y + 6))
p1 %>% 
  pull(Points) %>% 
  sum()

# Part 2

p2  <- input %>% 
  left_join(RPS %>% select(-Name, -ID2, -Value), by = c('Opponent' =  'ID1')) %>% 
  mutate(Adjusted_Me = case_when(Me == 'X' ~ Wins,
                                 Me == 'Y' ~ Opponent,
                                 Me == 'Z' ~ Loses)) %>% 
 left_join(RPS %>% select(ID1, -ID2, -Loses, Value), by = c('Adjusted_Me' = 'ID1')) %>% 
 mutate(Points = case_when(Adjusted_Me == Wins ~ Value,
                           Opponent == Adjusted_Me ~ Value + 3,
                           Opponent != Adjusted_Me ~ Value + 6))

p2 %>% 
  pull(Points) %>% 
  sum()
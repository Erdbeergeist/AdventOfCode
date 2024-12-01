# Advent of Code - Day 6

library(tidyverse)
library(runner)

input <- data.frame(chars = (read_lines('6/input.txt') %>%  
  str_split(''))[[1]])

# Part 1

p1 <- input %>% mutate(marker = runner(chars, n_distinct, k = 4, lag = 1),
                       RI = row_number() -1) %>% 
  filter(marker > 3) %>% 
  slice(which.min(RI)) %>% 
  print()

# Part 2

p2 <- input %>% mutate(marker = runner(chars, n_distinct, k = 14, lag = 1),
                       RI = row_number() -1) %>% 
  filter(marker > 13) %>% 
  slice(which.min(RI)) %>% 
  print()
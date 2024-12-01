# Advent of Code - Day 4 

library(tidyverse)

input <- read_delim('4/input.txt', delim = ',', col_names = c('E1', 'E2'), skip_empty_rows = FALSE) %>% 
  separate(E1, into = c('E11', 'E12')) %>% 
  separate(E2, into = c('E21', 'E22')) %>% 
  rowwise() %>% 
  mutate(E1 = list(seq(E11, E12, 1)),
         E2 = list(seq(E21, E22, 1)))

# Part 1
p1 <- input %>% 
  mutate(contained = if_else(min(E1 %in% E2) || min(E2 %in% E1), 1, 0)) 

p1 %>%
  pull(contained) %>% 
  sum()


# Part 2
p2 <- input %>% 
  mutate(contained = if_else(E1 %in% E2 || E2 %in% E1, 1, 0))

p2 %>% 
  pull(contained) %>% 
  sum()
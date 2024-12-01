# Advent of Code - Day 3

library(tidyverse)

input <- read_csv('3/input.txt', col_names = 'Backpack', skip_empty_rows = FALSE) 

# Part 1

p1 <- input %>% 
  rowwise() %>% 
  mutate(c1 = str_split(str_sub(Backpack, 1, str_length(Backpack)/2), ''),
         c2 = str_split(str_sub(Backpack, str_length(Backpack)/2 + 1, str_length(Backpack)), ''),
         common = intersect(c1, c2)) %>% 
  ungroup() %>% 
  left_join(data.frame(common = c(letters, LETTERS), Priority = seq(1, 52, 1)),
            by = 'common')
p1 %>% 
  pull(Priority) %>% 
  sum()

# Part 2

p2 <- input %>%  
  mutate(group = rep(1:(nrow(p1)/3), each = 3),
         c = str_split(Backpack, '')) %>% 
  group_by(group) %>%
  summarise(common = Reduce(intersect, c)) %>% 
  left_join(data.frame(common = c(letters, LETTERS), Priority = seq(1, 52, 1)),
            by = 'common')
 
p2 %>% 
  pull(Priority) %>% 
  sum()
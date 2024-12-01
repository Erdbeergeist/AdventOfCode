# Advent of Code - Day 5

library(tidyverse)

input <- read_lines('5/input.txt') 

crate_input <- input[1:(which(input == '')-1)]
move_input <- input[(which(input == '')+1):length(input)]

push <- function(stack, crate){
  .GlobalEnv$stacks[[stack]][[length(.GlobalEnv$stacks[[stack]]) +1]] <- crate
}

pop <- function(stack){
  crate <- .GlobalEnv$stacks[[stack]][[length(.GlobalEnv$stacks[[stack]])]]
  .GlobalEnv$stacks[[stack]] <- .GlobalEnv$stacks[[stack]][1:length(.GlobalEnv$stacks[[stack]])-1]
  return(crate)
}

move_crate <- function(from, to, n = 1){
  walk(seq(1,n,1), ~push(to, pop(from)))
}

#Find the number of crate stacks
num_stacks <- max(str_extract_all(crate_input[length(crate_input)], '\\d')[[1]])
#Remove the last crate_crate_input row
crate_input <- crate_input[1:(length(crate_input)-1)]
#Get the position of the crates
crate_pos <- str_locate_all(crate_input, '\\[.\\]')
#Figure out which stack it belongs to
crate_stack_num <- rev(map(crate_pos, ~as.numeric(map(.x[,1], ~ceiling(.x / 4)))))
#Figure out the crate [P]
crates <- rev(str_extract_all(crate_input, '\\[.\\]'))
#Setup Stacks
stacks <- replicate(num_stacks, list(as.character()))
#Fill initial crate stacks
walk2(crate_stack_num, crates, ~walk2(.x, .y, ~push(.x, .y)))

orig_stacks <- stacks

#Parse move arguments
moves <- data.frame(raw = move_input) %>% 
  rowwise() %>% 
  mutate(move = str_extract_all(raw, '\\d{1,2}')) %>% 
  ungroup() %>% 
  unnest_wider(move) %>%
  mutate(N = as.integer(`...1`),
         From = as.integer(`...2`),
         To = as.integer(`...3`))

#Part 1

stacks
pmap(list(from = moves$From, to = moves$To, n = moves$N), move_crate)
stacks
gsub('\\[|\\]', '', str_c(map_chr(stacks, ~.x[length(.x)]), collapse = ''))


#Part 2

move_crates <- function(from, to, n = 1){
  crates <- rev(map(seq(1, n, 1), ~pop(from)))
  map(crates, ~push(to, .x))
}

stacks <- orig_stacks

stacks
pmap(list(from = moves$From, to = moves$To, n = moves$N), move_crates)
stacks
gsub('\\[|\\]', '', str_c(map_chr(stacks, ~.x[length(.x)]), collapse = ''))

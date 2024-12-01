library(tidyverse)
input <- read_delim("2024/1/input.txt", delim = " ", col_names = FALSE) %>%
  select(-X2, -X3) %>%
  mutate(across(everything(), as.integer),
    X1 = sort(X1),
    X4 = sort(X4),
    delta = abs(X1 - X4)
  )
sum(input$delta)

# Part 1 complete

reduce(input$X1, \(prev, current) {
  return(prev + (current * sum(current == input$X4)))
}, .init = 0)

# Part 2 complete

## code to prepare all_individuals dataset goes here
library(lubridate)
library(readr)
library(tidyverse)

elections <- read_csv("data-raw/elections.csv",
                col_names = TRUE,
                col_types = cols(
                  electionDate = col_date(format = ""),
                  seatsTotalNumber = col_integer(),
                  electionWinner = col_character(),
                  comment = col_character()
                ))


usethis::use_data(elections)

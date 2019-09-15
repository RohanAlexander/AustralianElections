## code to prepare all_individuals dataset goes here
library(lubridate)
library(readr)
library(tidyverse)

byelections <- read_csv("data-raw/byelections.csv",
                col_names = TRUE,
                col_types = cols(
                  date = col_date(format = ""),
                  parliament = col_character(),
                  division = col_character(),
                  cause = col_character(),
                  formerMember = col_character(),
                  party = col_character(),
                  winner = col_character(),
                  party_1 = col_character(),
                  unopposed = col_double()
                ))


usethis::use_data(byelections)

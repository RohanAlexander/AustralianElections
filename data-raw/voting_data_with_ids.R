## code to prepare all_individuals dataset goes here
library(lubridate)
library(readr)
library(tidyverse)

voting_data <- read_csv("data-raw/voting_data_with_ids.csv",
                col_names = TRUE,
                col_types = cols(
                  .default = col_character(),
                  division = col_character(),
                  state = col_character(),
                  division_num_enrolled = col_integer(),
                  division_num_voted = col_integer(),
                  division_percent_voted = col_double(),
                  original_name = col_character(),
                  party = col_character(),
                  vote_redistribution_round = col_integer(),
                  votes_count = col_integer(),
                  votes_share = col_double(),
                  swing = col_double(),
                  redistributed_vote_count = col_integer(),
                  redistributed_vote_share = col_double(),
                  txt_file = col_character(),
                  election_date = col_date(format = "%Y-%m-%d"),
                  starred = col_logical(),
                  plus = col_logical(),
                  capitalised = col_logical(),
                  twoPP = col_integer(),
                  number_of_candidates = col_integer(),
                  winnerDummy = col_logical(),
                  uniqueID = col_character()
                ))


usethis::use_data(voting_data)

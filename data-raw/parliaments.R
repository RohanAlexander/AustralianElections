## code to prepare all_individuals dataset goes here
library(lubridate)
library(readr)
library(tidyverse)

parliaments <- read_csv("data-raw/parliaments.csv",
                col_names = TRUE,
                col_types = cols(
                  electionDate = col_date(format = ""),
                  parliament = col_integer(),
                  sessionNumber = col_integer(),
                  dateOfOpening = col_date(format = ""),
                  lastSittingDayOfTheHouseOfReps = col_date(format = ""),
                  dateOfProrogation = col_date(format = ""),
                  dateOfDissolutionOrExpiration = col_date(format = ""),
                  doubleDissolutionElection = col_integer(),
                  comments = col_character()
                ))


usethis::use_data(parliaments)

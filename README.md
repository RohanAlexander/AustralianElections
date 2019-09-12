
<!-- README.md is generated from README.Rmd. Please edit that file -->

# AustralianElections

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/RohanAlexander/AustralianElections.svg?branch=master)](https://travis-ci.org/RohanAlexander/AustralianElections)
<!-- badges: end -->

`AustralianElections` is a collection of datasets related to Australian
elections The datasets are:

  - **elections.rda**: The main dataset.
  - **parliaments.rda**: Dates of each parliament.
  - **voting\_data.rda**: All federal elections.

The datasets are up-to-date as of 10 September 2019.

If you have suggestions on how I could improve the datasets, or
corrections, please don’t hesitate to get in touch.

## Installation

You can install this package from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("RohanAlexander/AustralianElections")
```

## Example

This is a example of how to load the data:

``` r
library(tidyverse)

devtools::install_github("RohanAlexander/AustralianElections")

elections <- AustralianElections::elections %>% as_tibble()
parliaments <- AustralianElections::parliaments %>% as_tibble()
voting_data <- AustralianElections::voting_data %>% as_tibble()
```

## Dataset details

TBD

## TODO

## Roadmap

## Sources

## Acknowledgements

## Citation

If you use `AustralianElections`, please consider citing:

Alexander, Rohan. (2019). AustralianElections: Datasets on Australian
Elections. Source:
<https://github.com/RohanAlexander/AustralianElections>.

## Author information

**Rohan Alexander** (corresponding author and repository maintainer)  
University of Toronto  
Information Sciences  
140 St George St  
Toronto, ON, Canada  
Email: <rohan.alexander@utoronto.ca>

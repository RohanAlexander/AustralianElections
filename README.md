
<!-- README.md is generated from README.Rmd. Please edit that file -->

# AustralianElections <img src="man/figures/logo.png" align="right" height="250" />

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/RohanAlexander/AustralianElections.svg?branch=master)](https://travis-ci.org/RohanAlexander/AustralianElections)
<!-- badges: end -->

`AustralianElections` is a collection of datasets related to Australian
elections. The datasets are:

-   **byelections**:
-   **elections**: The main dataset.
-   **parliaments**: Dates of each parliament.
-   **voting_data**: All federal elections.
-   **voting_data_with_ids**:

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

This is an example of how to load the data:

``` r
devtools::install_github("RohanAlexander/AustralianElections")

byelections <- AustralianElections::get_auselection("byelections")
elections <- AustralianElections::get_auselection("elections")
parliaments <- AustralianElections::get_auselection("parliaments")
voting_data <- AustralianElections::get_auselection("voting_data")
voting_data_ids <- AustralianElections::get_auselection("voting_data_with_ids")
```

Alternatively, you can load only a specific year:

``` r
voting_data_2016 <- AustralianElections::get_auselection("voting_data", year = 2016)
```

Or, a range of years by using a relational operator:

In addition to providing access to these datasets, `AustralianElections`
also provides two pre-filtered datasets based upon the
two-party-preferred results and the eventual winner. These datasets by
default use the `voting_data_with_ids` dataset, but can be set to use
the `voting_data` dataset instead.

To call the two-party-preferred dataset you can use:

``` r
twopp_ids <- AustralianElections::auselect_twopp()
```

To call the version based on the `voting_data` you use:

``` r
twopp_noids <- AustralianElections::auselect_twopp(w_ids = F)
```

The winners dataset works similarly, with the default dataset being
`voting_data_with_ids` while setting `w_ids` to `FALSE` will set the
base dataset to `voting_data`.

``` r
winners_ids <- AustralianElections::auselect_winners()
```

``` r
winners_noids <- AustralianElections::auselect_winners(w_ids = F)
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

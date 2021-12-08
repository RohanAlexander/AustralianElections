#' Retrieve a .csv dataset from the australian_elections GitHub repository.
#'
#' @description
#' `auselect_twopp()` downloads and assigns a filtered dataset to a given variable.
#'
#' @param w_ids A boolean value used to determine if the dataset is returned with or without a unique identifier column.
#' Default is set to TRUE, which returns a dataset with the unique identifier column.
#'
#'
#' @details
#' The `auselect_twopp()` function is used to return a pre-filtered version of either the `voting_data_with_ids` or `voting_data` datasets.
#' On call, the function will filter the requested dataset based upon where two party preferred (`twoPP`) is true (a value of 1).
#' The default dataset that is downloaded through this function is the `voting_data_with_ids` dataset.
#' Setting the argument value of the function to `w_ids = F` will set the function to instead download the `voting_data` dataset.
#'
#' @return A filtered dataset with either unique identifier values or no unique identifier values as specified by \code{w_ids}.
#'
#' @examples
#'
#' \dontrun{
#' # Return the filtered dataset with unique ids.
#' twopp_ids <- auselect_twopp()
#'
#' # Preview dataset
#' head(twopp_ids)
#'
#' # Request the filtered dataset without unique ids.
#' twopp_noids <- auselect_twopp(w_ids = F)
#'
#' # Preview the dataset.
#' head(twopp_noids)
#' }
#'
#' @export
# Function to access a filtered set of Australian elections datasets.
# Takes one arguments `w_ids`.
# A boolean value to determine whether to download dataset with unique ids or without.


auselect_twopp <- function(w_ids = T){
  dwnlds <- c("https://raw.github.com/RohanAlexander/australian_federal_elections/master/outputs/voting_data.csv",
              "https://raw.github.com/RohanAlexander/australian_federal_elections/master/outputs/voting_data_with_ids.csv"

  )

  tmpdir <- tempfile(fileext = ".csv")

  if(w_ids == T){
    utils::download.file(dwnlds[[2]], tmpdir, quiet = F)

    x <- readr::read_csv(tmpdir, show_col_types = F)

    dplyr::filter(x, twoPP == 1)
  }

  else if(w_ids == F){
    utils::download.file(dwnlds[[1]], tmpdir, quiet = F)

    x <- readr::read_csv(tmpdir, show_col_types = F)

    dplyr::filter(x, twoPP == 1)
  }
}

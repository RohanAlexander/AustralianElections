#' Retrieve a .csv dataset from the australian_elections GitHub repository.
#'
#' @description
#' `get_auselection()` downloads a requested non-filtered or filtered Australian elections dataset given a set of associated arguments.
#'
#' @param dsr A character string used to request an Australian elections dataset. *See Request Codes* below.
#' @param opr A character string used to pass a relational operator (`==`, `=>`, `=<`, `<`, `>`, or `!=`) to the function.
#' Also takes a character string `'range'` to download a range of years given as a vector by \code{year}.
#' Default of this parameter is set to be an empty string, which also acts as the equivalent (`==`) operator.
#' @param year A numeric value used to request a specific election year. If there is no election for a given year,
#' returns an empty dataframe. Default value is set to 0, which returns all election years.
#'
#'
#' @details
#'
#' ## Request Codes
#' * `byelections` requests the byelections.csv dataset.
#' * `elections` requests the elections.csv dataset.
#' * `parliaments` requests the parliaments.csv dataset.
#' * `voting_data` requests the voting_data.csv dataset.
#' * `voting_data_with_ids` requests the voting_data_with_ids.csv dataset.
#'
#' An incorrect request (an argument not associated with a dataset, non-character string argument, non-relational operator, or non-numeric election year)
#' will stop function processes and return an error message.
#'
#' @return A console printout of arguments used with the function,
#' the requested complete dataset using \code{dsr} assigned to a user variable,
#' or the requested dataset \code{dsr} for a given election year or years with \code{year} and \code{opr} to a user assigned variable.
#'
#' @examples
#' # Show request codes used for arguments in function.
#' get_auselection("codes")
#'
#' # Show in which years an election was held
#' get_auselection("years")
#'
#' \dontrun{
#' # Request the complete Voting Data with IDs dataset.
#' # Prints a tibble to the console.
#' with_ids_df <- get_auselection("voting_data_with_ids")
#'
#' # Preview observations for the dataset.
#' # Prints a vector to the console.
#' head(with_ids_df)
#'
#' # Request only values for the 1975 election from the Voting Data with IDs dataset.
#' with_ids_1975_df <- get_auselection("voting_data_with_ids", year = 1975)
#'
#' # Preview observations for the dataset.
#' head(with_ids_1975_df)
#'
#' # Request values for the elections within and after 1925.
#' with_ids_1925up_df <- get_auselection("voting_data_with_ids", opr = ">=", year = 1925)
#'
#' # Preview observation for the dataset.
#' head(with_ids_1925up_df)
#'
#' # Request values for elections from 1925 to 1975.
#' with_ids_25to75_df <- get_auselection("voting_data_with_ids", opr = "range", year = c(1925, 1975))
#'
#' # Preview observations for the dataset.
#' head(with_ids_25to75_df)
#' }
#'
#' @export
# Function to access Australian elections datasets.
# Takes three arguments `dsr`, `opr`, and `year`.
# A character string to download and assign dataset to given variable name.
# A character string to act as a relational operator.
# A numeric value to request a specific election year, which is a default of 0.


# assign function name `get_auselection`
get_auselection <- function(dsr, opr = "", year = 0){

  # create vector to hold acceptable `opr` values
  relops <- c("==", ">=", "<=", "<", ">", "!=", "", "range")

  # assign download URLs vector, these are used to download the data files in a .csv format
  dwnlds <- c("https://raw.github.com/RohanAlexander/australian_federal_elections/master/outputs/byelections.csv",
              "https://raw.github.com/RohanAlexander/australian_federal_elections/master/outputs/elections.csv",
              "https://raw.github.com/RohanAlexander/australian_federal_elections/master/outputs/parliaments.csv",
              "https://raw.github.com/RohanAlexander/australian_federal_elections/master/outputs/voting_data.csv",
              "https://raw.github.com/RohanAlexander/australian_federal_elections/master/outputs/voting_data_with_ids.csv"

  )
  # assign a vector of election years
  elect_years <- c(1901, 1903, 1906, 1910, 1913, 1914, 1917, 1919, 1922, 1925, 1928, 1929, 1931, 1934, 1937, 1940,
                   1943, 1946, 1949, 1951, 1954, 1955, 1958, 1961, 1963, 1966, 1969, 1972, 1974, 1975, 1977, 1980,
                   1983, 1984, 1987, 1990, 1993, 1996, 1998, 2001, 2004, 2007, 2010, 2013, 2016, 2019)


  # assign a tibble to hold the request codes used as arguments
  codetibble <- tibble::tibble(
    request_code = c("byelections", "elections", "parliaments", "voting_data", "voting_data_with_ids", "codes"),
    dataset = c("Byelection data - 1901-2018 - 158 obs. - 9 var.", "Election data - 1901-2019 - 46 obs. - 4 var.", "Parliament data - 1901-2019 - 75 obs. - 9 var.",
                "Voting data - 1901-2019 - 65337 obs. - 25 var.", "Voting data with IDs - 1901-2019 - 65337 obs. - 22 var.", "Request codes - used to download a dataset.")
  )

  # set first error for if dsr is not a character string
  if(!purrr::is_character(dsr)){
    stop("Provided request code must be a character string.")
  }

  # set error for if year is not a numeric value
  else if(!is.numeric(year)){
    stop("Year must be a numeric value greater than 0.")
  }

  # set error for when passed an incorrect relational operator
  else if(!(opr %in% relops)){
    stop("Provided value for `opr` is not a valid relational operator. Please use one of '==', '>=', '<=', '>', '<', '!='. Use opr = 'range' to return a range of election years.")
  }
  # show in which years an election was held
  else if(dsr == "years"){
    elect_years
  }
  # else if provided character string is in request_code column values
  else if(dsr %in% codetibble$request_code){
    # assign to temporary file with .csv file type
    tmpdir <- tempfile(fileext = ".csv")

    # return request code arguments if given "codes" as argument
    if(dsr == "codes"){
      # show first five values of codetibble
      utils::head(codetibble, 5)
    }

    # if `dsr` is equal to "byelections"
    else if(dsr == "byelections"){

      # download from the assigned URL to the temporary directory, showing download progress
      utils::download.file(dwnlds[[1]], tmpdir, quiet = F)


      # if year is left at default value of 0
      if(any(year == 0)){
        # read in complete CSV using `read_csv` from `readr`, do not show column types
        readr::read_csv(tmpdir, show_col_types = F)
      }

      # else if year does not equal default value
      else if(any(year != 0)){

        # read in CSV and filter for the requested year
        x <- readr::read_csv(tmpdir, show_col_types = F)

        # if opr is set to specific relational operator
        if(opr == "==" | opr == ""){

          # filter dataset using given relational operator
          # the rest of the code follows similarly
          dplyr::filter(x, lubridate::year(date) == year)
        }

        else if(opr == ">="){
          dplyr::filter(x, lubridate::year(date) >= year)
        }

        else if(opr == "<="){
          dplyr::filter(x, lubridate::year(date) <= year)
        }

        else if(opr == "<"){
          dplyr::filter(x, lubridate::year(date) < year)
        }

        else if(opr == ">"){
          dplyr::filter(x, lubridate::year(date) > year)
        }

        else if(opr == "!="){
          dplyr::filter(x, lubridate::year(date) != year)
        }

        else if(opr == "range"){
          dplyr::filter(x, lubridate::year(date) >= min(year), lubridate::year(date) <= max(year))
        }
      }
    }
    else if(dsr == "elections"){
      utils::download.file(dwnlds[[2]], tmpdir, quiet = F)

      if(any(year == 0)){
        readr::read_csv(tmpdir, show_col_types = F)
      }

      else if(any(year != 0)){
        x <- readr::read_csv(tmpdir, show_col_types = F)

        if(opr == "==" | opr == ""){
          dplyr::filter(x, lubridate::year(electionDate) == year)
        }

        else if(opr == ">="){
          dplyr::filter(x, lubridate::year(electionDate) >= year)
        }

        else if(opr == "<="){
          dplyr::filter(x, lubridate::year(electionDate) <= year)
        }

        else if(opr == ">"){
          dplyr::filter(x, lubridate::year(electionDate) > year)
        }

        else if(opr == "<"){
          dplyr::filter(x, lubridate::year(electionDate) < year)
        }

        else if(opr == "!="){
          dplyr::filter(x, lubridate::year(electionDate) != year)
        }

        else if(opr == "range"){
          dplyr::filter(x, lubridate::year(electionDate) >= min(year), lubridate::year(electionDate) <= max(year))
        }
      }
    }
    else if(dsr == "parliaments"){

      utils::download.file(dwnlds[[3]], tmpdir, quiet = F)

      if(any(year == 0)){
        readr::read_csv(tmpdir, show_col_types = F)
      }

      else if(any(year != 0)){

        x <- readr::read_csv(tmpdir, show_col_types = F)

        if(opr == "==" | opr == ""){
          dplyr::filter(x, lubridate::year(electionDate) == year)
        }

        else if(opr == ">="){
          dplyr::filter(x, lubridate::year(electionDate) >= year)
        }

        else if(opr == "<="){
          dplyr::filter(x, lubridate::year(electionDate) <= year)
        }

        else if(opr == ">"){
          dplyr::filter(x, lubridate::year(electionDate) > year)
        }

        else if(opr == "<"){
          dplyr::filter(x, lubridate::year(electionDate) < year)
        }

        else if(opr == "!="){
          dplyr::filter(x, lubridate::year(electionDate) != year)
        }

        else if(opr == "range"){
          dplyr::filter(x, lubridate::year(electionDate) >= min(year), lubridate::year(electionDate) <= max(year))
        }
      }
    }

    else if(dsr == "voting_data"){
      utils::download.file(dwnlds[[4]], tmpdir, quiet = F)

      if(any(year == 0)){
        readr::read_csv(tmpdir, show_col_types = F)
      }

      else if(any(year != 0)){
        x <- readr::read_csv(tmpdir, show_col_types = F)

        if(opr == "==" | opr == ""){
          dplyr::filter(x, lubridate::year(election_date) == year)
        }

        else if(opr == ">="){
          dplyr::filter(x, lubridate::year(election_date) >= year)
        }

        else if(opr == "<="){
          dplyr::filter(x, lubridate::year(election_date) <= year)
        }

        else if(opr == ">"){
          dplyr::filter(x, lubridate::year(election_date) > year)
        }

        else if(opr == "<"){
          dplyr::filter(x, lubridate::year(election_date) < year)
        }

        else if(opr == "!="){
          dplyr::filter(x, lubridate::year(election_date) != year)
        }

        else if(opr == "range"){
          dplyr::filter(x, lubridate::year(election_date) >= min(year), lubridate::year(election_date) <= max(year))
        }
      }
    }

    else if(dsr == "voting_data_with_ids"){
      utils::download.file(dwnlds[[5]], tmpdir, quiet = F)

      if(any(year == 0)){
        readr::read_csv(tmpdir, show_col_types = F)
      }

      else if(any(year != 0)){
        x <- readr::read_csv(tmpdir, show_col_types = F)

        if(opr == "==" | opr == ""){
          dplyr::filter(x, lubridate::year(election_date) == year)
        }

        else if(opr == ">="){
          dplyr::filter(x, lubridate::year(election_date) >= year)
        }

        else if(opr == "<="){
          dplyr::filter(x, lubridate::year(election_date) <= year)
        }

        else if(opr == ">"){
          dplyr::filter(x, lubridate::year(election_date) > year)
        }

        else if(opr == "<"){
          dplyr::filter(x, lubridate::year(election_date) < year)
        }

        else if(opr == "!="){
          dplyr::filter(x, lubridate::year(election_date) != year)
        }

        else if(opr == "range"){
          dplyr::filter(x, lubridate::year(election_date) >= min(year), lubridate::year(election_date) <= max(year))
        }
      }
    }
  }

  else{
    # else character string is not in tibble values stop function and return error
    stop("Provided request code is not associated with a dataset. Please use get_auselections('codes') to print out a set of useable request codes.")
  }
}

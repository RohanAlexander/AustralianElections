test_that("get_auselection produces and assigns a complete dataset to a given variable name",{

  skip_if_offline()
  skip_on_cran()

  #user requests the complete byelections dataset and assigns to byelections_df
  byelections_df <- AustralianElections::get_auselection("byelections")
  expect_true(exists("byelections_df"))
  expect_type(byelections_df, "list")

  #user requests the complete elections dataset and assigns to elections_df
  elections_df <- AustralianElections::get_auselection("elections")
  expect_true(exists("elections_df"))
  expect_type(elections_df, "list")

  #user requests the complete parliaments dataset and assigns to parliaments_df
  parliaments_df <- AustralianElections::get_auselection("parliaments")
  expect_true(exists("parliaments_df"))
  expect_type(parliaments_df, "list")

  #user requests the complete voting_data dataset and assigns to byelections_df
  voting_data_df <- AustralianElections::get_auselection("voting_data")
  expect_true(exists("voting_data_df"))
  expect_type(voting_data_df, "list")

  #user requests the complete voting_data_with_ids dataset and assigns to voting_data_w_ids_df
  voting_data_w_ids_df <- AustralianElections::get_auselection("voting_data_with_ids")
  expect_true(exists("voting_data_w_ids_df"))
  expect_type(voting_data_w_ids_df, "list")
})

test_that("get_auselection prints out a tibble when using the argument 'codes'",{

  expect_snapshot_output(AustralianElections::get_auselection("codes"), cran = F, variant = NULL)

})

test_that("get_auselection filters dataset for a given year(s)",{

  skip_if_offline()
  skip_on_cran()

  #test that function returns only year requested
  byelections_df <- AustralianElections::get_auselection("byelections", year = 2018)
  x <- as.numeric(format(byelections_df$date, "%Y"))
  expect_setequal(x, 2018)

  #test that function returns only years greater than provided year
  voting_data_df <- AustralianElections::get_auselection("voting_data", opr = ">", year = 1975)
  y <- as.integer(format(voting_data_df$election_date, "%Y"))
  expect_true(all(y > 1975))

  #test that function returns only years less than provided year
  voting_data_wids_df <- AustralianElections::get_auselection("voting_data_with_ids", opr = "<", year = 1975)
  z <- as.integer(format(voting_data_wids_df$election_date, "%Y"))
  expect_true(all(z < 1975))

  #test that function returns only years greater than or equal to provided year
  voting_data_wids_df <- AustralianElections::get_auselection("voting_data_with_ids", opr = ">=", year = 1975)
  t <- as.integer(format(voting_data_wids_df$election_date, "%Y"))
  expect_true(all(t >= 1975))

  #test that function returns only years less than or equal to provided year
  voting_data_wids_df <- AustralianElections::get_auselection("voting_data_with_ids", opr = "<=", year = 1975)
  h <- as.integer(format(voting_data_wids_df$election_date, "%Y"))
  expect_true(all(h <= 1975))

  #test that function returns a range of years as requested
  voting_data_df <- AustralianElections::get_auselection("voting_data", opr = "range", year = c(1975, 2018))
  a <- as.numeric(format(voting_data_df$election_date, "%Y"))
  expect_equal(min(a), 1975)
  expect_equal(max(a), 2018)

  #test that function returns all years but the one provided
  voting_data_df <- AustralianElections::get_auselection("voting_data", opr = "!=", year = 1980)
  b <- as.integer(format(voting_data_df$election_date, "%Y"))
  expect_true(all(b != 1980))

})

test_that("get_auselection produces error messages", {

  skip_if_offline()
  skip_on_cran()

  #expect error when provided an incorrect parameter argument
  expect_error(AustralianElections::get_auselection("code"))
  expect_error(AustralianElections::get_auselection("votingdata"))

  #expect error when provided a non-character string
  expect_error(AustralianElections::get_auselection(voting_data, year = 2018))

  #expect error when year is non-numeric
  expect_error(AustralianElections::get_auselection("byelections", year = "2018"))

  #expect error when provided an incorrect operator
  expect_error(AustralianElections::get_auselection("voting_data", opr = "=<", year = 2018))
})

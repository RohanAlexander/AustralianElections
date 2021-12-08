test_that("function returns the correct dataset",{

  a <- AustralianElections::auselect_twopp()
  b <- colnames(a)
  expect_true("uniqueID" %in% b)

  d <- AustralianElections::auselect_twopp(w_ids = F)
  e <- colnames(d)
  expect_true(!("uniqueID" %in% e))
})

test_that("function properly filters for where twopp == 1",{

  f <- AustralianElections::auselect_twopp()
  g <- as.integer(f$twoPP)
  expect_setequal(g, 1)

  h <- AustralianElections::auselect_twopp(w_ids = F)
  i <- as.integer(f$twoPP)
  expect_setequal(g, 1)
})

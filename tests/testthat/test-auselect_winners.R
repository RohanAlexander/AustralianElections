test_that("function downloads correct dataset", {

  t <- AustralianElections::auselect_winners()
  u <- colnames(t)
  expect_true("uniqueID" %in% u)

  d<- AustralianElections::auselect_winners(w_ids = F)
  e <- colnames(d)
  expect_true(!("uniqueID" %in% e))
})


test_that("function properly filters winnerDummy column values",{

  x <- AustralianElections::auselect_winners()
  y <- x$winnerDummy
  expect_setequal(y, 1)

  a <- AustralianElections::auselect_winners(w_ids = F)
  b <- a$winnerDummy
  expect_setequal(b, 1)
})

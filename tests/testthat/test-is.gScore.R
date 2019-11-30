library(SNPgrou)
context("is.gScore")
data("hapData")

gScore <- gws(hapData,5)


test_that("Funtion return the correct result", {
  expect_true(is.gScore(gScore))})

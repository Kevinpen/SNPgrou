library(SNPgrou)
context("gws")
data("hapData")


test_that("The result of the function is a gScore oblect", {
  expect_is(gws(hapData,2),"gScore")
  expect_is(gws(hapData,2),"data.frame")
})

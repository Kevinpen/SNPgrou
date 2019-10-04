library(SNPgrou)
context("gws")
data("hapData")

test_that("The result of the function is a ggplot", {
  expect_is(gws(hapData,3),"ggplot")
})

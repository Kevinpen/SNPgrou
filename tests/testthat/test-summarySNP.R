library(SNPgrou)
context("summarySNP")
data("geneSNP")
s3 <- prep(geneSNP$snp10003)

test_that("Function return correct values", {
  expect_equal(summarySNP(s3)$frequency[1], 15)
  expect_equal(summarySNP(s3)$frequency[2], 32)
  expect_equal(summarySNP(s3)$frequency[3], 18)
  expect_equal(summarySNP(s3)$frequency[4], 16)
})

library(SNPgrou)
context("snpgrou")
data("geneSNP")

test_that("The result of 100 repeat times of cross-validation round to 1 decimal place for the sample data", {
  expect_equal(round(unname(snpgrou(geneSNP,100)["snp10001"]),1),0.3)
  expect_equal(round(unname(snpgrou(geneSNP,100)["snp10002"]),1),0.8)
  expect_equal(round(unname(snpgrou(geneSNP,100)["snp10003"]),1),0.3)
  expect_equal(round(unname(snpgrou(geneSNP,100)["snp10005"]),1),0.3)
  expect_equal(round(unname(snpgrou(geneSNP,100)["snp10008"]),1),0.3)
})

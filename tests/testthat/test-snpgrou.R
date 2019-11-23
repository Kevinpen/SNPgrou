library(SNPgrou)
context("snpgrou")
data("geneSNP")

set.seed(1234)
x=geneSNP
rep=10
snpgrou<-
  function(x,rep)

test_that("The result of 100 repeat times of cross-validation round to 1 decimal place for the sample data", {
  expect_equal(unname(snpgrou(x,rep)["snp10001"]),0.3166901)
  expect_equal(unname(snpgrou(x,rep)["snp10002"]),0.8362573)
  expect_equal(unname(snpgrou(x,rep)["snp10003"]),0.3582222)
  expect_equal(unname(snpgrou(x,rep)["snp10005"]),0.3354503)
  expect_equal(unname(snpgrou(x,rep)["snp10008"]),0.3279649)
})

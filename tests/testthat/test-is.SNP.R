library(SNPgrou)
context("is.SNP")
data("geneSNP")

s3 <- prep(geneSNP$snp10003)


    test_that("Funtion return the correct result", {
      expect_true(is.SNP(s3))})

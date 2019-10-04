library(SNPgrou)
context("prep")
data("geneSNP")

test_that("Return object is of the correct class", {
  expect_is(prep(geneSNP$snp10001,"-"), "SNP")
  expect_is(prep(geneSNP$snp10002,","), "factor")
})

test_that("Return object gives the correct atrributes", {
  expect_match(attributes(prep(geneSNP$snp10001,"-"))$alleleNames, "[TCG]")
  expect_match(attributes(prep(geneSNP$snp10002,","))$alleleNames, "[A/C/G]")
  expect_match(attributes(prep(geneSNP$snp10002,","))$levels, "[A/C C/C G/C]")
})

test_that("The first element of return values is correct", {
  expect_match(as.character(prep(geneSNP$snp10003))[1],"A/T")
  expect_match(as.character(prep(geneSNP$snp10001,"-"))[1],"T/T")
  expect_match(as.character(prep(geneSNP$snp10002,","))[1],"C/C")
})

test_that("The function throw error when wrong input parameter is given",{
expect_error(prep(geneSNP$snp10001,","),"The delimiter you specified does not contained in your data")
expect_error(prep(geneSNP$snp100011,"-"),"No input data found.")

})

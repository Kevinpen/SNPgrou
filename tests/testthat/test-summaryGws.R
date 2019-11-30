library(SNPgrou)
context("summaryGWS")
data("hapData")
 gScore <- gws(hapData, 5)


    test_that("Function return coorect values", {
      expect_equal(summaryGws(gScore)[1],"rs6691424")
      expect_equal(summaryGws(gScore)[2],"rs7553868")
      expect_equal(summaryGws(gScore)[3],"rs10922638")
      expect_equal(summaryGws(gScore)[4],"rs12097782")
      expect_equal(summaryGws(gScore)[5],"rs6428582")
    })

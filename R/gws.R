#' Genome-wide computation
#'
#' Compute gScore for every locus, data need preparation
#'
#' @param hap The data from genome wide phenotype records and SNP, in data frame format
#'   First row is the phenotype, followed by all genotype SNPs in all loci.
#'   The data scoure: from "SNPassoc" package, but phenotype data are simulated from binary to 3 levels
#' @param rep The number of replication of cross-validation in calculating gScore
#'   (In genome-wide computation, larger than 10 rep will be slow)
#'
#'
#' @return The object of type "gScore", with attribute of "filt", the actual gScores and other
#' results can be get from summary.gws function
#'
#' @examples
#'
#' data(hapData)
#' gScore <- gws(hapData,3)
#'
#'
#' @export


gws <-
  function(hap, rep) {
    if (!(is.data.frame(hap))) {
      stop("The data input format need to be data frame.")
    }

    # SNP data with only one allele cannot be used in linear discriminat analysis,
    #   and clealy no strong relation with phenotype(because pehnotype response have mutiple
    #   levels), so they should be filted out. np records the column need fileted.
    # Transpose dataframe to stick to the custom of use row as observation, columns as attributes
    hap <- as.data.frame(t(hap))
    np <- NULL
    for (j in 2:length(hap)) {
      if (length(unique(stats::na.omit(hap[, j]))) == 1) {
        np <- c(np, j)
      }
    }
    filt <- colnames(hap[, np]) # store unused loci name
    hap <- hap[,-np]

    # Columns with too high correlation coeffcient result in collinearity and prevent lda
    #   function to proceed anlysis, this situation rarely happen in real scenarios, but
    #   to prevent program from crash they also should be filted out. If it did happen, then the
    #   locus is highgly relevent and should be printed out. np2 records columns with high
    #   correlation. Transfer the columns from factor to numeric first.
    hap <- hap
    for (i in seq(along = hap)) {
      hap[, i] <- as.numeric(hap[, i])
    }
    # Missing values can't used in calculation
    hap[is.na(hap)] <- 0
    np2 <- NULL
    for (i in 2:length(hap)) {
      corr.matrix <- stats::cor(hap[, 1], stats::na.omit(hap[, i]))
      if (corr.matrix > 0.95) {
        np2 <- c(np2, i)
        message("High correlation:", names(hap[i]), corr.matrix)
      }
    }
    if (!(is.null(np2))) {
      hap <- hap[,-np2]
    }

    # Begin calculation of gScore using snpgrou function
    gScore <- snpgrou(hap, rep)
    gScore <- data.frame("y" = gScore, "x" = names(gScore))

    #Create object of class "gScore"
    class(gScore) <- c("gScore", "data.frame")
    attr(gScore, "filt") <- filt

    return(gScore)

  }
# [END]

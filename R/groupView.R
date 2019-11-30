#' Visualization of association of multiple loci with phenotype
#'
#' Use lda function to train linear discriminant model from SNP data, then use this model to
#'  predicate phenotype, use ggplot visualize how well the predication separate the phenotype
#'  to groups
#'
#' @param genesnp The data frame of mutiple loci SNP data.
#'   First column is the phenotype, followed by all genotype SNPs.
#'
#'
#' @return The generated plot, showing how well the SNPs predicate the phenotype, if there are
#'    strongly related loci in the data set then the plot will show well separated grouos, but
#'    which locus is most strongly related is not showing
#'
#' @examples
#' require(ggplot2)
#' data(geneSNP)
#  groupView(geneSNP)
#'
#'
#'
#' @import MASS
#' @import ggplot2
#' @export



groupView <-
    function(genesnp){
    if (! (is.data.frame(genesnp))) {
        stop("The data input format need to be data frame.")
    }


    # If the SNP data is not of type "SNP", then it should be prepared and transfer type first
    for (j in 2:ncol(genesnp)) {
        x <- genesnp[ , j]
        if (! ( inherits(x, "SNP"))) {
        genesnp[[j]] <- prep(x)
      }
    }


    # Train the lda model with input data
    train <- MASS::lda(formula = phenRes~., data=genesnp)

    # Make prediction for phenotype from the model
    snpPredict <- predict.lda(train)
    predData <- data.frame("phenotype" = genesnp$phenRes, lda = snpPredict$x)

    # Plot the predicated data
    plot <- ggplot2::ggplot(predData) + geom_point(aes("x" = "lda.LD1", "y" = "lda.LD2",
                                                      colour = predData$phenotype), size = 2.5)
    return (plot)
  }
# [END]

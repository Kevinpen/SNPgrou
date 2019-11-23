#' Calculate metrics for how one or multiple locus is(are) related to phenotype
#'
#' This function use linear discriminant analysis to classify response phenotype according to
#   genotype SNP, the response have more than two levels, genotype allow multi-allelic.
#'
#' @param x  A data frame containing one or multiple SNP data for every loucs, the first column
#'   is the phenotype data, follow by SNP data column. If SNP data not alraedy in "SNP" type, this
#'   function use prep function to prepare the data.
#' @param rep Integer, the number of replication for the cross-validation procedures.
#'
#'
#' @return The results of gScore for each locus
#'
#' @examples
#' require(MASS)
#' data(geneSNP)
#' snpgrou(geneSNP, 100)
#' # snp10001  snp10002  snp10003  snp10005  snp10008
#' # 0.3166901 0.8362573 0.3582222 0.3354503 0.3279649
#'
#' @import MASS
#' @export
#'
#'


######################################### Concept
# To indicate what are the most important locus(loci) in related to the observed phenotype,
# the analysis based on the idea that when using leave-one-out cross-validation to predicate
# the phenotype, those locus with strong relation to phenotype should be able to accurately
# predicate. The funtion repeatly run the procedure for "rep"(parameter) times and run for
# every locus. The result is a set of "gScore" for every locus. The concept of gScore is inspired
# by the concept of "Classification accuracy" in the package "genephen", which use other
# statistical learning cross-validation. This function used lda function with cross-validation
# mode in MASS package. Choose too large iteration time will be slow(several hundreds should be OK).

snpgrou<-
    function(x, rep) {
    if (is.null(x)) {
        stop("No input data found.")
    }
    if (! (is.data.frame(x))) {
        stop("The data input format need to be data frame.")
    }
    if (rep < 1) {
      stop("Please specify an interger greater than 1 for rep.")
    }

    y <- x[ , 1]
    n <- length(unique(y))
    m <- ncol(x) - 1
    gScore <- numeric(m) # empty vector for later calculation to fill in
    rawScore <- array(numeric(), c(rep,m))# empty array for later calculation to fill in

    # Iteration for the procedure
    for (i in 1:rep) {

    # Run for every locus
    for (j in 1:m) {
        x1 <- x[ , j+1]

        # If the SNP data is not of type "SNP", then it should be prepared and transfer type first
        if (! ( inherits(x1, "SNP"))) {
            x[ , j+1]<- prep(x1)
        }

        # The parameter of lda function CV=TRUE, use cross-validation
        geneLda <- MASS::lda(formula = y ~ x1, CV = TRUE)
        tab <- table(y, geneLda$class)
        prop <- numeric(n)

        # Calculate the prportion of correct predication
        for (k in 1:n) {
            prop[k]<-tab[k, k]/sum(tab[k, ])
        }
        prop <- mean(prop)
        rawScore[i,j] <- prop
      }
    }
    gScore <- colMeans(rawScore)
    names(gScore) <- colnames(x)[2 : ncol(x)]

    # Result gScore indicate the importance of each locus in predicating phenotype
    return(gScore)

}
# [END]

#' Genome-wide computation and visualization
#'
#' Compute gScore for every locus and use ggplot to plot all the scores, data need preparation
#'
#' @param hap The data from genowide phenotype records and SNP, in data frame format
#'   First column is the phenotype, followed by all genotype SNPs.
#'   The data scoure: from "SNPassoc" package, but phenotype data are simulated from binary to 3 levels
#' @param rep The number of replication of cross-validation in calculating gScore
#'   (In genome-wide computation, larger than 10 rep will be slow)
#'
#'
#' @return The generated plot, showing gScores of all loci, the actual gScores and most
#'    strongly related loci can be get from summary.gws function
#'
#' @examples
#' require(ggplot2)
#' data(hapData)
#' gws(hapData,5)
#'
#'
#' @export
#' @import ggplot2

gws <-
    function(hap,rep){
    #requireNamespace(ggplot2)

    # SNP data with only one allele cannot be used in linear discriminat analysis,
    #   and clealy no strong relation with phenotype(because pehnotype response have mutiple
    #   levels), so they should be filted out. np records the column need fileted.
    np <- NULL
    for (j in 2:length(hap)) {
        if (length(unique(na.omit(hap[ , j ]))) == 1){
            np <- c(np,j)
        }
    }
    hap <- hap[ , -np]

    # Columns with too high correlation coeffcient result in collinearity and prevent lda
    #   function to proceed anlysis, this situation rarely happen in real scenarios, but
    #   to prevent program from crash they also should be filted out. If it did happen, then the
    #   locus is highgly relevent and should be printed out. np2 records columns with high
    #   correlation. Transfer the columns from factor to numeric first.
    hap1 <- hap
    for (i in seq(along = hap)) {
        hap1[ , i] <- as.numeric(hap1[ , i])
    }
    # Missing values can't used in calculation
    hap1[is.na(hap1)] <- 0
    np2 <- NULL
    for (i in 2:length(hap1)){
        corr.matrix <- cor(hap1[ , 1], na.omit(hap1[ , i]))
        if (corr.matrix > 0.95 ){
        np2 <- c(np2, i)
        message("High correlation:", names(hap1[i]), corr.matrix)}
    }
    if (! (is.null(np2))) {
        hap1 <- hap1[ , -np2]
    }

    # Begin calculation of gScore using snpgrou function
    hScore <- snpgrou(hap1, rep)
    hscd <- data.frame("y"=hScore, "x" = names(hScore))

    # Plot the gScore of all loci
    plot <- ggplot2::ggplot(hscd,aes(x = x, y = y))+
      geom_point(size=1,colour="red") +
      geom_segment(aes(x=x,  xend=x, y=0, yend=y)) +
      theme( axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
      labs(x="chrosomal_position",y="gScore")
    return(plot)

}
# [END]

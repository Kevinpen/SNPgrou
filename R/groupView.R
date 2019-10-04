#' Genowide computation and visualization
#'
#' Computer gScore for every locus and use ggplot to plot all the scores, data need preparation
#'
#' @param hap The data from genowide phenotype records and SNP, in data frame format
#'   First column is the phenotype, followed by all genotype SNPs.
#'   The data scoure: from "SNPassoc" package, but phenotype data are simulated from binary to 3 levels
#' @param rep The number of replication of cross-validation in calculating gScore
#'   (In genowide computation, larger than 10 rep will be slow)
#'
#'
#' @return The generated plot, showing gScores of all loci, the actual gScores and most
#'    strongly related loci can be get from summary.gws function
#'
#' @examples
#' require(ggplot2)
#' require(MASS)
#' data(hapData)
#' gws(hapData,5)
#'
#'
#' @export



groupView<-
  function(genesnp){
    if(!(is.data.frame(genesnp))) {
      stop("The data input format need to be data frame.")
    }
#    If the SNP data is not of type "SNP", then it should be prepared and transfer type first
    for(j in 2:ncol(genesnp)){
      x<-genesnp[ , j]
      if (!( inherits(x, "SNP"))) {
      genesnp[[j]]<-prep(x)
      }
    }

    require(MASS)
    train<-lda(phenRes~.,data=genesnp)
    snp_predict<-predict(train)
    pred_data <- data.frame(phenotype=geneSNP$phenRes,lda = snp_predict$x)
    plot<-ggplot(pred_data) + geom_point(aes(lda.LD1, lda.LD2, colour = phenotype), size = 2.5)
    return (plot)
  }

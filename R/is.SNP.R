#' Decide whether the data is of type "SNP"
#'
#'
#' @param SNP The result data returned from prep() function, an object of class factor and SNP,
#' it contains levels of genotype and attribute of "alleleNames"
#'
#'
#' @return TURE if input is of class 'SNP', FALSE otherwise
#'
#' @examples
#'
#' data(geneSNP)
#' s3 <- prep(geneSNP$snp10003)
#' is.SNP(s3)
#' TRUE
#'
#'
#' @export
#'


is.SNP <- function(SNP){
  return(inherits(SNP, "SNP"))
}

#' Summarize the frequency and percentage of genotypes and alleles in the SNP data
#' The input SNP data need prepared by prep() function
#'
#'
#' @param x The result data returned from prep function. it is a object of type "SNP" and "factor"
#'  it contains levels of genotype and attribute of "alleleNames"
#'
#'
#' @return NULL
#' @export
#' @examples
#' data(geneSNP)
#' s3 <- prep(geneSNP$snp10003)
#' summarySNP(s3)
#' #This data contains Genotypes:
#' #Genotyepes frequency percentage
#' #1        A/T        15      30.61
#' #2        C/C         1       2.04
#' #3        C/T         1       2.04
#' #4        G/C        16      32.65
#' #5        G/G        16      32.65
#' #
#' #
#'#This data contains Alleles:
#'#Alleles frequency petcentage
#'#1       A        15      18.52
#'#2       G        32      39.51
#'#3       C        18      22.22
#'#4       T        16      19.75



summarySNP <- function(x) {
  if (!(is.factor(x))) {
    stop("The data input format need to be factor.")
  }
  if (!(is.SNP(x))) {
    stop("The data input format need to be of type SNP.")
  }

  #Retrieve genotyep data from input
  genoType <- as.character((table(x)))
  names <- names(table(x))

  # Calulate percentage of each genotype
  prop <- round(as.numeric(prop.table(table(x)) * 100),2)

  # Build data frame for genotype
  geno <-
    data.frame(
      "Genotyepes" = names,
      "frequency" = genoType,
      "percentage" = prop
    )

  # Retrieve allele data from input attribute
  alleles <- attr(x, "alleleNames")

  # Calculate frequence of each allele in the input
  alleleFreq <- numeric()
  for (allele in alleles) {
    alleleFreq <-
      c(alleleFreq, length(grep(allele, as.character(x))))
  }

  # Calculate percentage of each allele
  alleProp <- round(prop.table(alleleFreq) * 100, 2)

  # Build data frame for allele
  alleDf <-
    data.frame(
      "Alleles" = alleles,
      "frequency" = alleleFreq,
      "petcentage" = alleProp
    )

  # Display summary of this SNP
  cat("This data contains Genotypes:\n")
  print(geno)

  cat("\n\n This data contains Alleles:\n")
  print(alleDf)

}




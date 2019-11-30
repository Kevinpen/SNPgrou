#' Summarize the actual gScore and other results from genome wide computation of gws()
#' The input gScore must obtain from gws() return
#'
#'
#' @param gScore The result data returned from genome wide computation of function gws, in data frame format
#'   First column is gSCore, followed by the related names of the loci in second column.
#'
#' @param threshold Define high gSore ss values that greater than this parameter
#'
#' @return NULL
#' @export
#' @examples
#'
#' data(hapData)
#' gScore <- gws(hapData, 5)
#' summaryGws(gScore)
#' #Found gScore values greater than 0.60 and responsible loci in the data:
#' #High gScore 0.787037 at chrosomal position: rs4661627"
#' #High gScore 0.675926 at chrosomal position: rs12749939"
#' #Loci below are excluded from the calculation because snnp data only contain one allel
#' #rs6691424 rs7553868  rs10922638 rs12097782 rs6428582
#' #rs12739867" rs189401   rs282036   rs526519   "rs2818971
#' #rs12756456
#' # summaryGws(gScore,0.7)
#' #Found gScore values greater than 0.70 and responsible loci in the data:
#' #High gScore 0.787037 at chrosomal position: rs4661627
#' #Loci below are excluded from the calculation because snnp data only contain one allel
#' #rs6691424  rs7553868  rs10922638 rs12097782 rs6428582
#' #rs12739867 rs189401   rs282036   rs526519   rs2818971
#' # rs12756456



summaryGws <- function(gScore, threshold = 0.6) {
  if (!(is.data.frame(gScore))) {
    stop("The data input format need to be data frame.")
  }
  if (!(is.gScore(gScore))) {
    stop("The data input format need to be of format gScore.")
  }

  # Loci with high gScores are more responsible for the observed phenotype
  cat(
    sprintf(
      "Found gScore values greater than %.*f and responsible loci in the data:  \n",
      2,
      threshold
    )
  )
  for (y in gScore$y) {
    if (y > threshold) {
      position <- which(gScore$y == y)
      cat(sprintf(
        "High gScore %f at chrosomal position: %s\n",
        y,
        as.character(gScore[position, 2])
      ))
    }
  }
  #Summary data not used in calculation in gws function
  cat("\n Loci below are excluded from the calculation because snp data only contain \n one allele:\n")
  cat(attr(gScore, "filt"))

  return(NULL)
}
# [END]

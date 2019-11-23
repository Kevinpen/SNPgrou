#' Decide whether the data is of type "gScore"
#'
#'
#' @param gScore The result data returned from genome wide computation of function gws, in data frame format
#' First column is gSCore, followed by the related names of the loci in second column.
#'
#'
#' @return TURE if input is of class 'gSore', FALSE otherwise
#'
#' @examples
#'
#' data(hapData)
#' gScore <- gws(hapData,5)
#' is.gScore(gScore)
#' [1] TURE
#'
<<<<<<< HEAD
#'
#'
#'
=======
#' @export
#' @import
>>>>>>> 603ed0329075d4976e2ab02777eb90b3035fc2b7

is.gScore <- function(gScore){
 return(inherits(gScore, "gScore"))
}

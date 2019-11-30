#' Plot visualization of genome-wide computation
#' Plot function for gScore type data
#'
#'
#' @param gScore The result data returned from genome wide computation of function gws, in data frame format
#'   First column is gSCore, followed by the related names of the loci in second column.
#'
#'
#' @return The generated plot using ggplot2, showing gScores of all loci
#' @export
#' @examples
#'
#' data(hapData)
#' gScore <- gws(hapData,5)
#' plotGws(gScore)
#'
#'
#'
#' @import ggplot2
#'


plotGws <- function(gScore){

  if (! (is.data.frame(gScore))) {
    stop("The data input format need to be data frame.")
  }
  if (! (is.gScore(gScore))) {
    stop("The data input format need to be of format gScore.")
  }

# Plot the gScore of all loci
  plot <- ggplot2::ggplot(gScore,aes(x = gScore$x, y = gScore$y))+
  geom_point(size=1,colour="red") +
  geom_segment(aes(x=gScore$x,  xend=gScore$x, y=0, yend=gScore$y)) +
  theme( axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
  labs(x="chromosomal_position",y="gScore")
  return(plot)

}

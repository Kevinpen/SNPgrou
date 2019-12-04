#' Launch the shiny app for package SNPgrou
#'
#' A function that launches the shiny app for this package.
#' The code has been placed in \code{./inst/shiny-scripts}.
#'
#' @return No return value but open up a shiny page.
#'
#' @examples
#' \dontrun{
#' runSNPgrou()
#' }
#'
#' @export
#' @importFrom shiny runApp

runSNPgrou <- function() {
  appDir <- system.file("shiny-scripts",
                        package = "SNPgrou")
  shiny::runApp(appDir, display.mode = "normal")
  return()
}

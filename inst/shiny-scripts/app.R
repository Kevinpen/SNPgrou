library(shiny)
data("geneSNP")
data("geneSNP2")

ui <- fluidPage(
  titlePanel("groupView"),

  sidebarLayout(
    sidebarPanel(
      helpText("Choose a SNP data to see how well it can predict phenotypic group"
              ),

      selectInput("var",
                  label = "Choose a variable to display",
                  choices = c("geneSNP",
                              "geneSNP2"),
                  selected = "geneSNP"),

    ),

    plotOutput('plot1',width = "580px", height = "260px")
    )
  )



server <- function(input, output) {
  output$plot1 <- renderPlot({
  snpdata <- switch(input$var,
                 "geneSNP" = geneSNP,
                 "geneSNP2" =geneSNP2)
  groupView(snpdata)

})
}

shinyApp(ui = ui, server = server)

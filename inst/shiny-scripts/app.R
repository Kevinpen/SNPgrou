library(shiny)
data("geneSNP")
data("geneSNP2")

ui <- fluidPage(
  titlePanel("SNPgrou"),

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
    mainPanel(
      h4("gScores"),
      "The gScores of every loci in this SNP data:\n",
      textOutput("selected_var"),
      h4("groupView:"),
    plotOutput('plot1',width = "580px", height = "260px"))
    )
  )



server <- function(input, output) {


  output$plot1 <- renderPlot({
    snpdata <- switch(input$var,
                      "geneSNP" = geneSNP,
                      "geneSNP2" =geneSNP2)
  groupView(snpdata)
  })

  output$selected_var <- renderText({
    snpdata <- switch(input$var,
                      "geneSNP" = geneSNP,
                      "geneSNP2" =geneSNP2)
    gScore<-snpgrou(snpdata,30)
    paste( names(gScore),":",  round(gScore,7))
  })

}

shinyApp(ui = ui, server = server)

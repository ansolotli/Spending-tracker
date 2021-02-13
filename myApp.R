library(shiny)
library(ggplot2)
library(googlesheets4)

#importing data from a Google spreadsheet
link <- includeText("link.txt")
data <- read_sheet(link)

title <- titlePanel("Spending tracker")
main <- sidebarLayout(
  sidebarPanel(
    
  ),
  mainPanel(
    plotOutput(outputId = "p")
  )
)

ui <- fluidPage(title, main)

#total expenses of 2019
server <- function(input, output) {
  output$p <- renderPlot({
    ggplot(data, aes(x = Month, y = Total)) +
      geom_bar(stat="identity") +
      scale_x_discrete(limits=data[1:12,]$Month)
  })
}

shinyApp(ui = ui, server = server)
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
    plotOutput(outputId = "budget_per_year")
  )
)

ui <- fluidPage(title, main)

#total expenses per year
server <- function(input, output) {
  
  output$budget_per_year <- renderPlot({
    
    data$Year <- as.factor(data$Year)
    
    ggplot(data, aes(x = Month, y = Total, group = Year, fill = Year)) +
      geom_bar(stat="identity", position = "dodge") +
      scale_x_discrete(limits = month.name) +
      theme_classic() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
      scale_fill_brewer()
    
  })
}

shinyApp(ui = ui, server = server)
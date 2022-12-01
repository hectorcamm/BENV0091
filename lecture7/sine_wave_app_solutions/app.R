library(shiny)
library(tidyverse)

# Front-end (UI)
ui <- fluidPage(
  titlePanel("My Sine Wave"),
  p("This app studies the function y = sin(cx)"),
  hr(),
  sidebarLayout(
    sidebarPanel(sliderInput(inputId = "num", 
              label = "Choose a number", 
              value = 2, min = 0.1, max = 10)),
    mainPanel(plotOutput("wave"))
  )
)

# R Code (server)
server <- function(input, output) {
  
  value <- reactive(input$num)
  
  output$wave <- renderPlot({
    data <- tibble(x = seq(0, 2*pi, 0.01),
                   y = sin(input$num * x))
    ggplot(data, aes(x = x, y = y)) + geom_line()
  })
}

# Run the application
shinyApp(ui = ui, server = server)












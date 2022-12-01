library(shiny)

ui <- fluidPage(
  titlePanel("My App")
)

server <- function(input,output){
  
}

shinyApp(ui = ui, server = server)
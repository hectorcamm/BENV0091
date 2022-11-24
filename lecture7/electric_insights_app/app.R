library(shiny)
library(tidyverse)
library(lubridate)


# Read data
df <- read_csv('data/electric_insights_2020.csv')
df <- df %>%
  mutate(week = week(local_datetime))

# Read the file
source('electric_insights_plot.R')

# Front-end (UI)
ui <- fluidPage(
  titlePanel("GB Fuel Mix by Week (2020)"),
  sliderInput(inputId = "week_no", 
              label = "Choose a week number", 
              value = 1, min = 1, max = 52, step = 1),
  plotOutput("fuel_plot")
)

# R Code (server)
server <- function(input, output) {
  output$fuel_plot <- renderPlot(plot_generation(df, input$week_no))
}

# Run the application
shinyApp(ui = ui, server = server)




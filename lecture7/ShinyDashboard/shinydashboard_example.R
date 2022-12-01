# Libraries ----
library(shiny)
library(shinydashboard)
library(shinyjs)
library(tidyverse)



# Initialize Data ----
dat <- readRDS(file = "app-data/subregion_agg.rds")


# UI ----
ui <- dashboardPage(skin = "yellow",
  
  #### Header ----
  dashboardHeader(
    title = "COVID-19 Country Comparison",
    titleWidth = 350
  ),
  #### Sidebar ----
  dashboardSidebar(
    
    width = 350,
    br(),
    h4("Select Your Inputs Here", style = "padding-left:20px"),
    
    # metric Input ----
    selectInput(
      inputId = "metric", 
      label = strong("Select Metric:", style = "font-family: 'arial'; font-size:12px"),
      choices =  colnames(dat)[4:ncol(dat)],
      selected = "new_confirmed"
    ),
    
    # country Input ----
    selectInput(
      inputId = "country", 
      multiple = TRUE,
      label = strong("Select Countries to Compare:", style = "font-family: 'arial'; font-size:12px"),
      choices = sort(unique(dat$country_name)),
      selected = c("United States of America","France","Canada")
    ),
    
    # date_range_country Input ----
    dateRangeInput(
      inputId = "date_range_country",
      label = "Select Date Range:",
      start = "2020-01-01",
      end   = "2020-12-31"
    )
    
  ),
  #### Body ----
  dashboardBody(
    tabsetPanel(
      type = "tabs",
      id = "tab_selected",
      tabPanel(
        title = "Country View",
        plotOutput("plot_data_country")
      )
    )
  )
)

server <- function(input, output) {
  
  observe( print(input$metric) )
  observe( print(input$country) )
  observe( print(input$date_range_country[1]) )
  
  
  # 1 - Data Cleaning Functions ----
  # 01.A clean_data_country() ----
  clean_data_country <- reactive({
    clean_dat <- dat %>%
      select( !subregion1_name ) %>%
      filter( country_name %in% input$country & date >= input$date_range_country[1] & date <= input$date_range_country[2]) %>%
      group_by(country_name,date) %>%
      summarise_all(sum) %>%
      select( country_name, date, input$metric) %>%
      set_names( c("country_name","date","metric")) %>% 
      arrange(date)
  })
  
  output$plot_data_country <- renderPlot({
    ggplot( data = clean_data_country(), aes(y = metric, x = date, color = country_name) ) +
      geom_line(size = 1.5) +
      labs(color="Country Name") 
  })
  
}

shinyApp(ui, server)
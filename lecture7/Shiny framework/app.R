# Libraries ----
library(shiny)
library(shinydashboard)



# UI ----
ui <- fluidPage(

  div(
    titlePanel("Basic UI code"),
  "Hello World",
  br(),
  p("My first paragraph"),

  br(),
  hr()),

# Splitting the page ------------------------------------------------------
h1("Splitting up the page",align="center",
   # style="color:red;"
   ),
splitLayout(cellWidths = c("25%","50%","25%"),
            h3("25% width"),
            h3("50% width",align="center"),
            h3("25% width"),
),
br(),
fluidRow(
  column(width= 6,
         p("This is a column with a width of 6 ~ 50% of the page")
  ),
  column(width= 6,
         p("This is a column with a width of 6 ~ 50% of the page")
  )
),


br(),
hr(),


  h1("Inputs",align="center"),
  selectInput(
    inputId = "first_input",
    label = "Select a Number",
    choices = c(1,2,3,4,5,6,7,8,9,10)
    #multiple = TRUE,
    #selected = 7
  ),

  numericInput(
    inputId = "second_input",
    label = "Select a Number",
    value = 5,
    min = 1, max = 20, step = 1
  ),

  sliderInput(inputId = "num",label = "choose a number",value=2,min=0.1,max=10,step = 0.1
  ),

  verbatimTextOutput("power")
)

server <- function(input, output) {

  # ERROOOR :
  # print(input$first_input)

  # Viewing Inputs ----------------------------------------------------------

  observe(print(input$first_input))
  observe(print(input$first_input))
  observe(print(input$first_input))



  # Server side operations --------------------------------------------------

  observe({
    print( as.numeric( input$first_input ) ** input$second_input)
  })

  make_power <- function(x, y) { as.numeric(x) ** as.numeric(y) }

  output$power <- renderText({ make_power( input$first_input, input$second_input )})


}

shinyApp(ui, server)

library(shinythemes)
library(shinyWidgets)

ui <- fluidPage(
  theme = shinytheme('cerulean'),
  h2("Penguins App"),
  sidebarLayout(
    sidebarPanel(width = 3,
      selectInput("select_islands", "Select island:", 
                  choices = select_input_islands, 
                  multiple = TRUE, 
                  selected = select_input_islands),
    ),
    
    mainPanel(
      plotOutput(outputId = "species_count_plot", width = '600px',height = 300),
      br(),
      plotOutput(outputId = "species_hist_plot",width = '600px',height = 300),
      br(),
    )
  )
)
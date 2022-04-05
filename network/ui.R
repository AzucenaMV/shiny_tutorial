#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# https://github.com/datastorm-open/visNetwork/issues/46
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          selectInput(inputId = "selnodes", label = "Nodes selection", choices = 1:15, multiple = TRUE), # This is not doing anything :)
          actionButton("zoom", "Zoom")
          
        ),

        # Show a plot of the generated distribution
        mainPanel(
          visNetworkOutput("network"),
          dataTableOutput('networkTable'),
          verbatimTextOutput("shiny_return"),
        )
    )
))

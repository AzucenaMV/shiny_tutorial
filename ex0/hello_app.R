library(shiny) # This line loads the library
ui <- fluidPage( # Creates a dynamic HTML user interface
  "Hello, world!" 
)
server <- function(input, output, session) {
  # The magic happens here
}
shinyApp(ui, server)
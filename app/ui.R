library('shinythemes')

ui <- fluidPage(
  theme = shinytheme("superhero"),
  #theme = shinytheme('cerulean'),
  h2("Penguins App"),
  sidebarLayout(
    sidebarPanel(width = 3,
      div(img(src = "https://github.com/allisonhorst/palmerpenguins/raw/master/man/figures/lter_penguins.png", width = '95%'),style ="text-align: center;"),
      selectInput("select_species", "Select species:", 
                  choices = select_input_species, multiple = TRUE),
      selectInput("select_islands", "Select island:", 
                  choices = select_input_islands, multiple = TRUE),
      checkboxGroupInput("radio_sex", "Select sex:",
                   choices = list("female" = 'female', "male" = 'male'),
                   selected = c('female','male')),
      radioButtons("plot", "Select graph:",
                   choices = list("Histogram" = 'hist', "Boxplot" = 'boxplot')),
      varSelectInput("variable1", "Variable 1:", penguins %>% select(body_mass_g, flipper_length_mm, bill_depth_mm, bill_length_mm), multiple = FALSE, selected = 'body_mass_g'),
      varSelectInput("variable2", "Variable 2:", penguins %>% select(body_mass_g, flipper_length_mm, bill_depth_mm, bill_length_mm), multiple = FALSE, selected = 'flipper_length_mm'),
      #div(img(src = "https://allisonhorst.github.io/palmerpenguins/reference/figures/culmen_depth.png", width = '80%'),style ="text-align: center;"),
      
    ),
    
    mainPanel(
      plotOutput(outputId = "species_count_plot", width = '600px',height = 250),
      br(),
      conditionalPanel(
        condition = "input.plot == 'hist'",
        plotOutput("species_hist_plot",width = '600px',height = 280)
      ),
      conditionalPanel(
        condition = "input.plot == 'boxplot'",
        plotOutput("species_box_plot",width = '600px',height = 280)
      ),
      br(),
      plotOutput('species_correlation_plot', width = '600px',height = 300),
      br(),
    )
  )
)
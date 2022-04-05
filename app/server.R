server <- function(input, output) {
  penguins_subset <- reactive({
    #s_species <- input$select_species
    s_islands <- input$select_islands
    s_sex <- input$radio_sex
    
    if(is.null(input$select_species)){
      s_species <- select_input_species
    }else{
      s_species <- input$select_species
    }
    
    if(is.null(input$select_islands)){
      s_islands <- select_input_islands
    }else{
      s_islands <- input$select_islands
    }
    
    if(is.null(input$radio_sex)){
      s_sex <- unique(penguins$sex)
    }else{
      s_sex <- input$radio_sex
    }
    #islands <- input$select_islands
    print(s_islands)
    penguins %>%
      filter(species %in% s_species & island %in% s_islands & sex %in% s_sex)

  })
  
  output$species_count_plot <- renderPlot({
    shiny::validate(
      need(nrow(penguins_subset())>0, "Oops, no observations were found with those filters!")
    )
    penguins_subset() %>%
    count(species) %>%
      ggplot() + geom_col(aes(x = species, y = n, fill = species)) +
      geom_label(aes(x = species, y = n, label = n)) +
      scale_fill_manual(values = c('Adelie'="darkorange",'Gentoo' = "cyan4",'Chinstrap' = "purple")) +
      theme_minimal()+
      labs(title = 'Penguins Species Count', x = 'Species', y = 'Counts')

    
  })
  
  vars <- reactiveValues()
  names <- reactiveValues()
  
  observe({
    vars$v1 <- input$variable1
    vars$v2 <- input$variable2
  })
  
  observe({
    if (input$variable1 == 'bill_length_mm') names$v1 <- 'Bill length (mm)'
    if (input$variable1 == 'bill_depth_mm') names$v1 <- 'Bill depth (mm)'
    if (input$variable1 == 'flipper_length_mm') names$v1 <- 'Flipper length (mm)'
    if (input$variable1 == 'body_mass_g') names$v1 <- 'Body mass (g)'
    
    if (input$variable2 == 'bill_length_mm') names$v2 <- 'Bill length (mm)'
    if (input$variable2 == 'bill_depth_mm') names$v2 <- 'Bill depth (mm)'
    if (input$variable2 == 'flipper_length_mm') names$v2 <- 'Flipper length (mm)'
    if (input$variable2 == 'body_mass_g') names$v2 <- 'Body mass (g)'
  })
  
  output$species_hist_plot <- renderPlot({
    shiny::validate(
      need(nrow(penguins_subset())>0, "Oops, no observations were found with those filters!")
    )

  ggplot(data = penguins_subset(), aes_string(x = vars$v1)) +
    geom_histogram(aes(fill = species), 
                   alpha = 0.5, 
                   position = "identity") +
    scale_fill_manual(values = c('Adelie'="darkorange",'Gentoo' = "cyan4",'Chinstrap' = "purple")) +
    theme_minimal() +
    labs(x = names$v1,
         y = "Frequency",
         title = paste0("Penguin ",str_replace(tolower(names$v1)," \\(.*\\)",""))
         )
  })
  
  output$species_box_plot <- renderPlot({
    shiny::validate(
      need(nrow(penguins_subset())>0, "Oops, no observations were found with those filters!")
    )
    var <- input$variable1
    ggplot(data = penguins_subset(), aes_string(x = 'species', y = vars$v1)) +
      geom_boxplot(aes(color = species), width = 0.3, show.legend = FALSE) +
      geom_jitter(aes(color = species), alpha = 0.5, show.legend = FALSE, position = position_jitter(width = 0.2, seed = 0)) +
      scale_color_manual(values = c('Adelie'="darkorange",'Gentoo' = "cyan4",'Chinstrap' = "purple")) +
      theme_minimal() +
      labs(x = 'Species',
           y = names$v1,
           title = paste0("Penguin ",str_replace(tolower(names$v1)," \\(.*\\)","")))
  })
  
output$species_correlation_plot <- renderPlot({  

    ggplot(data = penguins_subset(), 
           aes_string(x = vars$v1,
               y = vars$v2)) +
      geom_point(aes(color = species, 
                     shape = species),
                 size = 3,
                 alpha = 0.8) +
      scale_color_manual(values = c('Adelie'="darkorange",'Gentoo' = "cyan4",'Chinstrap' = "purple")) +
      scale_shape_manual(values = c('Adelie' = 16, 'Gentoo' = 15, 'Chinstrap' = 17)) +
      labs(title = "Penguin size, Palmer Station LTER",
           subtitle = paste(str_replace(names$v1," \\(.*\\)",""),'and',str_replace(tolower(names$v2)," \\(.*\\)","")),
           x = names$v1,
           y = names$v2,
           color = "Penguin species",
           shape = "Penguin species") +
      theme_minimal() +
      theme(legend.position = c(0.85, 0.15),
            legend.background = element_rect(fill = "white", color = NA),
            plot.title.position = "plot",
            plot.caption = element_text(hjust = 0, face= "italic"),
            plot.caption.position = "plot")
})

  

}
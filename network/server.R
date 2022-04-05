#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# https://rdrr.io/cran/visNetwork/man/visEvents.html
#https://jtr13.github.io/cc21fall2/network-visualization-in-r.html

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$network <- renderVisNetwork({
    visNetwork(nodes, edges, 
               height = "100%", width = "100%",
               main = "") %>%
      visInteraction(multiselect = TRUE) %>%
      visLayout(improvedLayout = TRUE) %>%
      visEvents(click = "function(nodes){
                  Shiny.onInputChange('click', nodes.nodes[0]);
                  Shiny.onInputChange('node_selected', nodes.nodes.length);
                  Shiny.onInputChange('selected_node_id', nodes.nodes);
                  ;}"
      )
  })
  

  # no selection (zoom-out)
  observe({
    input$node_selected
    if(!is.null(input$node_selected) && input$node_selected == 0){
      visNetworkProxy("network") %>%
        visFit(nodes = NULL)
    }
  })
  
  # zoom button
  observeEvent(input$zoom,{
    if(input$zoom && (!is.null(input$node_selected) && (input$node_selected == 1))){
    visNetworkProxy("network") %>%
      visFocus(id = input$selected_node_id, scale = 1)
    }
  })
  
  # no idea
  output$shiny_return <- renderPrint({
    if (!is.null(input$node_selected) && (input$node_selected == 1)) {
      visNetworkProxy("network") %>%
        visNearestNodes(target = input$click)
    } else {
      invisible()
    }
  })
  
  # data table
  observe({
    input$selected_node_id
    input$node_selected
    
    if(!is.null(input$selected_node_id) && (input$node_selected == 1)){ 
      output$networkTable <- renderDataTable(
        edges %>% 
          dplyr::filter((from %in% input$selected_node_id) | (to %in% input$selected_node_id)) %>%
          select(-title)
      ) 
    } else { 
      output$networkTable <- renderDataTable(NULL)
    } 
  }) 
  


})

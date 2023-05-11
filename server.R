#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

x = readRDS("eigen-newsubtrype2.RDS")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # render-ui -- cluster  ---------------------------------------------------------------
  
  output$metaID <- renderUI({
    
    
    tagList(
      selectInput(inputId = "metaclusterID", label = "Select Metadata",
                  choices = colnames(x %>% select(!matches("PC"))), selected = "NewSubType2")
      
    )
    
  })
  
  

  
  # render-ui -- pcx --------------------------------------------------------
  
  output$pcx <- renderUI({
    
    u_sel_meta = req(input$metaclusterID)
    
    tagList(
      selectInput(inputId = "pcx_ID", label = "Select PC of x-axis",
                  choices = colnames(x %>% select(matches("PC"))), selected = "PC1"))
    
    
  })
  
  # render-ui -- pcy --------------------------------------------------------
  
  output$pcy <- renderUI({
    
    u_sel_meta = req(input$metaclusterID)
    
    tagList(
      selectInput(inputId = "pcy_ID", label = "Select PC of y-axis",
                  choices = colnames(x %>% select(matches("PC"))), selected = "PC2"))
    
    
  })
  
  
  # render-ui -- pcz --------------------------------------------------------
  
  output$pcz <- renderUI({
    
    u_sel_meta = req(input$metaclusterID)
    
    tagList(
      selectInput(inputId = "pcz_ID", label = "Select PC of z-axis",
                  choices = colnames(x %>% select(matches("PC"))), selected = "PC3"))
    
    
  })
  

  # plot -- pca -------------------------------------------------------------
  
  
  output$ggplotly <- 
    
    renderPlotly({
      
      # --------------------------------------------------------------------------------------------------------
      
      u_sel_pcx  =  req(input$pcx_ID)
      u_sel_pcy = req(input$pcy_ID)
      u_sel_pcz = req(input$pcz_ID)
      
      
      
      m <- list(
        l = 1,
        r = 1,
        b = 50,
        t = 50,
        pad = 1
      )
      plot_ly(data = x,  x = ~  get(u_sel_pcx), y= ~ get(u_sel_pcy), z = ~  get(u_sel_pcz), 
              width = 1200, height = 1200,
              color = ~ get(input$metaclusterID),
              #colors = color2,
              text = x$sample,
              marker = list(size = 8,
                            line = list(color = ~  ~ get(input$metaclusterID) , width = 1)),
              hovertemplate = paste("<b>%{text}<b><br> PCx: %{x}<br> PCy: %{y}<br> PCz: %{z}")) %>%
        add_markers() %>%
        layout(autosize = F, margin =m, title = "3D Principal Components Analysis",
               scene = list(xaxis = list(title = input$pcx_ID),
                            yaxis = list(title = input$pcy_ID),
                            zaxis = list(title = input$pcz_ID)
               ), margin = m
        ) %>% layout(legend = list(orientation = 'v', xanchor = "left"))
      
      
      
      
      
      
    })
  

  
  

  
  
})

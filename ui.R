library(shiny)
library(dplyr)
library(DT)
library(shinythemes)
library(shinybusy)
library(shinycssloaders)
library(plotly)
library(DESeq2)
library(tibble)

options(shiny.maxRequestSize = 10000*1024^2)

fluidPage(theme = shinytheme("yeti"),
          pageWithSidebar(
            
            headerPanel('STS-pcaExploreR'),
            sidebarPanel(
              shinycssloaders::withSpinner(uiOutput("metaID"), type = 1),
              
              hr(),
              
              uiOutput("pcx"),
              uiOutput("pcy"),
              uiOutput("pcz"),
              
              hr(),

              
              width = 2,
              
            ),
            
            
            
            mainPanel(
              shinycssloaders::withSpinner(plotlyOutput("ggplotly"), type = 8),
              width = 9, height = 300)
            
          ),
          
          shinyjs::useShinyjs(),
          div(class = "footer",
              includeHTML("footer.html")
          )
          
)

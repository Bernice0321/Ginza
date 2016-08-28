library(shiny)

source("chooser.R")

shinyUI(
  fluidPage(
    headerPanel("Inclusion/Exclusion Criteria Selection Tool for Clinical Trial"),
  
    sidebarPanel(
      h3("Insert Subject Cohort Table"),
      fileInput(
        'fileInputControl', 
        ' ', 
        accept=c('text/csv','text/comma-separated-values,text/plain','.csv')
      ),
  
      # chooserInput("chooser", "Available frobs", "Selected frobs", 
      #              row.names(chooser), c(), size = 10, multiple = TRUE
      # ),
  
      uiOutput("testChooser"),
      verbatimTextOutput("selection"),
      verbatimTextOutput("result")
    )
  )
)
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
  
      uiOutput("testChooser"),
      actionButton("calculate", "Calculate Patient Count")
    ),
  
    mainPanel(
      h4("Index(es) of applied criteria"),
      verbatimTextOutput("selection"),
      h4("Initial patient count"),
      verbatimTextOutput("totalPatientCount"),
      h4("Total patient count after applied criteria"),
      verbatimTextOutput("filteredPatientCount"),
      h4("Total patient count filtered out"),
      verbatimTextOutput("patientCountDiff"),
      h4("Percentage"),
      plotOutput("percentagePlot")
    )
  )
)
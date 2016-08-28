library(shiny)
source("chooser.R")
source("calculation.R")


shinyServer(
  function(input, output) {
    filedata <- reactive({
      inFile <- input$fileInputControl
      if (is.null(inFile)) {
        return(NULL)
      }
      read.csv(file=inFile$datapath, header=TRUE)
    })
    

    output$testChooser <- renderUI(
      if(is.null(filedata()))
        h5("no file loaded")
      else {
        chooserInput(
          "mychooser", "Available frobs","Selected frobs",names(filedata()),c(),size = 20,multiple = TRUE)
      })
    
    
    output$selection <- renderText(
      # Following line shows the original vector size of input data column
      # paste('length: ', length(names(filedata())))
      
      paste(
        match(input$mychooser$right, names(filedata())), 
        collapse = ', '
      )
    )
    
    output$result <- renderText(
      paste(
        calculatePatientCount(
          patientDataTable = filedata(), 
          vectorIndexToApply = match(input$mychooser$right, names(filedata()))
        ), 
        ''
      )
    )
  }
)
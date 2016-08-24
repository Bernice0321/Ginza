library(shiny)

source("chooser.R")

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
    
    
     output$selection <- renderPrint(
       input$mychooser
     )
    # 
    # output$fileUpload <- renderTable({
    #   inFile <- input$fileInputControl
    #   
    #   if (is.null(inFile))
    #     return(NULL)
    #   
    #   read.csv(inFile$datapath, header=TRUE)
    # })
    
  }
)
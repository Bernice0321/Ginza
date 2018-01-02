library(shiny)
library(ggplot2)

source("chooser.R")
source("calculation.R")


createPercentageTable <- function(totalCount, partialCount) {
  group<-c('Patient lost','Patient left')
  count <- c((totalCount-partialCount), partialCount)
  
  patientDataTable <- data.frame(group,count)
  
  return(patientDataTable)
}

shinyServer(
  function(input, output) {
    
    filedata <- reactive({
      inFile <- input$fileInputControl
      if (is.null(inFile)) {
        return(NULL)
      }
      read.csv(file=inFile$datapath, header=TRUE)
    })
    
    loadChooser <- eventReactive(input$fileInputControl, {
      if(is.null(filedata()))
        h5("no file loaded")
      else {
        chooserInput(
          "mychooser", "Available frobs","Selected frobs",names(filedata()),c(),size = length(names(filedata())),multiple = TRUE)
      }
    })

    output$testChooser <- renderUI({loadChooser()})
    
    CalculateIndex <- eventReactive(input$calculate, {
        paste(
          match(input$mychooser$right, names(filedata())), 
          collapse = ', '
        )
    })
    
    CalculateInitialPatientCount <- eventReactive(input$calculate, {
      paste(
        nrow(filedata()), 
        ''
      )
    })
    
    CalculateFilteredPatientCount <- eventReactive(input$calculate, {
        paste(
          calculatePatientCount(
            patientDataTable = filedata(), 
            vectorIndexToApply = match(input$mychooser$right, names(filedata()))
          ), 
          ''
        )
    })
    
    CalculatePatientDiff <- eventReactive(input$calculate, {
      paste(
        (nrow(filedata()) - calculatePatientCount(
          patientDataTable = filedata(), 
          vectorIndexToApply = match(input$mychooser$right, names(filedata()))
        )), 
        ''
      )
    })
    
    
    CreatePlot <- eventReactive(input$calculate, {
      df <- createPercentageTable(
        nrow(filedata()), 
        calculatePatientCount(
          patientDataTable = filedata(), 
          vectorIndexToApply = match(input$mychooser$right, names(filedata()))
        )
      )
      
      barplot(df$count,col=c("#727272","#f1595f"), legend = df$group, yaxp=c(0, max(df$count), 5))
      # barplot(df, main="Patient Lost and Left",col=c("#727272","#f1595f"), legend = rownames(df),width=1)
    })

    output$selection <- renderText({CalculateIndex()})
    output$totalPatientCount <- renderText({CalculateInitialPatientCount()})
    output$filteredPatientCount <- renderText({CalculateFilteredPatientCount()})
    output$patientCountDiff <- renderText({CalculatePatientDiff()})
    output$percentagePlot <- renderPlot({CreatePlot()})
  }
  
)
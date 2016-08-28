calculatePatientCount <- function(patientDataTable, vectorIndexToApply) {
  
  ## TEST DATA START
  patientDataTable <- read.csv(file="Cohort.csv", header=TRUE, sep=",")
  vectorIndexToApply <- c(1, 2)
  ## TEST DATA END
  
  if (!is.null(patientDataTable) 
      && !is.null(vectorIndexToApply) 
      && length(vectorIndexToApply) != 0 
      && nrow(patientDataTable) != 0) {

    for (i in 1:length(patientDataTable)) {
      if (substr(names(patientDataTable)[i], 1, 2) == 'Ex') {
        patientDataTable[,i] <- abs(patientDataTable[,i] - 1)
      }
    }
    
    appliedPatientDataTable<-as.data.frame(patientDataTable[,vectorIndexToApply])
    
    filteredDataTable <- as.data.frame(appliedPatientDataTable[apply(appliedPatientDataTable, MARGIN = 1, function(x) all(x==1)), ])
    
    return(nrow(filteredDataTable))
    
  } else {ed
    return(0)
  }
}

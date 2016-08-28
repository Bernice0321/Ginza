calculatePatientCount <- function(patientDataTable, vectorIndexToApply) {
  
  ## TEST DATA START
  # patientDataTable <- read.csv(file="Cohort.csv", header=TRUE, sep=",")
  # vectorIndexToApply <- c(1,3)
  ## TEST DATA END
  
  if (!is.null(patientDataTable) && !is.null(vectorIndexToApply)) {
    cohort <- patientDataTable
    sel <-vectorIndexToApply
    
    cohortsel<-cohort[,sel]
    for (i in 1:length(sel)) {
      if (substr(names(cohortsel)[i],1,2)=='Ex') {cohortsel[,i]<-!cohortsel[,i]}
    }
    cols <- sapply(cohortsel, is.logical)
    cohortsel[,cols] <- lapply(cohortsel[,cols], as.numeric)
    
    filteredDataTable <- cohortsel[apply(cohortsel, MARGIN = 1, function(x) all(x==1)), ]
    
    return(nrow(filteredDataTable))
  } else {
    return(0)
  }
}

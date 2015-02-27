best <- function(state, outcome) {
    ## Read outcome data
    
    oocm <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    
    validoutcomes <- c("Heart Attack", "Heart Failure", "Pneumonia")
    indexes <- c(15, 21, 27 )
    
    if (sum(state.abb == state, na.rm=TRUE) == 0) stop("invalid state")
    if (sum(validoutcomes == outcome, na.rm=TRUE) == 0) stop("invalid outcome")
    
    
    
    outhead <- paste("Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.", gsub(" ", ".",outcome), sep="")
    #outhead <- ""Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia""
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    
    #result <- subset(oocm, State == state)["Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"]
    #result <- subset(oocm, State == state)[outhead]
    result <- subset(oocm, State == state, select = c("Hospital.Name", outhead))
    result
}


###### Next thing to do is to use column index instead of Name
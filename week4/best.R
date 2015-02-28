best <- function(state, outcome) {
    ## Read outcome data
    
    oocm <- read.csv("outcome-of-care-measures.csv", colClasses = "character", na.strings = "Not Available")
    
    ## Check that state and outcome are valid
    
    validoutcomes <- c("Heart Attack", "Heart Failure", "Pneumonia")
    indexes <- c(15, 21, 27 )
    
    if (sum(state.abb == state, na.rm=TRUE) == 0) stop("invalid state")
    if (sum(validoutcomes == outcome, na.rm=TRUE) == 0) stop("invalid outcome")
    
    names(indexes) <- validoutcomes
    outcomeindex <- as.integer(indexes[outcome])
    outhead <- paste("Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.", gsub(" ", ".",outcome), sep="")
    

    result <- subset(oocm, State == state)[,c(2,outcomeindex)]
    result <- result[complete.cases(result),]   # Remove incomplete rows
    result[,2] <- as.numeric(result[,2])
    best <- subset(result, get(outhead) == min(result[,2]))
    best
    sort(best)

}


 
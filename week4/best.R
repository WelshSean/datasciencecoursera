best <- function(state, outcome) {
    ## Read outcome data
    
    oocm <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    
    validoutcomes <- c("heart attack", "heart failure", "pneumonia")
    
    if (sum(state.abb == state, na.rm=TRUE) == 0) stop("invalid state")
    if (sum(validoutcomes == outcome, na.rm=TRUE) == 0) stop("invalid outcome")
    
    ## Return hospital name in that state with lowest 30-day death
    ## rate
}
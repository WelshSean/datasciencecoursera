best <- function(state, outcome) {
    ## Read outcome data
    
    oocm <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    
    if (sum(oocm["State"] == state, na.rm=TRUE) == 0) stop("invalid state")
    ## Return hospital name in that state with lowest 30-day death
    ## rate
}
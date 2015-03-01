best <- function(state, outcome) {
    setwd("/home/sean/DataScience/datasciencecoursera/week4")
    oocm <- read.csv("outcome-of-care-measures.csv", colClasses = "character", na.strings = "Not Available")
    
    ## Check that state and outcome are valid
    
    validoutcomes <- c("heart attack", "heart failure", "pneumonia")
    indexes <- c(15, 21, 27 )
    
    if (sum(state.abb == state, na.rm=TRUE) == 0) stop("invalid state")
    if (sum(validoutcomes == outcome, na.rm=TRUE) == 0) stop("invalid outcome")
    
    ## Summarise Data - this could be done in a way that is more general, but deadlines got me :-)
    
    
    if (outcome == "heart attack"){
        data <-subset(oocm, State == state)[,c(2,11)]
    } else if (outcome == "heart failure"){
        data <-subset(oocm, State == state)[,c(2,17)]
    } else if (outcome == "pneumonia") {
        data <-subset(oocm, State == state)[,c(2,23)]
    }
    
    ### Rename columns
    
    names(data) <- c("Hospital", "Freq")
    
    ### Make column 2 numeric
    
    data[,2] <- as.numeric(data[,2])
    
    ### Remove rows where Freq is NA
    
    data <- data[complete.cases(data),]   # Remove incomplete rows
    
    #### Now pick out rows where Freq == min(freq)
    
    best <- subset(data, Freq == min(data["Freq"]))
    
    ### Handle cases where there are more than 1 occurrences
    
    best <- sort(best[,"Hospital"])[1]
    
    best
    
}
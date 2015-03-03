rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    setwd("/home/sean/DataScience/datasciencecoursera/week4")
    oocm <- read.csv("outcome-of-care-measures.csv", colClasses = "character", na.strings = "Not Available")
     
    ## Check that state and outcome are valid
    
    validoutcomes <- c("heart attack", "heart failure", "pneumonia")
    
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
    datalength <- nrow(data)  ## Description suggests this should be done before NAs are removed but that doesnt make sense
    
    ## process num argument
    if (num == "best"){
        num <- 1
    } else if (num == "worst"){
        num <- datalength   
    } else if (num > datalength){
        return(NA)
    }   
    
    ## Order the data by Freq, use hospital names as second thing to order on to break ties
    
    data <- data[order(data[,2], data[,1]),]
    
    ## Return row number num and column 1 (Hospital name)
    
    data[num,1]

}
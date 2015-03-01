rankall <- function(outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    outputdf <- data.frame(hospital=character(),state=character(), stringsAsFactors=FALSE)
    setwd("/home/sean/DataScience/datasciencecoursera/week4")
    oocm <- read.csv("outcome-of-care-measures.csv", colClasses = "character", na.strings = "Not Available", stringsAsFactors=FALSE)
    
    ## Check that state and outcome are valid
    
    validoutcomes <- c("heart attack", "heart failure", "pneumonia")
    
    if (sum(validoutcomes == outcome, na.rm=TRUE) == 0) stop("invalid outcome")
    
    ## Summarise Data - this could be done in a way that is more general, but deadlines got me :-)
    
    if (outcome == "heart attack"){
        data <- oocm[,c(2,7,11)]
    } else if (outcome == "heart failure"){
        data <- oocm[,c(2,7,17)]
    } else if (outcome == "pneumonia") {
        data <- oocm[,c(2,7,23)]
    }
    
    ### Rename columns
    
    names(data) <- c("Hospital", "State", "Freq")
    
    data[,3] <- as.numeric(data[,3])
    
    ### Remove rows where Freq is NA
    
    data <- data[complete.cases(data),]   # Remove incomplete rows
    
    ## Order the data by Freq, use hospital names as second thing to order on to break ties
    
    data <- data[order(data[,3], data[,1]),]
    
    ## Split data by State
    
    datalist <- split(data, data$State)
    
    # Now loop over and process
    
    for(i in names(datalist))
    #for(i in c("TX", "MN"))
    {
        datalistlength <- nrow(datalist[[i]]) 
        print(datalistlength)
        ## process num argument
        if (num == "best"){
            num <- 1
        } else if (num == "worst"){
            num <- datalistlength   
        } ### Not dealing with num > datalistlen unless needed
        #print(datalist[[i]][num,])
        #outputdf <- rbind(outputdf, c(datalist[[i]][num,1], i))
        outputdf[nrow(outputdf) + 1,] <- c(datalist[[i]][num,1], i)
        
    }
    outputdf
}
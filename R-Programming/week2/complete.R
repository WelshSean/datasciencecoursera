## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'id' is an integer vector indicating the monitor ID numbers
## to be used

## Return a data frame of the form:
## id nobs
## 1  117
## 2  1041
## ...
## where 'id' is the monitor ID number and 'nobs' is the
## number of complete cases

complete <- function(directory, id = 1:332) {
    workdir <- getwd()
    output <- data.frame(id=numeric(0), nobs=numeric(0))
    setwd(directory)
    fileList <- list.files()
    for (index in id){
        #print (c(index, fileList[index]))
        csv <- read.csv(fileList[index])
        ## complete.cases returns a vector of TRUE or FALSE for each case depending on if its comeplete
        ## Summing TRUE/FALSE ends up adding 0 or 1 - can be NA so remmoving NA.
        numberComplete <- sum(complete.cases(csv),na.rm=TRUE)
        output <- rbind(output,data.frame(index,numberComplete ))
      

    }
    names(output) <- c("id", "nobs")             ##### No idea why I have to name this again - someting to 
    setwd(workdir)                               ##### do with the fecking rbind.
    #print(output)
    output
}


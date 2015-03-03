corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations

    # First find valid cases
    resultvector <- numeric()
    #counts <- complete("specdata", c(1:5))
    counts <- complete("specdata")
    workdir <- getwd()
    setwd("specdata")
    fileList <- list.files()
    
    # Then find locations witj >threshold valid cases
    
    valid <- subset(counts, nobs >=threshold)
    
    # map back to filenames - unlist used to convert 1d list to vector
    
    #print (fileList[unlist(valid["id"])])
    fnames <- fileList[unlist(valid["id"])]
    
    for(file in fnames){
        #'print(file)
        #csv <- read.csv(file, skip=1)
        csv <- read.csv(file)
        crltd <- cor(csv["sulfate"],csv["nitrate"], use="pairwise.complete.obs") #use= determines how to deal with NA
        #print(crltd)
        resultvector <- append(resultvector, crltd[1])
        #print(resultvector)

    }
    #print("SEAN")
    #print(resultvector)   
        
    setwd(workdir)
    resultvector
}
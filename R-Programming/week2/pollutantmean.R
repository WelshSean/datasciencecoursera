# Write a function named 'pollutantmean' that calculates the mean of a pollutant 
# (sulfate or nitrate) across a specified list of monitors. The function 
# 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. 
# Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate 
# matter data from the directory specified in the 'directory' argument and returns 
# the mean of the pollutant across all of the monitors, ignoring any missing values 
# coded as NA. A prototype of the function is as follows

pollutantmean <- function(directory, pollutant, id = 1:332) {
    workingdir <- getwd()
    setwd(directory)
    allFiles <- list.files()[id]
    allData <- lapply(allFiles, read.csv, header=TRUE)
    setwd(workingdir)
    combined <- do.call(rbind , allData)
    mean(combined[,pollutant], na.rm = TRUE)


}

#pollutantmean("/home/sean/DataScience/datasciencecoursera/week2/specdata","sulfate", id=1:2)

### examples
#pollutantmean("/home/sean/DataScience/datasciencecoursera/week2/specdata", "sulfate", 1:10)
## [1] 4.064
#pollutantmean("specdata", "nitrate", 70:72)
## [1] 1.706
#pollutantmean("specdata", "nitrate", 23)
## [1] 1.281

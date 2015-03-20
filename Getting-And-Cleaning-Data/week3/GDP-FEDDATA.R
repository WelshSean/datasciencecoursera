GDP <- read.csv("getdata%2Fdata%2FGDP.csv", stringsAsFactors = FALSE, skip = 3)
FEDSTATS <- read.csv("getdata%2Fdata%2FEDSTATS_Country.csv", stringsAsFactors = FALSE)
GDP <- GDP[GDP$Ranking %in% a,]   #### pick out countries ranked 1-190 as per the question
GDP <- select(GDP,X,Ranking,Economy,US.dollars.)
mergedData <- merge(GDP, FEDSTATS, by.x="X", by.y="CountryCode", All=FALSE)
#mergedData <- mergedData[order(mergedData$Ranking, decreasing = TRUE),]
mergedData <- mutate(mergedData, numRanking = as.integer(Ranking)) 
%mergedData <-    arrange(desc(numRanking))

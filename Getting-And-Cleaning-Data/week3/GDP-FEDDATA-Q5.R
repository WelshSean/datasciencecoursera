GDP <- read.csv("getdata%2Fdata%2FGDP.csv", stringsAsFactors = FALSE, skip = 3)
FEDSTATS <- read.csv("getdata%2Fdata%2FEDSTATS_Country.csv", stringsAsFactors = FALSE)
GDP <- GDP[GDP$Ranking %in% c(1:190),]   #### pick out countries ranked 1-190 as per the question
GDP <- select(GDP,X,Ranking,Economy,US.dollars.)
mergedData <- merge(GDP, FEDSTATS, by.x="X", by.y="CountryCode", All=FALSE)
means <- mutate(mergedData, numRanking = as.integer(Ranking)
 
quantile(mergedData$numRanking,probs=c(0, 0.2, 0.4, 0.6, 0.8, 1),type=1)
#                0%  20%  40%  60%  80% 100% 
#                    1   38   76  114  153  190 

cut(mergedData$numRanking, quantile(mergedData$numRanking,probs=c(0, 0.2, 0.4, 0.6, 0.8, 1),type=1))

table(mergedData$numRankingGroups, mergedData$Income.Group)

#High income: nonOECD High income: OECD Low income Lower middle income
#(1,38]                       4                17          0                   5
#(38,76]                      5                10          1                  13
#(76,114]                     8                 1          9                  12
#(114,153]                    5                 1         16                   8
#(153,190]                    1                 0         11                  16
#
#Upper middle income
#(1,38]                     11
#(38,76]                     9
#(76,114]                    8
#(114,153]                   8
#(153,190]                   9
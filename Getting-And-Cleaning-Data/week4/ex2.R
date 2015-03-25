GDP <- read.csv("GDP.csv", stringsAsFactors = FALSE, skip=3)
GDP <- GDP[GDP$Ranking %in% c(1:190),]   #### pick out countries ranked 1-190 
GDPCOL <- GDP[,"US.dollars."]
GDPCOL <- gsub(",","",GDPCOL)
mean(as.integer(GDPCOL))

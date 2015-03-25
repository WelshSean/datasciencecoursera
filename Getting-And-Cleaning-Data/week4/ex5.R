library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
val2012 <- grep ("2012-[0-9][0-9]-[0-9][0-9]", as.character(sampleTimes))
valMon2012 <- grep ("Monday-2012", format(sampleTimes, "%A-%Y"))
c(length(val2012), length(valMon2012))


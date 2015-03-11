#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
download.file("d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv","ACSz.csv",method="curl")
acs <- read.csv("ACSz.csv")
library(sqldf)
sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select distinct AGEP from acs")
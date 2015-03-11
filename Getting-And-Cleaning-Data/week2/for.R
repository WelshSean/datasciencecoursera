download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for","for.for",method="curl")
#file <- read.fortran("for.for")
#file <- read.fwf("for.for", skip=3, widths=c(15,13,13,13,9))
file <- read.fwf("for.for", skip=4, widths=c(10,-5, 4, 4, -5, 4, 4, -5, 4, 4, -5, 4, 4))
sum(file[,4])
#[1] 32426.7
# Compare emissions from motor vehicle sources in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County, California (fips == 06037). Which city 
# has seen greater changes over time in motor vehicle emissions?

setwd("/home/sean/DataScience/datasciencecoursera/Exploratory-Data-Analysis/project2")

library("dplyr")
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Pull out motor vehicle sources for Los Angeles and Baltimore
NEI <- subset(NEI, fips %in% c("24510", "06037") & type=="ON-ROAD")

# Summarise totals by location and year
NEI <- group_by(NEI, fips, year) %>%
          summarise(total=sum(Emissions)) 

# Calculate an extra column with the diff between each observation and its predecessor
NEI$diff <- ave(NEI$total, NEI$fips, FUN = function(x) c(NA, diff(x)))

# Make fips values and column names more friendly

NEI$fips[NEI$fips=="24510"] <- "Baltimore"
NEI$fips[NEI$fips=="06037"] <- "Los Angeles"
colnames(NEI)[1] <- "Location"
colnames(NEI)[4] <- "AnnualChange"

# Evaluate the sum of the absolute value of changes

totalchangeLA = round(sum(abs(subset(NEI, Location=="Los Angeles")$AnnualChange), na.rm=TRUE),2)
totalchangeBa = round(sum(abs(subset(NEI, Location=="Baltimore")$AnnualChange), na.rm=TRUE),2)

 
png('plot6.png', width=800,height=300,units="px",bg = "transparent")

ggplot(data=NEI, aes(x=year, y= AnnualChange, color=Location)) + geom_point() +
        facet_grid(. ~ Location ) + labs( y= expression(Delta * "Total " * PM[2.5] * " ( Tons )"),
         title="Delta between each observation and its predecessor for Baltimore and Los Angeles
         
         \nSum of absolute value of changes for Baltimore = 258.54
         Sum of absolute value of changes for Los Angeles = 1170.39")  
 
dev.off()

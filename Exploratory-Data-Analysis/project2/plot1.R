# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

setwd("/home/sean/DataScience/datasciencecoursera/Exploratory-Data-Analysis/project2")

library("dplyr")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#df <- merge(NEI, SCC, by="SCC")

summary <- group_by(NEI, year) %>%
    summarise(total = sum(Emissions))

png('plot1.png', width=300,height=300,units="px",bg = "transparent")
plot(summary, ylab="Total PM2.5 Emissions (tons)")
abline(lm(summary$total ~ summary$year))
dev.off()

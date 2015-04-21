#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == 24510) 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

setwd("/home/sean/DataScience/datasciencecoursera/Exploratory-Data-Analysis/project2")

library("dplyr")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- subset(NEI, fips==24510)


summary <- group_by(NEI, year) %>%
    summarise(total = sum(Emissions))

png('plot2.png', width=300,height=300,units="px",bg = "transparent")
plot(summary, ylab="Total PM2.5 Emissions In Baltimore (tons)")
abline(lm(summary$total ~ summary$year))
dev.off()

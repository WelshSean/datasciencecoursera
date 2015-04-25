#Across the United States, how have emissions from coal combustion-related sources changed 
# from 1999–2008?

setwd("/home/sean/DataScience/datasciencecoursera/Exploratory-Data-Analysis/project2")

library("dplyr")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



summary <- group_by(NEI, year, SCC) %>%
    summarise(total = sum(Emissions))


lines <- grep("Fuel Comb.*Coal", SCC$EI.Sector, ignore.case = FALSE)   ## Get all Coal Combustion related rows
indices <- SCC[lines, ]
indices <- indices["SCC"]             ## Pull out SCC values

summary <- inner_join(indices, summary) %>% #### SCC is a common field - will filter by list of SCC values
            group_by(year) %>%
             summarise(total=sum(total))



png('plot4.png', width=500,height=300,units="px",bg = "transparent")

plot(summary, ylab="Total PM2.5 Emissions (tons)", main="Total PM2.5 Emissions From Coal Combustion Based Sources")

dev.off()

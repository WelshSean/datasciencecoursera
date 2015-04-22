#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == 24510) 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

setwd("/home/sean/DataScience/datasciencecoursera/Exploratory-Data-Analysis/project2")

library("dplyr")
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#NEI <- subset(NEI, fips==24510)


summary <- group_by(NEI, year, SCC) %>%
    summarise(total = sum(Emissions))


lines <- grep("Fuel Comb.*Coal", SCC$EI.Sector, ignore.case = FALSE)   ## Get all Coal Combustion related rows
indices <- SCC[lines, ]
indices <- indices["SCC"]             ## Pull out SCC values

summary <- inner_join(indices, summary) %>% #### SCC is a common field - will filter by list of SCC values
            group_by(year) %>%
             summarise(total=sum(total))



#png('plot3.png', width=450,height=300,units="px",bg = "transparent")

#ggplot(data=summary, aes(x=year, y=total)) +
#    geom_point() + geom_smooth(method =	"lm") + facet_grid(. ~ type, scales="free_y") +
#    labs(title = expression( "Total " * PM[2.5] * " Level for Baltimore Resolved by Source Type"),y = expression("Total " * PM[2.5] * " ( Tons )")) + 
#    theme(axis.text.x=element_text(angle = -90, hjust = 0))

#dev.off()

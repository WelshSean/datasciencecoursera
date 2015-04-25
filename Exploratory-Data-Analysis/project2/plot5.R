#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

setwd("/home/sean/DataScience/datasciencecoursera/Exploratory-Data-Analysis/project2")

library("dplyr")
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCCSUM <- SCC[,c("SCC", "EI.Sector")]
NEI <- subset(NEI, fips==24510 & type=="ON-ROAD")

summary <- inner_join(SCCSUM, NEI) %>% #### SCC is a common field - will filter by list of SCC values
    group_by(year, EI.Sector) %>%
    summarise(total=sum(Emissions)) 
    
## Calculate totals for all vehicles in each year

totals <- group_by(summary, year) %>%
          summarise(total=sum(total)) %>%
           mutate(EI.Sector="Total")

## Join with vehicle resolved totals

summary <- rbind(summary, totals)

## Rename vehicle classes to help with plotting
summary$EI.Sector <- as.character(summary$EI.Sector)
summary$EI.Sector[summary$EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles"] <- "Diesel Heavy Duty Vehicles"
summary$EI.Sector[summary$EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles"] <- "Diesel Light Duty Vehicles"     
summary$EI.Sector[summary$EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles"] <- "Gasoline Heavy Duty Vehicles"
summary$EI.Sector[summary$EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles"] <- "Gasoline Light Duty Vehicles" 

png('plot5.png', width=800,height=300,units="px",bg = "transparent")

ggplot(data=summary, aes(x=year, y=total)) +
    geom_point() + geom_smooth(method =    "lm") + facet_grid(. ~ EI.Sector ) +
    labs(title = expression( "Total " * PM[2.5] * " Emissions from Motor Vehicles for Baltimore"),y = expression("Total " * PM[2.5] * " ( Tons )")) + 
    theme(axis.text.x=element_text(angle = -90, hjust = 0))

dev.off()

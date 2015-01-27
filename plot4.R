
library(plyr)
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC_short_names <- SCC[,c(1, 3)]

NEI_merged <- merge(NEI, SCC_short_names)

USA_coal <- filter(NEI_merged, grepl('Coal', Short.Name))

total_coal_emissions <- ddply(USA_coal, .(year), summarize, total_coal_emissions = sum(Emissions))

png(filename = "Plot 4.png", width = 480, height = 480)

qplot(year, total_coal_emissions, data = total_coal_emissions, geom = c("point", "smooth"), main = "Total PM2.5 emissions from coal sources in the US, 1999-2008")

dev.off()
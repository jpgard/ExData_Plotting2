library(plyr)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore_emissions <- filter(NEI, fips == "24510")

baltimore_yearly_sums <- ddply(baltimore_emissions, .(year), summarize, total_emissions=sum(Emissions))

png(filename = "Plot 2.png", width = 480, height = 480)

plot(baltimore_yearly_sums, type = "l", main="PM2.5 Emissions By Year in Baltimore")

dev.off()

library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

yearly_sums <- ddply(NEI, .(year), summarize, total_emissions=sum(Emissions))

##create plot 1 and save to png

png(filename = "Plot 1.png", width = 480, height = 480)

plot(yearly_sums, type = "l", main="Total PM2.5 Emissions By Year in the US, 1999-2008")

dev.off()


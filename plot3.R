
library(plyr)
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore_emissions <- filter(NEI, fips == "24510")

baltimore_yearly_sums_type <- ddply(baltimore_emissions, .(year, type), summarize, total_emissions=sum(Emissions))

png(filename = "Plot 3.png", width = 800, height = 480)

qplot(year, total_emissions, data = baltimore_yearly_sums_type, facets = . ~ type, geom = c("point", "smooth"), main = "Aggregate Annual PM2.5 Emissions In Baltimore City, By Type")

dev.off()

library(plyr)
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


##because all results of the filtering below are motor vehicle sources, I use this
##filtering method (i.e., it does NOT return any sources which are motors but not
##vehicles, etc).

SCC_short_names <- SCC[,c(1, 3)]

baltimore_emissions <- filter(NEI, fips == "24510")

baltimore_merged <- merge(baltimore_emissions, SCC_short_names)


baltimore_MV <- filter(baltimore_merged, grepl('Motor|Vehicle', Short.Name))

baltimore_MV_year <- ddply(baltimore_MV, .(year), summarize, total_motor_vehicle_emissions = sum(Emissions))

png(filename = "Plot 5.png", width = 850, height = 480)

qplot(year, total_motor_vehicle_emissions, data = baltimore_MV_year, geom = c("point", "smooth"), main = "Total PM2.5 emissions from motor vehicle sources in Baltimore City, 1999-2008")

dev.off()
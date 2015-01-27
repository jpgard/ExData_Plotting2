
library(plyr)
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


##because all results of the filtering below are motor vehicle sources, I use this
##filtering method (i.e., it does NOT return any sources which are motors but not
##vehicles, etc).

SCC_short_names <- SCC[,c(1, 3)]

##compute yearly motor vehicle emissions for baltimore city

baltimore_emissions <- filter(NEI, fips == "24510")

baltimore_merged <- merge(baltimore_emissions, SCC_short_names)

baltimore_MV <- filter(baltimore_merged, grepl('Motor|Vehicle', Short.Name))

baltimore_MV_year <- ddply(baltimore_MV, .(year), summarize, total_motor_vehicle_emissions = sum(Emissions))

baltimore_MV_year$Location <- "Baltimore City"

##compute yearly motor vehicle emissions for Los Angeles County

LA_emissions <- filter(NEI, fips == "06037")

LA_merged <- merge(LA_emissions, SCC_short_names)

LA_MV <- filter(LA_merged, grepl('Motor|Vehicle', Short.Name))

LA_MV_year <- ddply(LA_MV, .(year), summarize, total_motor_vehicle_emissions = sum(Emissions))

LA_MV_year$Location <- "Los Angeles County"


##merge datasets from two locations and generate plot

MV_merged <- rbind(LA_MV_year, baltimore_MV_year)

png(filename = "Plot 6.png", width = 850, height = 480)

qplot(year, total_motor_vehicle_emissions, data = MV_merged, facets = . ~ Location, geom = c("point", "smooth"), main="Total PM2.5 Motor Vehicle Emissions, Baltimore City and Los Angeles County 1999-2008")

dev.off()
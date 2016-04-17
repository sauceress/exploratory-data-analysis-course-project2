# Clean up workspace
#rm(list = ls())



# read data files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# verify data source

#str(NEI)
#str(SCC)

#head(NEI)
#head(SCC)

# Total emissions by year

eTotals <- aggregate(Emissions ~ year, NEI, sum)

# Make plot and save off png file

png(filename='plot1.png')

barplot((eTotals$Emissions)/10^6,
  names.arg=eTotals$year, xlab = "Year", ylab = "PM2.5 Emissions (10^6 Tons)",
  main = "Total PM2.5 Emissions: US Sources", col = "blue")

dev.off()


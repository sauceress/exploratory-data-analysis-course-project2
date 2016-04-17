
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- NEI[NEI$fips=="24510",]
aggBaltimore <- aggregate(Emissions ~ year, baltimore, sum)

png(filename = 'plot2.png')

barplot(
  aggBaltimore$Emissions,
  names.arg=aggBaltimore$year,
  xlab="Year",
  ylab="PM2.5 Emissions (in Tons)",
  main="Total PM2.5 Emissions: Baltimore, Maryland", col = "purple"
)

dev.off()


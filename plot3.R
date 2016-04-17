# Clean up workspace
#rm(list = ls())

# load libs

library(ggplot2)

# read data files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- NEI[NEI$fips=="24510",] ## copied from plot2.R

typeBaltimore <- aggregate(Emissions ~ year + type, baltimore, sum)


g <- ggplot(typeBaltimore, aes(year, Emissions, color = type))+ ## plot year/Emissions for typeBaltimore and color based on type
  ggtitle("PM2.5 Emission by Type: Baltimore City, MD (1999-2008)") ##Use this title for the plot


g + 
  geom_line(size=1.25,linetype = "solid")+ ## plot using a solid line
  geom_point(size = 3)+  ## add point for data samples (1999,2002,2005,2008)
  theme(axis.text=element_text(color="black",size=10))+ ## size 10pt and black for axis
  theme(axis.title.x=element_text(color="blue"), ## x title blue
        axis.title.y=element_text(color="blue"), ## y title blue
        plot.title=element_text(color="blue",size=12))+ ##set title blue and 12pt
  labs(x = "Year", y = "PM2.5 Emissions (in Tons)" )+ ## label x and y
  theme(legend.position = c(.9,.87)) ##put the legend inside the plot, upper right corner

ggsave(file = "plot3.png") ##save a copy of this plot and call it plot3.png

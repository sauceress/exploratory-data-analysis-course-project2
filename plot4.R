# Clean up workspace
#rm(list = ls())

# References: http://www.w3schools.com/colors/colors_picker.asp
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/grep.html


# load libs

library(ggplot2)

# read data files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coalSources  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)|
  grepl("coal", SCC$EI.Sector,ignore.case = TRUE)

coalSources <- SCC[coalSources, ]
coalSources <- NEI[NEI$SCC %in% coalSources$SCC, ]

aggcoalSources <- aggregate(Emissions ~ year, coalSources, sum)
aggcoalSources$year=as.factor(aggcoalSources$year)

g <- ggplot(aggcoalSources, aes(year, Emissions))+
  ggtitle("PM2.5 Emission: Coal Combustion Sources (tons)\n in the United States (1999-2008)")

g + 
  geom_bar(width=.5,stat="identity",colour="black",fill = "#003380")+

  theme_bw()+
  theme(axis.text=element_text(color="black",size=10))+ ## size 10pt and black for axis
  theme(axis.title.x=element_text(color="blue"), ## x title blue
        axis.title.y=element_text(color="blue"), ## y title blue
        plot.title=element_text(color="blue",size=12))+ ##set title blue and 12pt
  labs(x = "Year", y = "PM2.5 Emissions (in Tons)" )+ ## label x and y 


ggsave(file = "plot4.png")
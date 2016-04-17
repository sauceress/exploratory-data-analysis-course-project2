# Clean up workspace
#rm(list = ls())

# load libs

library(ggplot2)

# read data files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

bwiLAX <- NEI[NEI$type=="ON-ROAD" & (NEI$fips=="24510" | NEI$fips=="06037"), ]
bwiLAXagg <- aggregate(Emissions ~ year+fips, bwiLAX, sum)
bwiLAXagg$year=as.factor(bwiLAXagg$year)
bwiLAXagg$fips[bwiLAXagg$fips=="24510"]='Baltimore'
bwiLAXagg$fips[bwiLAXagg$fips=="06037"]='Los Angeles'

g <- ggplot(bwiLAXagg, aes(x=year,y=Emissions))+
  ggtitle("PM2.5 Motor Vehicle Emissions:\nBaltimore City, MD and Los Angeles, CA (1999 - 2008)") ##Use this title for the plot
  
g + 
  geom_bar(stat = "identity", width = 0.5, colour="black", fill="#003380") +
  facet_grid(.~fips) + 
  theme_bw()+
  theme(axis.text=element_text(color="black",size=10))+ ## size 10pt and black for axis
  theme(axis.title.x=element_text(color="blue"), ## x title blue
        axis.title.y=element_text(color="blue"), ## y title blue
        plot.title=element_text(color="blue",size=12))+ ##set title blue and 12pt
  labs(x = "Year", y = "PM2.5 Emissions (in Tons)" )+ ## label x and y +

ggsave(file = "plot6.png")

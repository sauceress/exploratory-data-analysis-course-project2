# Clean up workspace
#rm(list = ls())


  
  # https://www.epa.gov/air-emissions-inventories/national-emissions-inventory
  # NEI onroad sources include emissions from onroad vehicles that use gasoline, diesel, 
  # and other fuels. These sources include light duty and heavy duty vehicle emissions from operation 
  # on roads, highway ramps, and during idling.  Except for California, the US EPA uses the MOVES 
  # model to compute onroad source emissions based on model inputs provided by State, Local, and 
  # Tribal air agencies.  California provides emissions to the US EPA based on a California-specific 
  # model.  The MOVES model also computes refueling emissions, which are included in the EIS Nonpoint 
  # Data Category. 
  # All other onroad source emissions are included in the EIS Onroad Data Category.


# load libs

library(ggplot2)

# read data files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimoreOnroad <- NEI[NEI$type=="ON-ROAD" & NEI$fips=="24510", ]


baltimoreOnroadagg <- aggregate(Emissions ~ year, baltimoreOnroad, sum)
baltimoreOnroadagg$year=as.factor(baltimoreOnroadagg$year)

g <- ggplot(baltimoreOnroadagg, aes(x=year,y=Emissions))+
        ggtitle("Motor Vehicles Emissions: Baltimore City, MD (1999-2008)")
g <- g+geom_bar(width=.5,stat="identity",colour="black",fill="#003380")

g +
  theme_bw()+
  theme(axis.text=element_text(color="black",size=10))+
  theme(axis.title.x=element_text(color="blue"),
        axis.title.y=element_text(color="blue"),
        plot.title=element_text(color="blue",size=12))+
  labs(x = "Year", y = "PM2.5 Emissions (in Tons)" )+ ## label x and y

ggsave(file = "plot5.png")
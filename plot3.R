#Question 3:
#Of the four types of sources indicated by the type (point, nonpoint, 
#onroad, nonroad) variable, which of these four sources have seen 
#decreases in emissions from 1999 to 2008 for Baltimore City? Which 
#have seen increases in emissions from 1999 to 2008? Use the ggplot2 
#plotting system to make a plot answer this question.

#Read Data
SCC<-readRDS("Source_Classification_Code.rds")
NEI<-readRDS("summarySCC_PM25.rds")

#Pick up the data of Baltimore City by subsetting the data with fips==24510
BaltimoreData<-subset(NEI,NEI$fips=="24510")

#Aggregate emissions in Baltimore City by year and type
TotalEmissionsBalt<-aggregate(Emissions~year+type,data=BaltimoreData,FUN=sum,na.rm=T)

#Draw a ggplot
library(ggplot2)
png("plot3.png",height=480,width=480)
print(ggplot(TotalEmissionsBalt,
       aes(year,Emissions,fill=type))+
  geom_bar(stat="identity")+       
  facet_grid(.~type)+    
  xlab(expression("Year"))+
  ylab(expression("Total PM2.5 Emission (tons)"))+
  ggtitle(expression("PM2.5 Emission in Baltimore City by four types of sources"))+
  scale_x_continuous(breaks=c(1999,2002,2005,2008)))

dev.off()

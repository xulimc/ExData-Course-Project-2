#Question 6:
#Compare emissions from motor vehicle sources in Baltimore City 
#with emissions from motor vehicle sources in Los Angeles County, 
#California (fips == "06037"). Which city has seen greater changes
#over time in motor vehicle emissions?
 
#Read Data
SCC<-readRDS("Source_Classification_Code.rds")
NEI<-readRDS("summarySCC_PM25.rds")

#Pick up the data of Baltimore City by subsetting the data with fips==24510
BaltimoreData<-subset(NEI,NEI$fips=="24510")

#Find the data related to motor vehicle in Baltimore city
Motor<-SCC$SCC[SCC$Data.Category=="Onroad"]
MotorData<-BaltimoreData[BaltimoreData$SCC %in% Motor,]

#Aggregate emissions in Baltimore by years (1999,2002,2005,2008)
EmissionsBalt<-aggregate(Emissions~year,data=MotorData,FUN=sum,na.rm=T)
EmissionsBalt$Location<-"Balt"

#Pick up the data of Los Angeles County by subsetting the data with fips==24510
LAData<-subset(NEI,NEI$fips=="06037")

#Find the data related to motor vehicle in Los Angeles County
MotorData2<-LAData[LAData$SCC %in% Motor,]

#Aggregate emissions in Los Angeles County by years (1999,2002,2005,2008)
EmissionsLA<-aggregate(Emissions~year,data=MotorData2,FUN=sum,na.rm=T)
EmissionsLA$Location<-"LA"
CombinedData<-rbind(EmissionsBalt,EmissionsLA)

#Draw a barplot
library(ggplot2)
png("plot6.png",height=480,width=480)
print(ggplot(CombinedData,
       aes(year,Emissions,fill=Location))+
  geom_bar(stat="identity")+       
  facet_grid(.~Location,scales="free")+     
  xlab(expression("Year"))+
  ylab(expression("Total PM2.5 Emission (tons)"))+
  ggtitle(expression("PM2.5 Emission in Baltimore and LA related to Motor Vehicles"))+
  scale_x_continuous(breaks=c(1999,2002,2005,2008)))

dev.off()
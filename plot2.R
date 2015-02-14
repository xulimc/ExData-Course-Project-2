#Question 2:
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008? Use the base plotting system to 
#make a plot answering this question.

#Read Data
SCC<-readRDS("Source_Classification_Code.rds")
NEI<-readRDS("summarySCC_PM25.rds")

#Pick up the data of Baltimore City by subsetting the data with fips==24510
BaltimoreData<-subset(NEI,NEI$fips=="24510")

#Aggregate emissions in Baltimore City by years (1999,2002,2005,2008)
TotalEmissionsBalt<-aggregate(Emissions~year,data=BaltimoreData,FUN=sum,na.rm=T)

#Draw a Plot  
png("plot2.png",height=480,width=480)
barplot(TotalEmissionsBalt$Emission,TotalEmissionsBalt$year,
        names.arg=TotalEmissionsBalt$year,
        xlab="Year",ylab="Total PM2.5 Emission (tons) in Baltimore City")
dev.off()
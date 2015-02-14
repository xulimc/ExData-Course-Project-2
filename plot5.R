#Question 5:
#How have emissions from motor vehicle sources changed 
#from 1999 to 2008 in Baltimore City?

#Read Data
SCC<-readRDS("Source_Classification_Code.rds")
NEI<-readRDS("summarySCC_PM25.rds")

#Pick up the data of Baltimore City by subsetting the data with fips==24510
BaltimoreData<-subset(NEI,NEI$fips=="24510")

#Find the data related to motor vehicle in Baltimore city
Motor<-SCC$SCC[SCC$Data.Category=="Onroad"]
MotorData<-BaltimoreData[BaltimoreData$SCC %in% Motor,]

#Aggregate emissions by years (1999,2002,2005,2008)
TotalEmissionsMotor<-aggregate(Emissions~year,data=MotorData,FUN=sum,na.rm=T)

#Draw a barplot
png("plot5.png",height=480,width=480)
barplot(TotalEmissionsMotor$Emission,TotalEmissionsMotor$year,
        names.arg=TotalEmissionsMotor$year,
        xlab="Year",ylab="Total PM2.5 Emission (tons) related to Motor Vehicles")
dev.off()
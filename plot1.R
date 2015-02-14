#Question 1:
#Have total emissions from PM2.5 decreased in the United States from 1999 
#to 2008? Using the base plotting system, make a plot showing the total PM2.5 
#emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#Read Data
SCC<-readRDS("Source_Classification_Code.rds")
NEI<-readRDS("summarySCC_PM25.rds")

#Aggregate emissions by years (1999,2002,2005,2008)
TotalEmissions<-aggregate(Emissions~year,data=NEI,FUN=sum,na.rm=T)
 
#Draw a barplot
png("plot1.png",height=480,width=480)
barplot(TotalEmissions$Emission/10e6,TotalEmissions$year,
        names.arg=TotalEmissions$year,
        xlab="Year",ylab="Total PM2.5 Emission (10e6 tons)")
dev.off()
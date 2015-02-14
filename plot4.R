#Question 4:
#Across the United States, how have emissions from coal combustion-related
#sources changed from 1999 to 2008?
 
#Read Data
SCC<-readRDS("Source_Classification_Code.rds")
NEI<-readRDS("summarySCC_PM25.rds")

#Pick up the data related to coal combustion-related sources
Coal<-SCC$SCC[grepl("coal",SCC$Short.Name,ignore.case=T)]
CoalData<-NEI[NEI$SCC %in% Coal,]

#Aggregate emissions by years (1999,2002,2005,2008)
TotalEmissionsCoal<-aggregate(Emissions~year,data=CoalData,FUN=sum,na.rm=T)

#Draw a barplot
png("plot4.png",height=480,width=480)
barplot(TotalEmissionsCoal$Emission/10e4,TotalEmissionsCoal$year,
        names.arg=TotalEmissionsCoal$year,
        xlab="Year",ylab="Total PM2.5 Emission (10e4 tons) related to coal combustion")
dev.off()
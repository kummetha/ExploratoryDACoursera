NEI <- readRDS("summarySCC_PM25.rds")
#m <- with(NEI, tapply(Emissions, year, mean, na.rm = T)) #The mean values are clearly dropping from 1999 to 2008. Probably need to plot a histogra showing the means dropping for each year

#Get the sum of PM2.5 emissions for each year
SumOfEmissionsPerYear <- aggregate(Emissions~year, data=NEI, sum, na.rm=TRUE)
png(filename = "plot1.png")
barplot(SumOfEmissionsPerYear$Emissions,names.arg = SumOfEmissionsPerYear$year,xlab = "year",ylab = "PM2.5  Emissions", main = "Sum of PM2.5  Emissions per year")
dev.off()
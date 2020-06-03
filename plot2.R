NEI <- readRDS("summarySCC_PM25.rds")

#Get the data of interest for Baltimore for years 1999 and 2008
NEIforBaltimore <- subset(NEI, fips == "24510" & (year == 1999 | year == 2008))
#Get the sum of pm2.5 emissions for both the years
SumOfEmissionsPerYear <- aggregate(Emissions ~ year, data = NEIforBaltimore, sum)

#Plotting bar plots for years 1999 and 2008 as we need to check how emissions have changed between these 2 years
png(filename = "plot2.png")
barplot(SumOfEmissionsPerYear$Emissions,names.arg = SumOfEmissionsPerYear$year, xlab = "year", ylab = "PM.25  Emissions", main = "Sum of PM2.5 Emissions for the years 1999 and 2008 in Baltimore")
dev.off()
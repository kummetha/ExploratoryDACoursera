library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")

#Get the data of interest for Baltimore for years 1999 and 2008
NEIforBaltimore <- subset(NEI, fips == "24510" & (year == 1999 | year == 2008))

#Get the sum of pm2.5 emissions for both the years and by type
SumOfEmissionsPerYear <- aggregate(Emissions ~ year+type, data = NEIforBaltimore, sum)

#Plotting line graphs for years 1999 and 2008 as we need to check how emissions have changed between these 2 years
png(filename = "plot3.png", width = 580)
g <- ggplot(SumOfEmissionsPerYear, aes(year,Emissions,color = type)) + geom_line() + ggtitle('Sum of PM2.5 Emissions for the years 1999 and 2008 for different types')
print(g)
dev.off()
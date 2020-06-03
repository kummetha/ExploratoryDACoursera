library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Get the indices for the occurences of the word vehicle in "Level.Three" column in the dataset : SCC
vehicle_Indices <- grep("vehicle",SCC$SCC.Level.Three,ignore.case = TRUE)

#Get all the rows with the above common indices
VehicleSources <- SCC[vehicle_Indices,]

#Get NEI subset data for the years 1999 and 2008 for Baltimore
NEIforBaltimore <- subset(NEI, fips == "24510" & (year == 1999 | year == 2008))

#Merge NEI subset with the VehicleSources from SCC dataset by the column "SCC"
MergedNEIandSCC <- merge(NEIforBaltimore,VehicleSources,by = "SCC")

#Get the sum of pm2.5 emissions for both the years
SumOfMotorsVehicleEmissionsPerYear <- aggregate(Emissions ~ year, data = MergedNEIandSCC, sum)

#Plotting bar plots for years 1999 and 2008 as we need to check how emissions have changed between these 2 years
png(filename = "plot5.png", width = 580)
g <- ggplot(SumOfMotorsVehicleEmissionsPerYear, aes(factor(year), Emissions)) + geom_bar(stat = 'identity') + xlab('year') + ggtitle('Sum of PM2.5 Emissions for Motor Vehicle sources for years 1999 and 2008 in Baltimore')
print(g)
dev.off()
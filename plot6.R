library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Get the indices for the occurences of the word vehicle in "Level.Three" column in the dataset : SCC
vehicle_Indices <- grep("vehicle",SCC$SCC.Level.Three,ignore.case = TRUE)

#Get all the rows with the above common indices
VehicleSources <- SCC[vehicle_Indices,]

#Get NEI subset data for the years 1999 and 2008 for Baltimore and LA
NEIsubset <- subset(NEI, (fips == "24510" | fips == "06037")  & (year == 1999 | year == 2008))

#Merge NEI subset with the VehicleSources from SCC dataset by the column "SCC"
mergedCountyData <- merge(NEIsubset,VehicleSources,by = "SCC")

#Get the sum of pm2.5 emissions for both the years for both the counties
SumOfVehicleEmissionsPerYear <- aggregate(Emissions ~ year + fips, data = mergedCountyData, sum)

#Change the fips values to County names
SumOfVehicleEmissionsPerYear$fips[SumOfVehicleEmissionsPerYear$fips == "24510"] <- "Baltimore"
SumOfVehicleEmissionsPerYear$fips[SumOfVehicleEmissionsPerYear$fips == "06037"] <- "Los Angeles"

#Change the name of the column "fips" to "County"
names(SumOfVehicleEmissionsPerYear)[2] <- paste("County")

#Plotting line graphs for years 1999 and 2008 as we need to check how emissions have changed between these 2 years for Baltimore and Los Angeles
png(filename = "plot6.png", width = 680)
g <- ggplot(SumOfVehicleEmissionsPerYear,aes(year,Emissions,color = County)) + geom_line() + ggtitle('PM2.5 Emissions for the Motor vehicle sources for years 1999 and 2008 in Baltimore and Los Angeles')
print(g)
dev.off()
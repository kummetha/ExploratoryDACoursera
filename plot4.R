library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Get the indices for the occurences of the word coal in "SCC.Level.Three" column and the occurences of the
#word "comb" for "Combustion" in "SCC.Level.One" column in the dataset: SCC
coal_Indices <- grep("coal",SCC$SCC.Level.Three,ignore.case = TRUE)
combustion_Indices <- grep("comb",SCC$SCC.Level.One,ignore.case = TRUE)

#Get all the rows with the above common indices
CoalCombustionSources <- SCC[intersect(coal_Indices,combustion_Indices),]

#Get NEI subset data for the years 1999 and 2008 
NEIforUS <- subset(NEI,year == 1999 | year == 2008)

#Merge NEI subset with the CoalCombustionSources from SCC dataset by the column "SCC"
MergedNEIandSCC <- merge(NEIforUS,CoalCombustionSources,by = "SCC")

#Get the sum of pm2.5 emissions for both the years
SumOfCoalCombustionEmissionsPerYear <- aggregate(Emissions ~ year, data = MergedNEIandSCC, sum)

#Plotting bar plots for years 1999 and 2008 as we need to check how emissions have changed between these 2 years
png(filename = "plot4.png", width = 580)
g <- ggplot(SumOfEmissionsPerYear, aes(factor(year), Emissions)) + geom_bar(stat = 'identity') + xlab('year') + ggtitle('Sum of PM2.5 Emissions for the Coal Combustion related sources for years 1999 and 2008 ')
print(g)
dev.off()
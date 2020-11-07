# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Check that data files are in the working directory
files <- dir()
if(!file.exists("Source_Classification_Code.rds") | !file.exists("summarySCC_PM25.rds")) {
  stop("Please add correct data files to working directory.")
}
library(ggplot2)
# Read data files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
both <- merge(NEI, SCC, by="SCC")

# Find rows that deal with motor vehicle sources
mvsubsetTF <- grepl("vehicle", both$EI.Sector, ignore.case = TRUE)
mvsubset <- both[mvsubsetTF, ]
# subset Balitmore City, MD and Los Angeles County, California
plotdf <- subset(mvsubset, fips == "06037" | fips == "24510")
plotdf$fips <- sub("06037","LA County", plotdf$fips)
plotdf$fips <- sub("24510","Baltimore City", plotdf$fips)
#subset the dataframe with only the values needed to plot
plotdf <- aggregate(Emissions ~ fips + year, plotdf, sum)
png('plot6.png')
g <- ggplot(plotdf, aes(year, Emissions, color = fips))
g <- g + geom_line() + labs(x = "Year", y = "Emissions (tons)", color = "Location", 
                           title = "Total PM2.5 Emissions for Motor Vehicle Pollution")
print(g)
while (!is.null(dev.list()))  dev.off()
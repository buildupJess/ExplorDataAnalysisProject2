# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

# Check that data files are in the working directory
files <- dir()
if(!file.exists("Source_Classification_Code.rds") | !file.exists("summarySCC_PM25.rds")) {
  stop("Please add correct data files to working directory.")
}
# Read data files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

yeartotalsdf <- with(NEI, tapply(Emissions, year, sum, na.rm=TRUE))
png('plot1.png')
barplot(yeartotalsdf, col = "blue", xlab = "Year", ylab = "Total Emissions (tons)", 
        main = "Total US PM2.5 Emissions from 1999 to 2008")
while (!is.null(dev.list()))  dev.off()
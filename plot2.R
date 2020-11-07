# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# Check that data files are in the working directory
files <- dir()
if(!file.exists("Source_Classification_Code.rds") | !file.exists("summarySCC_PM25.rds")) {
  stop("Please add correct data files to working directory.")
}
# Read data files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

MDsubset <- subset(NEI, fips == "24510")
MDyeartotalsdf <- with(MDsubset, tapply(Emissions, year, sum, na.rm=TRUE))
png('plot2.png')
barplot(MDyeartotalsdf, col = "blue", xlab = "year", ylab = "total emissions (tons)", 
        main = "Baltimore City, MD's Total PM2.5 Emissions (1999-2008)")
while (!is.null(dev.list()))  dev.off()
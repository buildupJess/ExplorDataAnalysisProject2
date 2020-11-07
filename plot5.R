# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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

# only use Balitmore City, MD
MDsubset <- subset(both, fips == 24510)
# Find rows that deal with motor vehicle sources
MDmvsubsetTF <- grepl("vehicle", MDsubset$EI.Sector, ignore.case = TRUE)
MDmvsubset <- MDsubset[MDmvsubsetTF, ]
#subset the dataframe with only the values needed to plot
plotMDmvsubset <- aggregate(Emissions ~ year, MDmvsubset, sum)
png('plot5.png')
g <- ggplot(plotMDmvsubset, aes(factor(year), Emissions))
g <- g + geom_col() + labs(x = "Year", y = "Emissions (tons)", 
      title = "Balitmore City, MD Total PM2.5 Emissions for Motor Vehicle Pollution")
print(g)
while (!is.null(dev.list()))  dev.off()
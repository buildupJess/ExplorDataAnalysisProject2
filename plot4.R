# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

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

# Find rows that deal with coal pollution sources
coalsubsetTF <- grepl("coal", both$Short.Name, ignore.case = TRUE)
coalsubset <- both[coalsubsetTF, ]
#subset the dataframe with only the values needed to plot
plotcoalsubset <- aggregate(Emissions ~ year, coalsubset, sum)
png('plot4.png')
g <- ggplot(plotcoalsubset, aes(factor(year), Emissions))
g <- g + geom_col() + labs(x = "Year", y = "Emissions (tons)", 
       title = "US Total PM2.5 Emissions Coal Pollution")
print(g)
while (!is.null(dev.list()))  dev.off()
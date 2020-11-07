# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# Check that data files are in the working directory
files <- dir()
if(!file.exists("Source_Classification_Code.rds") | !file.exists("summarySCC_PM25.rds")) {
  stop("Please add correct data files to working directory.")
}
library(ggplot2)
# Read data files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

MDsubset <- subset(NEI, fips == "24510")
MDtypeyeartotalsdf <- aggregate(Emissions ~ type + year, MDsubset, sum)
png('plot3.png')
g <- ggplot(MDtypeyeartotalsdf, aes(year, Emissions, color = type))
g <- g+geom_line() + labs(y = "Emissions (tons)", 
        title = "Baltimore City, MD's Total PM2.5 Emissions (1999-2008) per Type")
print(g)
while (!is.null(dev.list()))  dev.off()
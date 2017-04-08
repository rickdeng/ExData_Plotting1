## plot1.R
## 8 April 2017
## This script is for constructing plot1.png

## 1 - Loading and unzip data
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadedFile <- paste(getwd(), "hpc_data.zip", sep = "/")
download.file(dataUrl, downloadedFile)
unzip(downloadedFile)

## 2 - load required library
if(!require("sqldf")) {
  install.packages("sqldf")
}
library(sqldf)

## 2 - read data
data_file <- file("./household_power_consumption.txt")
hpc_data <- sqldf("select * from data_file where Date == '1/2/2007' OR Date == '2/2/2007'",
                  file.format = list(header = TRUE, sep = ";"))
close(data_file)

## 3 - plotting plot1.png
par(mfcol = c(1,1))
hist(hpc_data$Global_active_power, 
     main="Gloval Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "red")
dev.copy(png, "./ExData_Plotting1/plot1.png", width = 480, height = 480)
dev.off()


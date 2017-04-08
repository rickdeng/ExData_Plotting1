## plot2.R
## 8 April 2017
## This script is for constructing plot2.png

## 1 - Loading and unzip data
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadedFile <- paste(getwd(), "hpc_data.zip", sep = "/")
download.file(dataUrl, downloadedFile)
unzip(downloadedFile)

## 2 - load required library - use sqldf to select specific rows before read data into R
if(!require("sqldf")) {
  install.packages("sqldf")
}
library(sqldf)

## 2 - read data
data_file <- file("./household_power_consumption.txt")
hpc_data <- sqldf("select * from data_file where Date == '1/2/2007' OR Date == '2/2/2007'",
                  file.format = list(header = TRUE, sep = ";"))
close(data_file)

## 3 - plotting plot2.png
## 3.1 - merge and format date and time and create new "Date_time" variable
date_time <- paste(hpc_data$Date, hpc_data$Time)
date_time <- strptime(date_time, "%d/%m/%Y %H:%M:%S")
hpc_data$Date_time <- as.POSIXct(date_time)

## 3.2 - plotting
par(mfcol = c(1,1))
x <- hpc_data$Date_time
y <- hpc_data$Global_active_power
plot(x, y, ylab = "Global Active Power (kilowatts)", xlab = "", type="l") 
dev.copy(png, "./ExData_Plotting1/plot2.png", width = 480, height = 480)
dev.off()
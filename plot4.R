## plot2.R
## 8 April 2017
## This script is for constructing plot4.png

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

## 3 - plotting plot4.png
## 3.1 - merge and format date and time and create new "Date_time" variable
date_time <- paste(hpc_data$Date, hpc_data$Time)
date_time <- strptime(date_time, "%d/%m/%Y %H:%M:%S")
hpc_data$Date_time <- as.POSIXct(date_time)

## 3.2 - plotting
par(mfcol = c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

## chart - top left
x <- hpc_data$Date_time
y <- hpc_data$Global_active_power
plot(x, y, ylab = "Global Active Power (kilowatts)", xlab = "", type="l") 

## chart - bottom left
y1 <- hpc_data$Sub_metering_1
y2 <- hpc_data$Sub_metering_2
y3 <- hpc_data$Sub_metering_3
plot(x, y1, ylab = "Energy sub meeting", xlab = "", type="l") 
lines(x, y2, col = "red") 
lines(x, y3, col = "blue") 
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", bg="transparent", cex=0.7, y.intersp = 0.3)

## chart - top right
plot(x, hpc_data$Voltage, ylab = "Voltage", xlab = "", type="l") 

## chart - bottom right
plot(x, hpc_data$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type="l") 

dev.copy(png, "./ExData_Plotting1/plot4.png", width = 480, height = 480)
dev.off()
## plot2.R
## 8 April 2017
## This script is for constructing plot3.png

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

## 3 - plotting plot3.png
## 3.1 - merge and format date and time and create new "Date_time" variable
date_time <- paste(hpc_data$Date, hpc_data$Time)
date_time <- strptime(date_time, "%d/%m/%Y %H:%M:%S")
hpc_data$Date_time <- as.POSIXct(date_time)

## 3.2 - plotting
par(mfcol = c(1,1))
x <- hpc_data$Date_time
y1 <- hpc_data$Sub_metering_1
y2 <- hpc_data$Sub_metering_2
y3 <- hpc_data$Sub_metering_3
plot(x, y1, ylab = "Energy sub meeting", xlab = "", type="l") 
lines(x, y2, col = "red") 
lines(x, y3, col = "blue") 
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", cex=0.8, bg="transparent", y.intersp = 0.5)
dev.copy(png, "./ExData_Plotting1/plot3.png", width = 480, height = 480)
dev.off()
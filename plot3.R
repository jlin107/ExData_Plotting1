library(dplyr)
library(lubridate)

#### Download data set. ----
if (!file.exists("household_power_consumption.zip")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile = "household_power_consumption.zip")
}
if (!file.exists("household_power_consumption.txt")) {
  unzip(zipfile = "household_power_consumption.zip", exdir = ".")
}

#### Read data set. ----
# Read from .txt file.
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   colClasses = "character")

# Convert to Date object.
data$Date <- dmy(data$Date)

# Select dates 2007-02-01 and 2007-02-02.
data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

#### Generate plot. ----
# Conver to Tiem object.
data$Time <- hms(data$Time)

# Convert to numeric object.
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Create plot.
png(filename = "plot3.png", width = 480, height = 480)
plot(data$Date + data$Time, data$Sub_metering_1, type = "n",
     xlab = "", ylab = "Energy sub meeting")
lines(data$Date + data$Time, data$Sub_metering_1, col = "black")
lines(data$Date + data$Time, data$Sub_metering_2, col = "red")
lines(data$Date + data$Time, data$Sub_metering_3, col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)
dev.off()
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
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Create plot.
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

# (1,1)
plot(data$Date + data$Time, data$Global_active_power, type = "n",
     xlab = "", ylab = "Global Active Power")
lines(data$Date + data$Time, data$Global_active_power)

# (1,2)
plot(data$Date + data$Time, data$Voltage, type = "n",
     xlab = "datetime", ylab = "Voltage")
lines(data$Date + data$Time, data$Voltage)

# (2,1)
plot(data$Date + data$Time, data$Sub_metering_1, type = "n",
     xlab = "", ylab = "Energy sub meeting")
lines(data$Date + data$Time, data$Sub_metering_1, col = "black")
lines(data$Date + data$Time, data$Sub_metering_2, col = "red")
lines(data$Date + data$Time, data$Sub_metering_3, col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

# (2,2)
plot(data$Date + data$Time, data$Global_reactive_power, type = "n",
     xlab = "datetime", ylab = "Global_reactive_power")
lines(data$Date + data$Time, data$Global_reactive_power)

dev.off()
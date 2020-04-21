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

# Create plot.
png(filename = "plot2.png", width = 480, height = 480)
plot(data$Date + data$Time, data$Global_active_power, type = "n",
     xlab = "", ylab = "Global Active Power (kilowatts)")
lines(data$Date + data$Time, data$Global_active_power)
dev.off()
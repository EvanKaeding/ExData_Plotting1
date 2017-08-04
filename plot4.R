# read in the data

pwr <- read.table("household_power_consumption.txt",
                  header = TRUE, sep = ";",
                  stringsAsFactors = FALSE, na.strings = "?")

# clean the data a little bit

library(dplyr)
library(lubridate)

data1 <- filter(pwr, Date == "1/2/2007")
data2 <- filter(pwr, Date == "2/2/2007")
set <- bind_rows(data1, data2)

set$Date <- dmy(set$Date)

set$date_time <- as.POSIXct(paste(set$Date, set$Time, sep = " "), 
                            format = "%Y-%m-%d %H:%M:%S")

# build the structure

par(mfrow = c(2,2), mar = c(2,4,2,2))

# build the first plot

plot(set$date_time, set$Global_active_power, type = "l", 
     ylab = "Global Active Power (Kilowatts)", xlab = " ")

# build the second plot

plot(set$date_time, set$Voltage, xlab = "date_time", 
     ylab = "Voltage", type = "l")

# build the third plot

plot(set$date_time, set$Sub_metering_1, type = "l", 
     xlab = " ", ylab = "Energy sub metering")

lines(set$date_time, set$Sub_metering_2, type = "l", col = "red")
lines(set$date_time, set$Sub_metering_3, type = "l", col = "blue")

legend("topright", names(set)[7:9], 
       col = c("black", "red", "blue"), lty = 1)

# build the fourth plot

plot(set$date_time, set$Global_reactive_power, type = "l", 
     xlab = "date_time", ylab = "Global Reactive Power")

dev.copy(png, file = "plot4.png")
dev.off()

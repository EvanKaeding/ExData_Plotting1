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

# build the plot

plot(set$date_time, set$Global_active_power, type = "l", 
     ylab = "Global Active Power (Kilowatts)", xlab = " ")

dev.copy(png, file = "plot2.png")
dev.off()

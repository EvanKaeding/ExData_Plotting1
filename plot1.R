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

# build the plot

hist(set$Global_active_power, xlab = "Global Active Power (Kilowatts)", 
     main = "Global Active Power", col = "red")

dev.copy(png, file = "plot1.png")
dev.off()



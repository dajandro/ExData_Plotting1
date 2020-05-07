library(dplyr)

# READ FILE
data <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = T)

# DATA PREPARATION
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- data %>% filter(Date >= as.Date("2007-02-01") &  Date <= as.Date("2007-02-02"))
data <- data %>% mutate(DateTime = as.POSIXct(paste0(Date, Time)), format = "%d/%m/%Y %H:%M:%S")

with(data,
     {
       plot(Global_active_power, type = "l", xaxt = "none", xlab = "", ylab = "Global Active Power (kilowatts)")
       axis(1, at = c(0,1500,2800), labels = c("Thu","Fri","Sat"))
       dev.copy(png, filename = "plot2.png")
       dev.off()
     }
)

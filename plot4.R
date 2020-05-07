library(dplyr)

# READ FILE
data <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = T)

# DATA PREPARATION
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- data %>% filter(Date >= as.Date("2007-02-01") &  Date <= as.Date("2007-02-02"))
data <- data %>% mutate(DateTime = as.POSIXct(paste0(Date, Time)), format = "%d/%m/%Y %H:%M:%S")

par(mfrow=c(2,2))

with(data,
     {
       plot(Global_active_power, type = "l", xaxt = "none", xlab = "", ylab = "Global Active Power")
       axis(1, at = c(0,1500,2800), labels = c("Thu","Fri","Sat"))
     }
)

with(data,
     {
       plot(Voltage, type = "l", xaxt = "none", xlab = "datetime", ylab = "Voltage")
       axis(1, at = c(0,1500,2800), labels = c("Thu","Fri","Sat"))
     }
)

with(data,
     {
       plot(Sub_metering_1, type = "l", xaxt = "none", xlab = "", ylab = "Energy sub metering")
       lines(Sub_metering_2, col="red")
       lines(Sub_metering_3, col="blue")
       axis(1, at = c(0,1500,2800), labels = c("Thu","Fri","Sat"))
       legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = "solid", cex=0.5, bty = "n")
     }
)

with(data,
     {
       plot(Global_reactive_power, type = "l", xaxt = "none", xlab = "datetime", ylab = "Global_reactive_power")
       axis(1, at = c(0,1500,2800), labels = c("Thu","Fri","Sat"))
     }
)

dev.copy(png, filename = "plot4.png")
dev.off()

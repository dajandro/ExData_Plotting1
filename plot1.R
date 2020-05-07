library(dplyr)

# READ FILE
data <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = T)

# DATA PREPARATION
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- data %>% filter(Date >= as.Date("2007-02-01") &  Date <= as.Date("2007-02-02"))
data <- data %>% mutate(DateTime = as.POSIXct(paste0(Date, Time)), format = "%d/%m/%Y %H:%M:%S")

with(data,
     {
       hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
       dev.copy(png, filename = "plot1.png")
       dev.off()
     }
)

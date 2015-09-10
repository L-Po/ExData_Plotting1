data <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?",
                   skip=intersect(grep("31/1/2007", readLines("household_power_consumption.txt")),
                                  grep("23:59:00", readLines("household_power_consumption.txt"))), 
                   nrows=2880)

var_names <- read.table("household_power_consumption.txt", sep = ";", nrows = 1)

var_names <- unlist(var_names)

names(data) <- var_names

data$Date <- as.Date(data$Date, format= "%d/%m/%Y") 

data$Date <- do.call(paste, data[c(1,2)])

data$Date <- strptime(data$Date, format = "%Y-%m-%d %H:%M:%S")

data[,2] <- NULL


png(file = "plot4.png")

par(mfcol = c(2,2))

with(data, plot(Date, Global_active_power, type = "l", 
xlab = "", ylab = "Global Active Power"))

with(data, plot(Date, Sub_metering_1, type = "l", xlab = "", 
ylab = "Energy sub metering"))

lines(data$Date, data$Sub_metering_2, col= "red")

lines(data$Date, data$Sub_metering_3, col= "blue")

legend("topright", names(data[,6:8]), col = c("black", "red", "blue"), 
lty=1, bty = "n")


with(data, plot(Date, Voltage, type="l", xlab = "datetime"))

with(data, plot(Date, Global_reactive_power, type="l", xlab = "datetime"))


dev.off()



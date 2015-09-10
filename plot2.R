### Loading the data


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


### Creating the plot

png(file = "plot2.png")

with(data, plot(Date, Global_active_power, type = "l", 
                xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.off()

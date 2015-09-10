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


### Constructing the plot

png(file = "plot1.png")

with(data, hist(Global_active_power, col = "red", main = "Global Active Power", 
               xlab = "Global Active Power (kilowatts)"))

dev.off()


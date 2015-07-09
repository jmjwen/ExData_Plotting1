## Read in the dataset
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses = "character",
                   na.strings = "?")

## Convert Date to objects of class "Date"
data[,1] <- as.Date(data[,1], format="%d/%m/%Y")

## Subset data to desired dates
data_sub <- data[data$Date %in% as.Date(c("2007-02-01","2007-02-02")), ]

## Combine Date and Time columns into new column Date.Time
data_sub$Date.Time <- paste(data_sub$Date, data_sub$Time)

## Convert Date.Time column into POSIXlt and POSIXct formats
data_sub$Date.Time <- strptime(data_sub$Date.Time, format = "%Y-%m-%d %H:%M:%S")

## Convert Sub_metering_1, Sub_metering_2 and Sub_metering_3 into numerics
data_sub$Sub_metering_1 <- as.numeric(data_sub$Sub_metering_1)
data_sub$Sub_metering_2 <- as.numeric(data_sub$Sub_metering_2)
data_sub$Sub_metering_3 <- as.numeric(data_sub$Sub_metering_3)

## Open PNG graphics device and create plot
png("plot3.png", width = 480, height = 480)
with(data_sub, plot(Date.Time, Sub_metering_1, type = "s", xlab = "", ylab = "Energy sub metering"))
with(data_sub, lines(Date.Time, Sub_metering_2, type = "s", col = "red"))
with(data_sub, lines(Date.Time, Sub_metering_3, type = "s", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
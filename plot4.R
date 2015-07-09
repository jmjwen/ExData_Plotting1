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

## Convert Global Active Power to numeric
data_sub$Global_active_power <- as.numeric(data_sub$Global_active_power)

## Convert Sub_metering_1, Sub_metering_2 and Sub_metering_3 into numerics
data_sub$Sub_metering_1 <- as.numeric(data_sub$Sub_metering_1)
data_sub$Sub_metering_2 <- as.numeric(data_sub$Sub_metering_2)
data_sub$Sub_metering_3 <- as.numeric(data_sub$Sub_metering_3)

## Convert Voltage to numeric
data_sub$Voltage <- as.numeric(data_sub$Voltage)

## Convert Global Reactive Power to numeric
data_sub$Global_reactive_power <- as.numeric(data_sub$Global_reactive_power)

## Open PNG graphics device and create plot
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(data_sub, {
  plot(Date.Time, Global_active_power, xlab = "", ylab = "Global Active Power", type = "s")
  plot(Date.Time, Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
  plot(Date.Time, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "s")
  lines(Date.Time, Sub_metering_2, col = "red", type = "s")
  lines(Date.Time, Sub_metering_3, col = "blue", type = "s")
  legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Date.Time, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "s")
})
dev.off()
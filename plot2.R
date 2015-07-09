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

## Open PNG graphics device and create plot
png("plot2.png", width = 480, height = 480)
plot(data_sub$Date.Time, data_sub$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
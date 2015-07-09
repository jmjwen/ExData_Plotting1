## Read in the dataset
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses = "character",
                   na.strings = "?")

## Convert Date to objects of class "Date"
data[,1] <- as.Date(data[,1], format="%d/%m/%Y")

## Subset data to desired dates
data_sub <- data[data$Date %in% as.Date(c("2007-02-01","2007-02-02")), ]

## Convert Global Active Power to numeric
data_sub$Global_active_power <- as.numeric(data_sub$Global_active_power)

## Open PNG graphics device and create plot
png("plot1.png", width = 480, height = 480)
hist(data_sub$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
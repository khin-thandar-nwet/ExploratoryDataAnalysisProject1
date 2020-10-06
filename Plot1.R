## Loading the data
t <- read.table("household_power_consumption.txt", header = T, sep = ";", stringsAsFactors = F, dec = ".")
summary(t)

## Subset the data from the dates
tsubset <- t[t$Date %in% c("1/2/2007", "2/2/2007"), ]
globalActivePower <- as.numeric(tsubset$Global_active_power)
globalReactivePower <- as.numeric(tsubset$Global_reactive_power)
voltage <- as.numeric(tsubset$Voltage)
SM1 <- as.numeric(tsubset$Sub_metering_1)
SM2 <- as.numeric(tsubset$Sub_metering_2)
SM3 <- as.numeric(tsubset$Sub_metering_3)

## PLOT 1
## Create the histogram
par("mar")
par(mar = c(2, 3, 2, 2))
hist(globalActivePower, main = "Global Active Power", xlab = "Global Active Power (kw)", col = "red")

## Save file and close
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()

## PLOT 2
## Create a Time Series
datetime <- strptime(paste(tsubset$Date, tsubset$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
plot(datetime, globalActivePower, type = "l", xlab = "", ylab = "Global Active Power (kw)")

## Save file and close
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()

## PLOT 3
## Create a plot for submetering
par(mar = c(4, 4, 4, 2))
with(t, {
     plot(datetime, SM1, type = "l",
          ylab = "Global Active Power (kw)",
          xlab = "")
     lines(datetime, SM2, col = "red")
     lines(datetime, SM3, col = "blue")
})

legend("topright", col = c("black", "red", "blue"), lwd = c(1, 1, 1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save file and close
dev.copy(png, "plot3.png", width = 480, height = 480)
dev.off()


## PLOT 4
## Create multiple plot
par(mfrow = c(2, 2), mar = c(2, 2, 2, 1), oma = c(0, 0, 2, 0))
## par(mfrow = c(2, 2))
with(t, {
     plot(datetime, globalActivePower, type = "l", ylab = "Global Active Power (kw)", xlab = "", cex = 0.2)
     plot(datetime, voltage, type = "l", ylab = "Voltage (v)", xlab = "")
     plot(datetime, SM1, type = "l", ylab = "Energy Submetering", xlab = "")
     lines(datetime, SM2, col = "red")
     lines(datetime, SM3, col = "blue")
     legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(datetime, globalReactivePower, type = "l", ylab = "Global Reactive Power (kw)", xlab = "", cex = 0.2)
})

## Save file and close
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()

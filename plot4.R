## Read table
data<-read.table(pipe('grep -e "^1/2/2007" -e "^2/2/2007" household_power_consumption.txt'),
                 header=FALSE, sep=";", colClasses=c("character","character",rep("numeric",7)),na.strings=c("?"),
                 col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
## Convert timestamps and dates
data$Time<-strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(data$Date, format="%d/%m/%Y")
## Open graphics device
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
## Top left
plot(data$Time,data$Global_active_power,ylab="Global Active Power (kilowatts)",xlab="",type="l")
## Top right
plot(data$Time,data$Voltage,ylab="Voltage",xlab="datetime",type="l")
## Bottom left
plot(data$Time, data$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(data$Time, data$Sub_metering_1)
lines(data$Time, data$Sub_metering_2, col="red")
lines(data$Time, data$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"),bty="n")
## Bottom right
plot(data$Time, data$Global_reactive_power,ylab="Global_reactive_power",xlab="datetime",type="l")
dev.off()

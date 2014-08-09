## Read table
data<-read.table(pipe('grep -e "^1/2/2007" -e "^2/2/2007" household_power_consumption.txt'),
                 header=FALSE, sep=";", colClasses=c("character","character",rep("numeric",7)),na.strings=c("?"),
                 col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
## Convert timestamps and dates
data$Time<-strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(data$Date, format="%d/%m/%Y")
## Open graphics device
png(filename="plot1.png", width=480, height=480)
hist(data$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()

#Dan Lowrance - plot4.R 12/21/16
t = read.table(file = "household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)#input raw data
t = subset(t, Date == "1/2/2007"| Date =="2/2/2007")#reduce the dataset to only the two days in the assignment
datetime<-strptime(paste(t[,1],t[,2]), format = "%d/%m/%Y %H:%M:%S")#Formats Date and Time columns into POSIX class for plotting
png(filename = "plot4.png")#opens png graphics device default is 480x480
par(mfrow = c(2,2))
with(t, { 
     plot(datetime,Global_active_power, pch = "", type = "o", ylab = "Global Active Power", xlab = "")#plot2 w/o (kilowatts) in ylab
     plot(datetime,Voltage, pch = "", type = "o", ylab = "Voltage")#Make the line plot with Y axis label
     plot(datetime,Sub_metering_1, pch = "", type = "o", ylab = "Energy sub metering", xlab = "")#Make plot3
          points(datetime, t$Sub_metering_2, pch = "", type = "o", col = "red")# Add the next line
          points(datetime, t$Sub_metering_3, pch = "", type = "o", col = "blue")# Add the next line
          legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n", lty = c(1,1,1), col = c("black","red","blue"))
     plot(datetime,Global_reactive_power, pch = "", type = "o")#Make the line plot with no explicit Y axis label
      })
dev.off() #closes the png file device
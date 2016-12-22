#Dan Lowrance - plot3.R 12/21/16
t = read.table(file = "household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)#input raw data
t = subset(t, Date == "1/2/2007"| Date =="2/2/2007")#reduce the dataset to only the two days in the assignment
x<-strptime(paste(t[,1],t[,2]), format = "%d/%m/%Y %H:%M:%S")#Formats Date and Time columns into POSIX class for plotting
png(filename = "plot3.png")#opens png graphics device default is 480x480
with(t, plot(x,Sub_metering_1, pch = "", type = "o", ylab = "Energy sub metering", xlab = ""))#Make the line plot with Y axis label
points(x, t$Sub_metering_2, pch = "", type = "o", col = "red")# Add the next line
points(x, t$Sub_metering_3, pch = "", type = "o", col = "blue")# Add the next line
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1), col = c("black","red","blue"))#Add legend
dev.off() #closes the png file device
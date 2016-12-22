#Dan Lowrance - plot2.R 12/21/16
t = read.table(file = "household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)#input raw data
t = subset(t, Date == "1/2/2007"| Date =="2/2/2007")#reduce the dataset to only the two days in the assignment
x<-strptime(paste(t[,1],t[,2]), format = "%d/%m/%Y %H:%M:%S")#Formats Date and Time columns into POSIX class for plotting
with(t, plot(x,Global_active_power, pch = "", type = "o", ylab = "Global Active Power (kilowatts)"))#Make the line plot with Y axis label
dev.copy(png, file = "plot2.png", width = 480, height = 480)#store the plot as 480x480 pixel png file
dev.off() #closes the png file device

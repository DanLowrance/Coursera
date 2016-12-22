t = read.table(file = "household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)#input raw data
t = subset(t, Date == "1/2/2007"| Date =="2/2/2007")#reduce the dataset to only the two days in the assignment
#####Plot 1 is a histogram in red of Global Active Power column with and explicit title and x-axis label definition
hist(t$Global_active_power, breaks = 11, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480)#store the plot as 480x480 pixel png file
dev.off() #closes the png file device
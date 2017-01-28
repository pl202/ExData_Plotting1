getwd()
setwd("./ExData_Plotting1")
getwd()
setwd("..")
getwd()

library(dplyr)
library(lubridate)

##Look at the first 5 rows of data
read.table("household_power_consumption.txt", sep = ";", header=TRUE, nrows = 5)

##Read in all of the data from the file in the working directory
data_all<-read.table("household_power_consumption.txt", sep = ";", header=TRUE)
data_all[data_all=="?"]<-NA
data_all[, 3:9] <- lapply(data_all[, 3:9], function(x) as.numeric(as.character(x)))
str(data_all)
head(data_all)
data_all$Time_Cont<-dmy_hms(paste(data_all$Date,data_all$Time, sep = ","))
data_all$Date<-dmy(data_all$Date)
data_all$Time<-hms(data_all$Time)
head(data_all)

##Select data for two relevant days
dat2<-filter(data_all, data_all$Date == "2007-02-01" | data_all$Date == "2007-02-02")
head(dat2)
str(dat2)
unique(dat2$Date)
dim(dat2)


##Make a graph on a screen device
with(dat2, plot(Time_Cont,Sub_metering_1, ylab = "Energy sub metering", type ="l", xlab = ""))
lines(dat2$Time_Cont,dat2$Sub_metering_2, col = "red")
lines(dat2$Time_Cont,dat2$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = 1, col = c("black","red","blue"))

getwd()
setwd("./ExData_Plotting1")
getwd()

##Make a png file in the repository
png(filename = "Plot3.png",width = 480, height = 480)
with(dat2, plot(Time_Cont,Sub_metering_1, ylab = "Energy sub metering", type ="l", xlab = ""))
lines(dat2$Time_Cont,dat2$Sub_metering_2, col = "red")
lines(dat2$Time_Cont,dat2$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = 1, col = c("black","red","blue"))

dev.off()
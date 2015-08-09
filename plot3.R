install.packages("dplyr")
library("dplyr")
root <- getwd()
nroot <- "C:/Users/Marcel/Desktop/Coursera/Projeto_4/Semana 1/Projeto"
setwd(nroot)
data <- "C:/Users/Marcel/Desktop/Coursera/Projeto_4/Semana 1/Data/Projeto_semana1/household_power_consumption.txt"

#loading
#2,075,259 rows and 9 columns
data_f <- read.table(data, header = TRUE, sep = ";", na.strings = "?")
head(data_f, n=3)
colnames(data_f)

#use dates 2007-02-01 and 2007-02-02
date_flt <- filter(data_f, as.Date(Date, "%d/%m/%Y") %in% as.Date(c("01/02/2007", "02/02/2007"), "%d/%m/%Y"))

#convert Date and Time variables to Date/Time, strptime() as.Date()
data_f_tr <- mutate(date_flt, Date.tr = as.Date(Date, "%d/%m/%Y"), 
                    DateTime.tr = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"),  tz = "GMT"))
head(data_f_tr, n=3)

##Graph
png(file = "plot3.png", bg = "white",width = 480, height = 480)
plot(data_f_tr$DateTime.tr, data_f_tr$Sub_metering_1, pch = ".", xlab = "", 
     ylab = "Energy sub metering")
lines(data_f_tr$DateTime.tr, data_f_tr$Sub_metering_1,  col = "black")
lines(data_f_tr$DateTime.tr, data_f_tr$Sub_metering_2,  col = "red")
lines(data_f_tr$DateTime.tr, data_f_tr$Sub_metering_3,  col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = c(1, 1, 1),  lwd = c(1, 1, 1))
dev.off()
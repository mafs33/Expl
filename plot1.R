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

#Histogram
png(file = "plot1.png", bg = "white",width = 480, height = 480)
hist(data_f_tr$Global_active_power, 
     col = "red1", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylim = c(0, 1300))
dev.off()

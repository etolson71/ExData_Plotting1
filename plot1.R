setwd("C:\\Users\\EriksLaptop\\Documents\\DataScientistClasses\\ExploreData\\proj1")

library(sqldf)

#####################Get Data for Analysis##########################
data1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(data1,"power1.zip",mode="wb")  #Download from internet
unzip("power1.zip")   #Unzip file into working directory set above

elect1 <- read.csv.sql("household_power_consumption.txt",
                       sql = 'select * from file where Date in ("1/2/2007","2/2/2007")',
                       header=TRUE,sep=";") #Read only dates required using SQL

#Convert date and time fields into a R data/time variable
elect1$datetm <-strptime(paste(elect1$Date, elect1$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
elect1 <- elect1[,-c(1,2)]  #Remove unneeded Date and Time fields

#####################Make Plot 1###########################
dev.copy(png,'plot1.png')
hist(elect1$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()
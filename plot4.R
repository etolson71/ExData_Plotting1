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

#####################Make Plot 4###########################
dev.copy(png,'plot4.png')
par(mfrow=c(2,2))

#Plot for top left
plot(elect1$datetm,elect1$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

#Plot for top right
plot(elect1$datetm,elect1$Voltage,type="l",ylab="Voltage",xlab="datetime")

#Plot for bottom left
plot(elect1$datetm,elect1$Sub_metering_1,type="n",col="black",ylim=c(0,37),xlab="",ylab="Energy sub metering")
lines(elect1$datetm,elect1$Sub_metering_1,type="l",col="black")
lines(elect1$datetm,elect1$Sub_metering_2,type="l",col="red")
lines(elect1$datetm,elect1$Sub_metering_3,type="l",col="blue")
legend( "topright",,
        c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
        lty=c(1,1,1),col=c("black","red","blue"),bty = "n",cex=0.8) 

#Plot for bottom right
plot(elect1$datetm,elect1$Global_reactive_power,type="l",ylim=c(0,0.5),cex.axis=0.8,ylab="Global_reactive_power",xlab="datetime")

dev.off()

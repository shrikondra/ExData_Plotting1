## PLOT 3 STEPS

## plot3("household_power_consumption.txt") or simply plot3()
## Read file in R and assigned to the power variable 
## Relevant days of interest are subsetted out of the power data frame
## Sub_metering,Voltage, Global_active_power, and Global_reactive_power cols are reformatted as numeric vectors
## Plot Layout is changed from (1,1) to (2,2) using the par command. 
## Each plot is generated. 
## File is saved as "plot4.png"
## dev is closed


plot4 <- function(file = "household_power_consumption.txt") {
        power <- read.table(file, header=T, sep=";")
        power$Date <- as.Date(power$Date, format="%d/%m/%Y")
        DataSubset <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
        
        DataSubset$Sub_metering_1 <- as.numeric(as.character(DataSubset$Sub_metering_1))
        DataSubset$Sub_metering_2 <- as.numeric(as.character(DataSubset$Sub_metering_2))
        DataSubset$Sub_metering_3 <- as.numeric(as.character(DataSubset$Sub_metering_3))
        DataSubset$Global_active_power <- as.numeric(as.character(DataSubset$Global_active_power))
        DataSubset$Global_reactive_power <- as.numeric(as.character(DataSubset$Global_reactive_power))
        DataSubset$Voltage <- as.numeric(as.character(DataSubset$Voltage))
        
        DataSubset <- transform(DataSubset, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
        
        par(mfrow=c(2,2))
        
        ##PLOT 1
        plot(DataSubset$timestamp,DataSubset$Global_active_power, type="l", xlab="", ylab="Global Active Power")
        ##PLOT 2
        plot(DataSubset$timestamp,DataSubset$Voltage, type="l", xlab="datetime", ylab="Voltage")
        
        ##PLOT 3
        plot(DataSubset$timestamp,DataSubset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(DataSubset$timestamp,DataSubset$Sub_metering_2,col="red")
        lines(DataSubset$timestamp,DataSubset$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
        
        #PLOT 4
        plot(DataSubset$timestamp,DataSubset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

        dev.copy(png, file="plot4.png", width=480, height=480)
        dev.off()
        print("Plot4.png has been saved")
}

# Test
plot4()
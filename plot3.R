## PLOT 3 STEPS

## plot3("household_power_consumption.txt") or simply plot3()
## Read file in R and assigned to the power variable 
## Relevant days of interest are subsetted out of the power data frame
## Time column is added  
## Sub_metering cols are reformatted as numeric vectors
## Plot is generated
## File is saved as "plot3.png"
## dev is closed


plot3 <- function(file = "household_power_consumption.txt") {
    
    power <- read.table(file, header=T, sep=";")
    power$Date <- as.Date(power$Date, format="%d/%m/%Y")
    
    DataSubset <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
    
    DataSubset$Global_active_power <- as.numeric(as.character(DataSubset$Global_active_power))
    
    DataSubset <- transform(DataSubset, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
    
    DataSubset$Sub_metering_1 <- as.numeric(as.character(DataSubset$Sub_metering_1))
    DataSubset$Sub_metering_2 <- as.numeric(as.character(DataSubset$Sub_metering_2))
    DataSubset$Sub_metering_3 <- as.numeric(as.character(DataSubset$Sub_metering_3))
    
    
    plot(DataSubset$timestamp,DataSubset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    lines(DataSubset$timestamp,DataSubset$Sub_metering_2,col="red")
    lines(DataSubset$timestamp,DataSubset$Sub_metering_3,col="blue")
    
    legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
    
    dev.copy(png, file="plot3.png", width=480, height=480)
    dev.off()
    print("Plot3.png has been saved")
}

# Test
plot3()

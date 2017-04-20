## PLOT 2 STEPS

## plot2("household_power_consumption.txt") or simply plot2()
## Read file in R and assigned to the power variable 
## Relevant days of interest are subsetted out of the power data frame
## Time column is added  
## Plot is generated
## File is saved as "plot2.png"
## dev is closed


plot2 <- function(file = "household_power_consumption.txt") {
    
    power <- read.table(file, header=T, sep=";")
    power$Date <- as.Date(power$Date, format="%d/%m/%Y")
    
    DataSubset <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
    
    DataSubset$Global_active_power <- as.numeric(as.character(DataSubset$Global_active_power))
    
    DataSubset <- transform(DataSubset, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
    
    plot(DataSubset$timestamp,DataSubset$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
    
    dev.copy(png, file="plot2.png", width=480, height=480)
    dev.off()
    print("Plot2.png has been saved")
    
}

#Test
plot2()

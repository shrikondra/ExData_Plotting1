## PLOT 1 STEPS

## plot1("household_power_consumption.txt") or simply plot1()
## Read file in R and assigned to the power variable 
## Relevant days of interest are subsetted out of the power data frame
## Histogram is generated 
## File is saved as "plot1.png"
## dev is closed

plot1 <- function(file = "household_power_consumption.txt") {
        
        power <- read.table(file, header=T, sep=";")
        power$Date <- as.Date(power$Date, format="%d/%m/%Y")
        
        DataSubset <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
        
        DataSubset$Global_active_power <- as.numeric(as.character(DataSubset$Global_active_power))
        
        hist(DataSubset$Global_active_power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
        
        dev.copy(png, file="plot1.png", width=480, height=480)
        dev.off()
        print("Plot1.png has been saved")
}

# Test
plot1()


############ OPEN THE DATA AND BUILD DATA FRAME #################
# Assumes data file in user working dir

df <- read.csv("household_power_consumption.txt", 
               header=T, 
               sep=';', 
               na.strings="?",
               check.names=F, 
               stringsAsFactors=F, 
               comment.char="",
               quote='\"')

df$Date <- as.Date(df$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(df, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(df)

## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

############ BUILD GRAPH FILE ##########################
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

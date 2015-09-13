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
## Plot 2
plot(data$Global_active_power~data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

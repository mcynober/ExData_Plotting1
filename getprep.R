get.file <- function(fileURL, file.name) {
	if(!file.exists(file.name)) {
		download.file(fileURL, destfile=file.name, method="curl")
	}
	file.name
}

prep.data <- function() {
	tempFile <- "plot_data.csv"
	if(file.exists(tempFile)) {
		data <- read.csv(tempFile)
		data$DateTime <- strptime(data$DateTime, "%Y-%m-%d %H:%M:%S")
	}
	else {
		file.name <- get.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
		tempText <- unz(file.name, "household_power_consumption.txt")
		data <- read.table(tempText, sep=";", na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), header=TRUE)
		data <- data[(data$Date == "1/2/2007") | (data$Date == "2/2/2007"), ]
		data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
		write.csv(data, tempFile)
	}
	data
}
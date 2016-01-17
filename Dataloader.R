#get the data and create the raw data set

#setup a new directoy in the working directory to import the zip data file into
if(!file.exists("./data")){dir.create("./data")}

#download the zip file from url
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile ="./data/dataSet.zip")

#extract file from zip archive
unzip("./data/dataSet.zip", exdir="./data/unzipped")

#read data file into a table 
data <- read.table("./data/unzipped/household_power_consumption.txt",
                        header=TRUE,
                        sep = ";",
                        na.strings = "?",
                        colClasses = c("character", "character", rep("numeric",7)))

attach(data)

#only need data for 1st and 2nd feb 2007

subset <- Date =="1/2/2007"| Date =="2/2/2007"
newData <- data[subset, ]
attach(newData)

x <- paste(Date, Time)
newData$DateTime <- strptime(x, "%d/%m/%Y %H:%M:%S")
rownames(newData) <- 1:nrow(newData)  
attach(newData)

###############################################################################
#     plot2.R: Plotting Assignment 1 for Exploratory Data Analysis
#     Copyright (C) 2019  Renato Magnelli
# 
#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
# 
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
# 
#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <https://www.gnu.org/licenses/>.
###############################################################################

###############################################################################
#     Plot 2/4 Assignment 1, Exploratory Data Analysis Johns Hopkins University
#     on Coursera                                      Student: Renato Magnelli
###############################################################################

UCI_url = 
"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("household_power_consumption.txt")){
      download.file(UCI_url, destfile = "exdata_data_household_power_consumption.zip")
      unzip("exdata_data_household_power_consumption.zip")
}

txtfile   = "./household_power_consumption.txt"
data_begin = grep("1/2/2007", readLines(txtfile))[1] - 1
data_end   = grep("3/2/2007", readLines(txtfile))[1] - 1

UCI_data = read.table(file  = txtfile,
                      sep   = ";",
                      skip  = data_begin,
                      nrows = data_end - data_begin,
                      na.strings = "?",
                      col.names  = strsplit(x = readLines(txtfile, n = 1),
                                            split = ";")[[1]])
UCI_data$Time <- as.POSIXct(paste(UCI_data$Date, UCI_data$Time),
                            format="%d/%m/%Y %H:%M:%S")
UCI_data$Date <- NULL

dir.create(file.path(getwd(), "figure"), showWarnings = FALSE)
cwd = getwd()
setwd(file.path(getwd(), "figure"))
png(file = "plot2.png", width = 480, height = 480)
Sys.setlocale("LC_TIME", "en_US")
with(UCI_data, plot(x = Time, type = "l",
                    y = Global_active_power,
                    ylab = "Global Active Power (kilowatts)",
                    xlab = ""))
dev.off()
setwd(cwd)

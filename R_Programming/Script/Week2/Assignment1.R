## PART ONE
# Download data
dataset_url <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
download.file(dataset_url, "specdata.zip")

# Unzipping downloaded dataset specdata
uzp <- '~/Desktop/Data Analyst /Johns Hopkins Data Science/datasciencecoursera/specdata.zip' #where file located
unzip(
        uzp, 
        exdir = '~/Desktop/Data Analyst / Johns Hopins Data Science/datasciencecoursera/jhuRprogramming/Data/specdata') 
#where you want it

#IF YOU ARE ALREADY IN SAME WORKING DIRECTORY AND GET CHARACTER(0) BACK OUT ONE FILE THEN DO THE FOLLOWING
list.files("specdata")

library(tidyverse)
library(fs)

file_paths <- fs::dir_ls("/Users/amandacoddington/Desktop/Data Analysis/Johns Hopkins Data Science/datasciencecoursera/jhuRprogramming/specdata")

# Create list in FOR LOOP to read multiple CSV files
        file_contents <- list()
        seq_along(file_paths) # sequence or length of file_paths
        
        # file_contents[[i]] in for loop will add new element i in that list with '[[]]'
                for (i in seq_along(file_paths)) {
                        file_contents[[i]] <- read.csv(
                                file = file_paths[[i]]
                        )
                        
                }

# To view specific file in file_contents 
file_contents[[n]]

# Get to know the data (example with one file from file_contents)
head(file_contents[[8]])
dim(file_contents[[8]])
summary(file_contents[[8]])

# Create empty data frame to run loop to combine all data into one data frame
dat <- data.frame()

# For loop to move all our data into dat 
for (i in 1:332) {
        dat <- rbind(dat, read.csv(file_paths[i]))
}

# Create function that will calculate the mean of a pollutant (sulfate or nitrate) 
# across a specified list of monitors
pollutantmean <- function(directory, pollutant, id = 1:332) {
        files_list <- list.files(directory, full.names = TRUE) 
        dat <- data.frame() 
        for (i in id) { 
                dat <- rbind(dat, read.csv(files_list[i]))
        }
        if (pollutant == "sulfate") {
                mean(dat$sulfate, na.rm = TRUE)
        } else if (pollutant == "nitrate") {
                mean(dat$nitrate, na.rm = TRUE)
        }
}
       
        
# Testing out my function in different ways
pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 23)
pollutantmean("specdata", "nitrate", 70:72)



## PART TWO

# Getting a feel for the data, determining how many NA values each column has
sum(is.na(one))
sum(is.na(one$sulfate))
sum(is.na(one$nitrate))
sum(is.na(one$Date))
sum(is.na(one$ID))
# subtracting total rows minus the highest number of NA values
1461 - 1344 = 117 # completely observed cases are rows without NA values

# Write function that reads directory & reports number of completely observed cases

complete <- function(directory, id = 1:332) {
        monitor_id <- c()
        total_cc <- c()
        files_list <- list.files(directory)
        for (i in id) {
                file_path <- paste(directory,"/" , files_list[i], sep = "")
                data <- read.csv(file_path, header = TRUE)
                complete_cases <- data[complete.cases(data), ]
                monitor_id <- c(monitor_id, i)
                total_cc <- c(total_cc, nrow(complete_cases))
        }
        data.frame(id = monitor_id, nobs = total_cc)
}

# Testing function
complete("specdata", 1)
complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
complete("specdata", 3)



## PART THREE

# Write function that calculates correlation b/w sulfate & nitrate where the 
# number of completely observed cases (all variables) is greater than the threshold

corr <- function(directory, threshold = 0) {
        cc_files <- complete(directory, 1:332)
        nobs_above_threshold <- subset(cc_files, nobs > threshold)
        correlation <- vector()
        files_list <- list.files(directory)
        for (i in nobs_above_threshold$id) {
                file_path <- paste(directory,"/" , files_list[i], sep = "")
                data <- read.csv(file_path, header = TRUE)
                complete_case <- data[complete.cases(data), ]
                total_cc <- nrow(complete_case)
                if (total_cc >= threshold) {
                        correlation <- c(correlation, cor(complete_case$nitrate, 
                                                          complete_case$sulfate))
                }
                
        }
        correlation
}

# Testing function
cr <- corr("specdata", 150)
head(cr)
summary(cr)

cr <- corr("specdata", 400)
head(cr)
summary(cr)

cr <- corr("specdata", 5000)
summary(cr)

cr <- corr("specdata")
summary(cr)
length(cr)



### QUIZ (PART FOUR)

# No. 1
pollutantmean("specdata", "sulfate", 1:10)

# No. 2
pollutantmean("specdata", "nitrate", 70:72)

# No. 3
pollutantmean("specdata", "sulfate", 34)

# No. 4
pollutantmean("specdata", "nitrate")

# No. 5
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)

# No. 6
cc <- complete("specdata", 54)
print(cc$nobs)

# No. 7
RNGversion("3.5.1")
set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])

# No. 8
cr <- corr("specdata")
cr <- sort(cr)
RNGversion("3.5.1")
set.seed(868)
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

# No. 9
cr <- corr("specdata", 129)
cr <- sort(cr)
n <- length(cr)
RNGversion("3.5.1")
set.seed(197)
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

# No. 10
cr <- corr("specdata", 2000)
n <- length(cr)
cr <- corr("specdata", 1000)
cr <- sort(cr)
print(c(n, round(cr, 4)))











cr <- 
# Download practice assignment and unzip data into my working directory
        dataset_url <- "http://s3.amazonaws.com/practice_assignment/diet_data.zip"
        download.file(dataset_url, "diet_data.zip")
        unzip("diet_data.zip", exdir = "diet_data")
        list.files("diet_data")
        andy <- read.csv("diet_data/Andy.csv")
# Overview of Andy data
head(andy)

# Figure out how many rows there are by looking at 'Day'
length(andy$Day)

# Call the dimensions of the data.frame to get same result as ~11
dim(andy)

# Call following functions to get feel for R
str(andy)

summary(andy)

names(andy)

# To see Andy starting weight, subset the data, 1st row of 'Weight'
andy[1, 'Weight']

# See Andy final weight on Day 30
andy[30, 'Weight']
        #or
andy[which(andy$Day == 30), 'Weight']
        #or
andy[which(andy[,'Day'] == 30), 'Weight']
        #or
subset(andy$Weight, andy$Day == 30)

# Assign Andy's starting and ending weight to vectors
andy_start <- andy[1, 'Weight']

andy_end <- andy[30, 'Weight']

# Find how much Andy lost by subtracting the vectors
andy_loss <- andy_start - andy_end

andy_loss

# Look at other subjects & save file output
files <- list.files("diet_data")

files

# Call a specific file from files by subsetting it
files[1]

files[2] 

files[3:5]

# Take a look at John.csv (incorrect way)
        # you will get an error because we just tried to run equivalent to 
        # 'read.csv("John.csv") & R correctly told us that there isn't a file 
        # called 'John.csv' in our working directory. To fix this you need
        # to append the directory to the beginning of the file name
        head(read.csv(files[3]))

# Can use paste() or sprintf() to fix, but help file of list.files() the
        # argument full.names will append (prepend technically) the path
        # to the file name for us
        files_full <- list.files("diet_data", full.names = TRUE)

        files_full

# Take a look at John.csv ( works after appending directory )
head(read.csv(files_full[3]))

# Combine all their data into one big data frame with rbind() & loop
        # rbind() first 
        # this line of code adds the rows from David to our existing data frame 
        andy_david <- rbind(andy, read.csv(files_full[2]))

# Check above code via:
head(andy_david)

tail(andy_david)

# Note on rbind()
        # requires 2 arguments 
        # [1st] existing data frame
        # [2nd] what you want to append to it
        # on some occasions, you may want to create an empty data frame so
        # there is something to use as the existing data frame in argument

# Subset of data frame that shows just 25th day for Andy and David
day_25 <- andy_david[which(andy_david$Day == 25), ]

day_25

# Sometimes rbind() is not practical when you have lots of data

# Example loop
        # for each pass through the loop, i increases by 1 from 1 thru 5
        for (i in 1:5) {
                print(i)
        }

# Loop applied to to our list of files
        # this will give an error 'Object 'dat' not found' because you cant
        # rbind something into a file that doesn't exist yet
        for (i in 1:5) {
                dat <- rbind(dat, read.csv(files_full[i]))
        }

# Create empty data frame 'dat' before running loop
for (i in 1:5){
        dat2 <- data.frame()
        dat2 <- rbind(dat2, read.csv(files_full[i]))
}

str(dat2)

head(dat2)
     
# Get median for all the data
        # gives null because there is NAs in data
median(dat2$weight)

# Get rid of NAs (specifically with median in this case)
        # can subset data with complete.cases() or is.na() but if you look
        # at ?median there is argument 'na.rm' that will strip the NAs out
median(dat2$Weight, na.rm = TRUE)

# Get median weight of day 30 by taking the median of a subset where Day=30
dat_30 <- dat2[which(dat2[, 'Day'] == 30),]

dat_30

median(dat_30$Weight)

# Build a function that will return the median weight for any given day
        # 1st define what the arguments of the function should be 
        # (parameters user must define)
                # [1] define directory holding the data
                # [2] define Day they want median
        'weightmedian' <- function(directory, day) {
                 # content of the function
        }
        # content: need data from the CSVs, then subset that data frame using
        # argument 'day' and take median of that subset
                # to get all data in a single data frame: rbind & list.files
weightmedian <- function(directory, day) {
        files_list <- list.files(directory, full.names = TRUE) # creates a list of files
        dat <- data.frame() # creates a empty data frame
        for (i in 1:5) { # loops through the files, rbinding them together
                dat <- rbind(dat, read.csv(files_list[i]))
        }
        dat_subset <- dat[which(dat[, 'Day'] == day), ] #subsets the rows that match the day argument
        median(dat_subset[, 'Weight'], na.rm = TRUE) # identifies the median weight & strips out NAs
}

# Can test our weightmedian function via:
weightmedian(directory = 'diet_data', day = 20)

weightmedian('diet_data', 4)

weightmedian('diet_data', 17)

# Above way to create function can be slow & issues with growing objects inside loop by copying and recopying it

# Better approach to create function like above:
        # create an output object of an appropriate size & then fill it up
        # 1st create an empty list thats the length of our expected outcome
                summary(files_full)
                tmp <- vector(mode = 'list', length = length(files_full))
                summary(tmp)
        # 2nd read in csv files and drop them into 'tmp'
                for (i in seq_along(files_full)) {
                        tmp[[i]] <- read.csv(files_full[[i]])
                } # functionally equivalent to lapply() 
                str(tmp)

# Above function's lapply equivalent 
        # + is you dont have to woory about loop housekeeping, so you can focus on function you are using
        # easier to understand what you are doing and why
                
# use do.call() to combine tmp into a single data frame
        # do.call lets you specify a function and then passes a list as if each element were an argument to that function
                # this is the syntax 
                        # 'do.call(function_you_want_to_use, list_of_arguments)
        output <- do.call(rbind, tmp)
        str(output)
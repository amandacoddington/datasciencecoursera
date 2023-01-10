        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV file

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used

        ## Return a data frame of the form:
        ## id   nobs
        ## 1    117
        ## 2    1041
        ## ...
        ## where 'id' is the monitor IF and 'nobs' is the 
        ## number of complete cases 
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

        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV file

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between 
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations
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
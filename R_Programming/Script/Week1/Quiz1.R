# Week 1 Quiz
        # shows logical vector of NAs
                is.na(hw1_data)
        # shows numeric vector of count of total NAs in data frame
                sum(is.na(hw1_data$Ozone))
        # shows the means of each column in data frame excluding NAs via na.rm = TRUE
                colMeans(hw1_data, na.rm = TRUE)
        # extract multiple columns from data frame
                hw1_data[ , c("Ozone", "Temp")]
       
                
        ## HW1 No. 18
                #extract rows where Ozone is greater than 31 and Temp is greater than 90
                        hw1_data[hw1_data$Ozone > 31 & hw1_data$Temp > 90, ]
                # set above code to x
                         x <- hw1_data[hw1_data$Ozone > 31 & hw1_data$Temp > 90, ]
                # to find mean of each column in this subset without NA values
                        colMeans(x, na.rm = TRUE)
       
                        
        ##HW1 No. 19
                # subset data frame for only rows containing month = 6        
                        hw1_data[hw1_data$Month == 6, ]
                # set above code to x
                        x <- hw1_data[hw1_data$Month == 6, ]
                # to find mean of each column in this subset without NA values
                        colMeans(x, na.rm = TRUE)
       
                        
        ## HW1 No. 20
                # find the max of Ozone in May excluding NAs       
                        hw1_data[hw1_data$Month == 5, ]
                        x <- hw1_data[hw1_data$Month == 5, ]
                        max(x[ ,1], na.rm = TRUE)
                        

## Getting and cleaning data - Coursera
## Course project
## You should create one R script called run_analysis.R that does the following.
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with 
##    the average of each variable for each activity and each subject.

run_analysis <- function (){   
    ## Set the working directory to the default one of the course
    default_path <- getwd()
    
    ## Change working directory to the one where the general data is stored
    setwd(".\\UCI HAR Dataset")
    
    ## Load the features vector
    cabecera <- read.table("features.txt", stringsAsFactors=FALSE)
    
    ## Load the activity labels
    activity_labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE)
    
    ##
    ## Load the test data
    ##
    
    ## Change working directory to the one where the test data is stored
    setwd(".\\test")
    
    ## Load the identification of test subjects
    subject_test <- read.table("subject_test.txt")
    
    ## Load the activities of test data
    activities_test <- read.table("y_test.txt")
    
    ## Load the test data in a temporary data frame
    tmp_data <- read.table("X_test.txt")
    
    ## Assign names to columns according to features vector
    names(tmp_data) <- cabecera[,2]
    
    ## Merge subjects and activities in a single data frame
    test_data <- cbind(subject_test, activities_test)
    
    ## Assign names to columns
    names(test_data) <- c("subject_id", "activity_id")
    
    ## Add the test data
    test_data <- cbind(test_data, tmp_data)
    
    ## Remove objects no longer needed
    remove(subject_test, activities_test, tmp_data)
    
    ##
    ## Load the train data
    ##
    
    ## Change working directory to the one where the train data is stored
    setwd("..\\")
    setwd(".\\train")
    
    ## Load the identification of train subjects
    subject_train <- read.table("subject_train.txt")
    
    ## Load the activities of train data
    activities_train <- read.table("y_train.txt")
    
    ## Load the train data in a temporary data frame
    tmp_data <- read.table("X_train.txt")
    
    ## Assign names to columns according to features vector
    names(tmp_data) <- cabecera[,2]
    
    ## Merge subjects and activities in a single data frame
    train_data <- cbind(subject_train, activities_train)
    
    ## Assign names to columns
    names(train_data) <- c("subject_id", "activity_id")
    
    ## Add the train data
    train_data <- cbind(train_data, tmp_data)
    
    ## Remove objects no longer needed
    remove(subject_train, activities_train, tmp_data)
    
    ## Merge test & train data in a single data frame
    final_data <- rbind(test_data, train_data)
    
    ## Remove objects no longer needed
    remove(test_data, train_data)
    
    ## Initialize the vector with the first two columns
    seleccion <- c(1,2)
    
    ## Select the columns with mean or std in their names
    cabecera_mean <- grep("mean", as.vector(cabecera[,2])) + 2
    cabecera_std <- grep("std", as.vector(cabecera[,2])) + 2
    seleccion <- c(seleccion, cabecera_mean, cabecera_std)
    
    ## Subset only the required columns of the data frame
    final_data <- subset(final_data, select = seleccion)
    
    ## Load the "plyr" package
    require(plyr)
    
    ## Split by subject_id and activity_id, and calculate mean by columns
    final_data <- ddply(final_data,.(subject_id,activity_id),colwise(mean))
    
    ## Change activity_id by activity label
    final_data$activity_id <- mapvalues(final_data$activity_id, from = activity_labels$V1, to = activity_labels$V2)
    
    ## Change working directory to the default one
    setwd(default_path)
    
    ## The tidy data set is written in a TXT file
    write.table(final_data, "tidy_data.txt", row.names = FALSE)
    
    ## The tidy data set is returned
    final_data
}
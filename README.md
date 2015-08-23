---
title: "README"
author: "Miguel Bermejo"
date: "17 de agosto de 2015"
output: html_document
---

# COURSERA - Getting & Cleaning Data

This project is based in the following publication: 

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. **A Public Domain Dataset for Human Activity Recognition Using Smartphones**. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

The details of the experiments and the features of the data set are described in the Code Book.

The R script called **run_analysis.R** does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject called **tidy_data.txt**.

In order to execute the script these files have to be stored in the same directory as the script.

* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training activity labels.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test activity labels.
* 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

The script also requires the 'plyr' package.

The pseudocode of the script is this.

* Save the currente working directory
* Change working directory to the one where the general data is stored
* Load the features vector
* Load the activity labels
* Load the test data
    + Change working directory to the one where the test data is stored
    + Load the identification of test subjects
    + Load the activities of test data
    + Load the test data in a temporary data frame
    + Assign names to columns according to features vector
    + Merge subjects and activities in a single data frame
    + Assign names to columns
    + Add the test data
    + Remove objects no longer needed
* Load the train data
    + Change working directory to the one where the train data is stored
    + Load the identification of train subjects
    + Load the activities of train data
    + Load the train data in a temporary data frame
    + Assign names to columns according to features vector
    + Merge subjects and activities in a single data frame
    + Assign names to columns
    + Add the train data
    + Remove objects no longer needed
* Merge test & train data in a single data frame
* Remove objects no longer needed
* Initialize the filter vector with the first two columns
* Select the columns with mean or std in their names
* Subset only the required columns of the data frame
* Load the "plyr" package
* Split by subject_id and activity_id, and calculate mean by columns
* Change activity_id by activity label
* Change working directory to the default one
* The tidy data set is written in a TXT file
* The tidy data set is returned
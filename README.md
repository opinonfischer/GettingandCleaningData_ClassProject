# Getting and Cleaning Data - Course Project

This repository contains the files necessary for the Getting and Cleaning Data Course Project:
* The code necessary is contained in one script: `run_analysis.R` 
* The resulting tidy data set is: `tidyData.txt`
* The code book that describes the variables, the data, and any transformation made to clean up the data is: `CodeBook.md`

## A few words about the `run_analysis.R` script:
* This script assumes the data has been downloaded and the UCI HAR Dataset folder is in the working directory as defined in setwd
*  Merges the training and the test sets to create one data set.
+ Read the training and test sets and bind them
+ Read the training and test labels and bind them
+ Read the training and test subjects and bind them

* Extracts only the measurements on the mean and standard deviation for each measurement
+ Read the features textfile
+ Identify column indices that only contain the words mean or std 
+ Create data set with only mean and standard deviation for each measurement
+ Change column names

* Uses descriptive activity names to name the activities in the data set
+ Read the activity labels text file
+ Use descriptive variable names

* Appropriately labels the data set with descriptive variable name
+ Bind all 3 datasets: Subject, Labels, Training/Test 
+ Use descriptive variable names: remove any parentheses, underscores, etc. and transform all variable names into lowercase
+ Replace the activity code by the activity name/description


* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The output file is `tidyData.txt`
The tidy data set is 180x81 because there are 30 subjects and 6 activities.

# Set working directory
setwd("C:\\Users\\Olivia\\OneDrive\\Documents\\Coursera_GettingandCleaningData\\ClassProject")

library(dplyr)
library(plyr)

# -----------------------------------------------------------------------------------------
# 1.Merges the training and the test sets to create one data set.
# -----------------------------------------------------------------------------------------

# Read training set
TrainingSet <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
# Read test set
TestSet <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
# Merging both sets into one data set
MergedDS <- rbind(TrainingSet,TestSet)

# Read training labels
TrainLabels <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")
# Read test labels
TestLabels <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
# Merging labels
MergedLabels <- rbind(TrainLabels,TestLabels)

# Read training subjects
TrainSubjects <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")
# Read test subjects
TestSubjects <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
# Merging subjects
MergedSubjects <- rbind(TrainSubjects,TestSubjects)

# -----------------------------------------------------------------------------------------
# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
# -----------------------------------------------------------------------------------------

# Read the features textfile
Features <- read.table(".\\UCI HAR Dataset\\features.txt")
# Identify column indices that only contain the words mean or std 
mean_std_indices <- grep(".*mean.*|.*std.*", Features[,2])
#mean_std_indices <- grep("-mean\\(\\)|-std\\(\\)", Features[,2])
# Create data set with only mean and standard deviation for each measurement
mean_std_MergedDS <- MergedDS[,mean_std_indices]
# Change column names
names(mean_std_MergedDS) <- Features[mean_std_indices,2]

# -----------------------------------------------------------------------------------------
# 3.Uses descriptive activity names to name the activities in the data set.
# -----------------------------------------------------------------------------------------

# Read the activity labels text file
ActivityDT <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")
# Use descriptive variable names
ActivityDT[, 2] = gsub("_", "", tolower(as.character(ActivityDT[, 2])))
names(ActivityDT) <- c("activitycode","activitydescription")
# Merge both 
FullActivityDT <- merge(mean_std_FullDS, ActivityDT, all = TRUE, by = c("ActivityCode"))

# -----------------------------------------------------------------------------------------
# 4.Appropriately labels the data set with descriptive variable names. 
# -----------------------------------------------------------------------------------------

# Bind datasets
mean_std_FullDS <- cbind(MergedSubjects,MergedLabels,mean_std_MergedDS)
# Use descriptive variable names
names(mean_std_MergedDS) <- gsub("\\(|\\)", "", names(mean_std_MergedDS))
names(mean_std_MergedDS) <- gsub("-", "", names(mean_std_MergedDS))
names(mean_std_MergedDS) <- tolower(names(mean_std_MergedDS))
names(mean_std_FullDS) <- c("subjects","activity",names(mean_std_MergedDS))
# Replace the activity code by the activity name/description
mean_std_FullDS[,2] = ActivityDT[mean_std_FullDS[,2], 2]

# -----------------------------------------------------------------------------------------
# 5.From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.
# -----------------------------------------------------------------------------------------

mean_std_TidyDS <- ddply(mean_std_FullDS, .(subjects,activity), numcolwise(mean))
write.table(mean_std_TidyDS, "tidyData.txt", row.names = FALSE, quote = FALSE)


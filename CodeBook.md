# CodeBook for Getting and Cleaning Data Course Project

This is the repository as required in the submission instructions of the Course Project for the Getting and Cleaning Data course at Coursera.

## Data
The full description of the data can be found at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The complete data can be found at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### 1. Merge the training and the test sets to create one data set.
The following data is loaded and merged:
- activity_labels.txt
- features.txt
- subject_train.txt
- subject_test.txt
- X_train.txt
- Y_train.txt
- X_test.txt
- Y_test.txt

### 2. Extract only the measurements on the mean and standard deviation for each measurement. 
The measurements for mean and stdev(and meanFreq, just in case) are extracted by subsetting only the required data from the complete.

### 3. Use descriptive activity names to name the activities in the data set
### &
### 4. Appropriately label the data set with descriptive activity names.
Descriptive activity names are used from "activity_labels.txt" in order to name the activities in the dataset. The column names in the dataset 'merge_data' are appropriately labeled as: "subject", "activity" and the features of the activities stored in "req_features.names".

### 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
The variables, 'subject' and 'activity' are turned into factor variables. This is done so that 'melt' and 'dcast' functions can be applied to 'merge_data' before creating a tidy dataset file('tidyDataset.txt).
Following the instructions, a data set by the name of 'tidyDataset.txt' is created which is an independent tidy data set with the average of each variable for each activity and each subject.
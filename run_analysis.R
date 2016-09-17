#The following R script "run_analysis.R" doe the following:

#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement.
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names.
#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(reshape2)

file <- "UCI_HAR_Dataset.zip"

# The following code downloads the dataset and unzips it:

if (!file.exists(file)){
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
      download.file(fileURL, file)
}  
if (!file.exists("UCI_HAR_Dataset")) { 
      unzip(file) 
}

# The following code loads "activity_labels.txt" and "features.txt":

activity_labels <- read.table("UCI_HAR_Dataset/activity_labels.txt")
activity_labels[,2] <- as.character(activity_labels[,2])
features <- read.table("UCI_HAR_Dataset/features.txt")
features[,2] <- as.character(features[,2])

# The following code extracts the required data, as asked for in the instructions(mean and standard deviation):
# (The code also extracts meanFreq())
req_features <- grep(".*mean.*|.*std.*|.*meanFreq.*", features[,2])
req_features.names <- features[req_features,2]
req_features.names <- gsub('-mean', 'Mean', req_features.names)
req_features.names <- gsub('-std', 'StdDev', req_features.names)
req_features.names <- gsub('-meanFreq', 'MeanFreq', req_features.names)
req_features.names <- gsub('[-()]', '', req_features.names)

# The following code loads the datasets from train folder:

train <- read.table("UCI_HAR_Dataset/train/X_train.txt")[req_features]
Y_train <- read.table("UCI_HAR_Dataset/train/Y_train.txt")
subject_train <- read.table("UCI_HAR_Dataset/train/subject_train.txt")
train <- cbind(subject_train, Y_train, train)

# The following code loads the datasets from test folder:

test <- read.table("UCI_HAR_Dataset/test/X_test.txt")[req_features]
Y_test <- read.table("UCI_HAR_Dataset/test/Y_test.txt")
subject_test <- read.table("UCI_HAR_Dataset/test/subject_test.txt")
test <- cbind(subject_test, Y_test, test)

# The following code merges the above datasets and adds appropriate labels:

merge_data <- rbind(train, test)
colnames(merge_data) <- c("subject", "activity", req_features.names)

# The following code turns activities and subjects into factors:

merge_data$activity <- factor(merge_data$activity, levels = activity_labels[,1], labels = activity_labels[,2])
merge_data$subject <- as.factor(merge_data$subject)
merge_data.melted <- melt(merge_data, id = c("subject", "activity"))
merge_data.mean <- dcast(merge_data.melted, subject + activity ~ variable, mean)

# The following code creates a file called "tidyDataset.txt" which contains the tidy data set:
write.table(merge_data.mean, "tidyDataset.txt", row.names = FALSE, quote = FALSE)
# Chris Kerrigan
# Course 3 Week 4 Assignment

library(dplyr)

# Read in the features, which will be used as column headers for the train and test data sets
features <- read.table("C:/Users/ckerriga/Documents/Coursera/UCI HAR Dataset/UCI HAR Dataset/features.txt", header = FALSE)

# prepare the train data set by reading it in, then adding on the activity label and subject fields
train_labels <- read.table("C:/Users/ckerriga/Documents/Coursera/UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", header = FALSE)
names(train_labels) <- "activity_label"
subject_train <- read.table("C:/Users/ckerriga/Documents/Coursera/UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
names(subject_train) <- "subject"
train <- read.table("C:/Users/ckerriga/Documents/Coursera/UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", header = FALSE, col.names = features$V2)
train <- cbind(subject_train, train_labels, train)

# prepare the test data set by reading it in, then adding on the activity label and subject fields
test_labels <- read.table("C:/Users/ckerriga/Documents/Coursera/UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", header = FALSE)
names(test_labels) <- "activity_label"
subject_test <- read.table("C:/Users/ckerriga/Documents/Coursera/UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
names(subject_test) <- "subject"
test <- read.table("C:/Users/ckerriga/Documents/Coursera/UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", header = FALSE, col.names = features$V2)
test <- cbind(subject_test, test_labels, test)

# Step 1: join the test and train data sets 
merge <- rbind(train, test)

# Step 2: Limit that data set by only including the subject id, the activity labels, and measurements on the 
# mean and standard deviation
meanMeasurements <- names(merge)[grep(".*[Mm]ean.*", names(merge))]
stdDevMeasurements <- names(merge)[grep(".*[Ss]td.*", names(merge))]
data <- merge[,c("subject", "activity_label", meanMeasurements,stdDevMeasurements)]

# Step 3: Use activity names to rename the activities in the data set
activity_labels <- read.table("C:/Users/ckerriga/Documents/Coursera/UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", header = FALSE)
activity_labels$V2 <- as.character(activity_labels$V2)
names(activity_labels) <- c("id", "activity_labels")

data1 <- merge(data, activity_labels, by.x = "activity_label", by.y = "id", all.x = TRUE)
data2 <- select(data1, c(2, ncol(data1), 3:(ncol(data1)-1)))

# Convert the first to columns to factors because we will be group_by those fields for step 5
data2$subject <- as.factor(data2$subject)
data2$activity_labels <- as.factor(data2$activity_labels)

# Step 4: give the variables descriptive names. Column names were intentionally left as they were in the
# source data set. See CodeBook.md for variable name explanations

# Step 5: create a seperate tidy data set with the average of each variable for each subject and each activity
tidy <- aggregate(data2, by = list(data2$subject, data2$activity_labels), FUN = mean, na.rm = TRUE)
tidy <- select(tidy, -c(subject, activity_labels))
names(tidy)[1] <- 'subject'
names(tidy)[2] <- 'activity'

# Write out the tidy data set
print(tidy)
write.table(tidy, file = "C:/Users/ckerriga/Documents/Coursera/tidy_data_C3W4.txt", row.names = FALSE)

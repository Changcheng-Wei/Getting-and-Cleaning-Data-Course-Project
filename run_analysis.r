# run_analysis.R
# for Coursera - JHU / Getting and Cleaning Data
if (!require("plyr")) {
  install.packages("plyr")
}
require("plyr") # Load the plyr package

# Read raw data from files
features = read.table('./UCI HAR Dataset/features.txt',header=FALSE)[,2] # Read the features
activity_labels = read.table('./UCI HAR Dataset/activity_labels.txt',header=FALSE)[,2] # Read the activity labels
# Read the test data
subject_test = read.table('./UCI HAR Dataset/test/subject_test.txt',header=FALSE) # Read the subject test data
x_test = read.table('./UCI HAR Dataset/test/X_test.txt',header=FALSE) # Read the test data
y_test = read.table('./UCI HAR Dataset/test/y_test.txt',header=FALSE) # Read the activity test data
# Read the train data
subject_train = read.table('./UCI HAR Dataset/train/subject_train.txt',header=FALSE) # Read the subject train data
x_train = read.table('./UCI HAR Dataset/train/X_train.txt',header=FALSE) # Read the train data
y_train = read.table('./UCI HAR Dataset/train/y_train.txt',header=FALSE) # Read the activity train data
# Merge the training and the test sets to create one data set
x = rbind(x_train, x_test) # Merge the train and test data
y = rbind(y_train, y_test) # Merge the train and test activity data
subject = rbind(subject_train, subject_test) # Merge the train and test subject data
# Set the column names
colnames(x) = features # Set the column names for the data
colnames(y) = "activity" # Set the column name for the activity data
colnames(subject) = "subject" # Set the column name for the subject data
# Merge all data into one data set
data = cbind(subject, y) # Combine subject and activity data
data = cbind(data, x) # Combine all data
# Extract only the measurements on the mean and standard deviation for each measurement
# Get the column names that contain mean and std
mean_and_std = grep(".*mean.*|.*std.*", features) # Get the column names that contain mean and std
# Get the column names that contain mean and std
mean_and_std = c(1, 2, mean_and_std + 2) # Add the subject and activity columns to the mean and std columns
# Create a new data set with only the mean and std columns
data = data[, mean_and_std] # Subset the data to only include the mean and std columns
# Use descriptive activity names to name the activities in the data set
data$activity = factor(data$activity, labels = activity_labels) # Convert the activity column to a factor with descriptive names
# Appropriately label the data set with descriptive variable names
names(data) = gsub("^t", "time", names(data)) # Replace t with time
names(data) = gsub("^f", "frequency", names(data)) # Replace f with frequency
names(data) = gsub("Acc", "Accelerometer", names(data)) # Replace Acc with Accelerometer
names(data) = gsub("Gyro", "Gyroscope", names(data)) # Replace Gyro with Gyroscope
names(data) = gsub("Mag", "Magnitude", names(data)) # Replace Mag with Magnitude
names(data) = gsub("BodyBody", "Body", names(data)) # Replace BodyBody with Body
names(data) = gsub("mean", "Mean", names(data)) # Replace mean with Mean
names(data) = gsub("std", "StandardDeviation", names(data)) # Replace std with StandardDeviation
names(data) = gsub("angle", "Angle", names(data)) # Replace angle with Angle
names(data) = gsub("gravity", "Gravity", names(data)) # Replace gravity with Gravity
# Create a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data = aggregate(. ~ subject + activity, data, mean) # Aggregate the data by subject and activity
tidy_data = tidy_data[order(tidy_data$subject, tidy_data$activity), ] # Order the data by subject and activity

# Print the first few rows of the tidy data set
head(tidy_data) # Print the first few rows of the tidy data set
# Print the dimensions of the tidy data set
dim(tidy_data) # Print the dimensions of the tidy data set
# Print the column names of the tidy data set
colnames(tidy_data) # Print the column names of the tidy data set
# Print the structure of the tidy data set
str(tidy_data) # Print the structure of the tidy data set
# Print the summary of the tidy data set
summary(tidy_data) # Print the summary of the tidy data set
# Print the class of the tidy data set
class(tidy_data) # Print the class of the tidy data set
# Print the head of the tidy data set
head(tidy_data) # Print the head of the tidy data set
# Print the tail of the tidy data set
tail(tidy_data) # Print the tail of the tidy data set
# Write the tidy data set to a file
write.table(tidy_data, file = "tidy_data.txt", row.name = FALSE) # Write the tidy data set to a file

#Coursera Instruction
# Getting-and-Cleaning-Data-Course-Project

Data

The dataset being used is: Human Activity Recognition Using Smartphones

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The Raw Data can be found at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

run_analysis.R

the run_analysis.R script does the following:

•	Checks for plyr package, installs if not there.

•	Loads the features and activity_labels into R

•	Loads raw data into R

•	Merges the data into 3 logical subsets: subjects, x and y

•	Extracts mean / std from the "features.txt" file

•	Initial header name cleaning

•	Bind all into a single data set

•	Create new tidy data set with avgs of columns grouped by subject / activity fields

•	Check the tidy data set

•	Export final dataset as "tidy_data.txt"

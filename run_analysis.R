## Filename: run_analysis.R
## Author: Reinald Kim T. Amplayo
## Last Modified: 6/23/2014

## This file contains two functions that transforms the UCI HAR Dataset available in this website
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## into two datasets.

## get_data is a function that transforms the UCI HAR Dataset into a single R data.frame.
## The UCI HAR Dataset folder must be at the same location as this file. It will only include the
## subject number, the mean and the standard deviation of the features, and the activity.
get_data = function() {
	## read all necessary text files
	## test data
	x_test = read.table("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
	y_test = read.table("UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
	subj_test = read.table("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
	## training data
	x_train = read.table("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
	y_train = read.table("UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
	subj_train = read.table("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
	## others
	activity = read.table("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
	features = read.table("UCI HAR Dataset/features.txt", sep="", header=FALSE)

	## get only feature names that contains "mean()" or "std()"
	features = subset(features, grepl("mean\\(\\)", as.character(V2)) | grepl("std()", as.character(V2)))

	## convert the "activity number" into the "activity name"
	y_test = data.frame(apply(y_test, 1, function(x) activity[x,2]))
	y_train = data.frame(apply(y_train, 1, function(x) activity[x,2]))

	## include only columns with feature names containing "mean()" or "std()"
	colnames(x_test) = 1:561
	colnames(x_train) = 1:561
	x_test = x_test[features[1][,]]
	x_train = x_train[features[1][,]]

	## change the column names to ensure that the train and test files have the same column names
	colnames(x_test) = features[2][,]
	colnames(x_train) = features[2][,]
	colnames(y_test) = "activity"
	colnames(y_train) = "activity"
	colnames(subj_test) = "subjectNo"
	colnames(subj_train) = "subjectNo"

	## merge two datasets
	x = rbind(x_test, x_train)
	y = rbind(y_test, y_train)
	subj = rbind(subj_test, subj_train)
	data = data.frame(subj, x, y)
	colnames(data) = c("subjectNo", as.character(features[2][,]), "activity")
	data
}

## tidy_data is a function that uses the output of get_data and creates a tidy data set
## with the average of each variable for each activity and each subject. This uses the
## melt and cast functions from the package "reshape".
tidy_data = function() {
	## get dataset
	data = get_data()

	## melt-cast
	melted_data = melt(data, id=c("subjectNo", "activity"))
	tidy = cast(melted_data, subjectNo+activity~variable, mean)

	## append "_average" to all the column names except the first two
	colnames(tidy) = c(colnames(tidy)[1:2], paste(colnames(tidy)[3:68], "_average", sep=""))
	tidy
}

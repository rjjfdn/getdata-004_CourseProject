Coursera - Getting and Cleaning Data Course Project by Reinald Kim T. Amplayo
==================================================================

The main task of this course project is to transform the UCI HAR
Dataset available here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

into a tidy version of the dataset which contains the subject
number, the activity, and the average of all the other features.

Requirements (aside from R):
============================================

- reshape package
- the unzipped dataset on the same folder as the script

The repository includes the following files:
============================================

- "README.md"
- "CodeBook.md": Describes the variables, the data, and any 
		transformations or work that was performed
		to clean up the data
- "run_analysis.R": R script which contains the functions to
		be used to do the task
- "data.txt": The comma-separated output of the R script

The run_analysis.R
============================================

1. Read all necessary files
2. Get only feature names that contains "mean()" or "std()"
3. Convert the "activity number" into the "activity name"
4. Include only columns with feature names containing "mean()" or "std()"
5. Change the column names to ensure that the train and test files have the same column names
6. Merge the train and test datasets
7. Merge all columns
8. Melt-Cast all variables except subjectNo and activity by their mean
9. Append "_average" to all the column names except the first two

How to use the script
============================================

1. source("run_analysis.R")
2. data = tidy_data()

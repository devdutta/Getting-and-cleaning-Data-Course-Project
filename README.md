# Readme File for run_analysis.R

The run_analysis.R script does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity
   and each subject. 
## Assumptions

Some assumptions if you are running this R Script
1. This directory is already present --> "UCI HAR Dataset"
2. The relevant data files are also present within this directory
3. Expecting that the "reshpae", "reshape2" package and the plyr package is installed. 
4. If not, then you will have to install it before running this script

## Process Steps

1. Importing the Test Data
2. Import the training data
3. Merge the training and the test sets to create one data set
4. From the Merged data, extract only those measurements which contain the mean and standard deviation for each
   measurement
5. Use descriptive activity names to name the activities in the data set AND appropriately label the data set with descriptive variable names
6. Read in the Activity Labels file
7. Include the Activity Names as a column in the main data frame
8. Including the Subject ID's as a column in the main data frame
9. Now the main data frame contains the following:
    a) 1st Column ----> Subject ID's
    b) 2nd Column ----> Activity Names
    c) Remaining 81 columns ----> all measures containing mean or std deviation values
10. creates an independent tidy data set with the average of each variable for each activity and
    each subject
11. Create an output file for writing out the tidy data output

## Cleaned Data

The name of the resulting clean dataset is: `tidy_data.txt`. It contains one row for each subject/activity pair and columns for subject, activity, and each feature that was a mean or standard deviation from the original dataset.


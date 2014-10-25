## This is the submission for the Course Project for Coursera- Getting 
## and Cleaning Data

## This Project is based on the Human Activity Recognition Using Smartphones Data Set 

## This particular R Script does the following tasks:
##    1) Merges the training and the test sets to create one data set.
##    2) Extracts only the measurements on the mean and standard deviation
##       for each measurement. 
##    3) Uses descriptive activity names to name the activities in the data set
##    4) Appropriately labels the data set with descriptive variable names. 
##    5) From the data set in step 4, creates a second, independent tidy data set 
##       with the average of each variable for each activity and each subject

## Some assumptions if you are running this R Script

##    1) This directory is already present --> "UCI HAR Dataset"
##    2) All the relevant data files are also present within this directory
##    3) Expecting that the "reshpae" package and the plyr package is installed. 
##    4) If not, then you will have to install it before running this script

run_analysis <- function() {
  
  ## Since we will be using the reshape and plyr package, invoking them first
  
  library(reshape)
  library(plyr)
  
  ## Importing the Test Data
  
  X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
  Y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
  subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
  
  ## Import the training data
  
  X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
  Y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
  subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
  
  ## Step 1: Merges the training and the test sets to create one data set
  
  ## Merge the X data, Y data and Subject data from the test and train sets
  X_Merged<-rbind(X_test, X_train)
  Y_Merged<-rbind(Y_test, Y_train)
  subject<-rbind(subject_test, subject_train)
  
  ## The column names are available in the features data
  ## Importing the features data and binding it with X_Merged
  ## This will ensure the X_Merged has the proper column names (instead of V1, V2 etc)
  
  features_names <- read.table("./UCI HAR Dataset/features.txt")
  colnames(X_Merged) <-features_names[,2]
  
  ## Step 2) From the X_Merged data, extract only those measurements 
  ## which contain the mean and standard deviation for each measurement
  
  ## Using grepl, we find out those measurements which have the texts
  ## mean() or std() and using these we create a vector list called selmeasures
  
  selmeasures<- grepl("mean()",colnames(X_Merged)) | grepl("std()",colnames(X_Merged))
  
  ## Using this vector list, we subset the X_Merged Dataframe so that it only contains
  ## measures which are either have the string mean() or std(). We name this 
  ## subsetted dataframe as Mean_Std_Measures
  
  Mean_Std_Measures <- X_Merged[,selmeasures]
  
  ## Step 3 & 4: Uses descriptive activity names to name the activities in the 
  ## data set AND Appropriately labels the data set with descriptive variable names
  
  ## The activity labels are already present in a file called activity_labels
  
  ## Reading in the Activity Labels file
  
  activity_labels <-read.table("./UCI HAR Dataset/activity_labels.txt")
  
  ## Converting the Y_Merged into factors
  
  Y_factor <- as.factor(Y_Merged[,1])
  
  ## Using the mapvalues function (from plyr package) to convert the Y_factors into
  ## Activity_Names
  
  Activity_Names <- mapvalues(Y_factor,from = as.character(activity_labels[,1]), to = as.character(activity_labels[,2]))
  
  ## Including the Activity_Names as a column in the Mean_Std_Measures data frame
  
  Mean_Std_Measures <- cbind(Activity_Names, Mean_Std_Measures)  
  
  ## Also including the Subject ID's in the Mean_Std_Measures Dataframe
  
  Mean_Std_Measures <- cbind(subject, Mean_Std_Measures)
  
  ## Renaming column 1 as subject
  
  colnames(Mean_Std_Measures)[1] <- "subject"
  
  ## So the Mean_Std_Measures dataframe has the following:
  
  ## 1st Column ----> Subject ID's
  ## 2nd Column ----> Activity Names
  ## Remaining columns ----> all measures containing mean or std deviation values
  
  ## Step 5: creates a second, independent tidy data set 
  ##         with the average of each variable for each activity and each subject
  
  ## So the new tidy dataset should have all the Subject ID's, grouped by the activity names
  ## like Walking, Walking_Upstairs etc followed by the average value of all the measures
  
  ## To do this we will use the reshape library, specifically using the melt and recast functions
  
  melt_stage <- melt(Mean_Std_Measures,id.vars=c("subject","Activity_Names"))
  tidy_data <- dcast(melt_stage, subject + Activity_Names ~ variable, mean)
  
  ## Create an output file for writing out the tidy_data output
  
  clean_data <- "tidy_data.txt"
  
  ## Writing out the tidy data into the file
  
  write.table(tidy_data, clean_data, row.names = FALSE, quote = FALSE)
  
}
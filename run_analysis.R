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
##    3) Expecting that the "reshpae" package is installed. If not, then you will have to install it before
##    4) running this script

run_analysis <- function() {
  
    
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
  subject_Merged<-rbind(subject_test, subject_train)
  
  ## The column names are available in the features data
  ## Importing the features data and binding it with X_Merged
  ## This will ensure the X_Merged has the proper column names (instead of V1, V2 etc)
  
  features_names<- read.table("./UCI HAR Dataset/features.txt")
  colnames(X_Merged)<-features_names[,2]
  
}
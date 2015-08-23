#------------------------------------------------------------------------------
#                             run_analysis.R script
#
# Steps undertaken in the script:
# 1) Merging datasets

#------------------------------------------------------------------------------



## navigating to the appropriate data folder
setwd("./UCI HAR Dataset")


#------------------------------------------------------------------------------
## Step-1: Merging training and test datasets

### loading and saving data from train and test subfolders
subject_train<-read.table("./train/subject_train.txt", stringsAsFactors = FALSE)
subject_test<-read.table("./test/subject_test.txt", stringsAsFactors = FALSE)

X_train<-read.table("./train/X_train.txt", stringsAsFactors = FALSE)
X_test<-read.table("./test/X_test.txt", stringsAsFactors = FALSE)

y_train<-read.table("./train/y_train.txt", stringsAsFactors = FALSE)
y_test<-read.table("./test/y_test.txt", stringsAsFactors = FALSE)

### row binding the training and test datasets
X_joint<-rbind(X_train, X_test)
y_joint<-rbind(y_train, y_test)
subject_joint<-rbind(subject_train, subject_test)


#------------------------------------------------------------------------------
## Step-2: Loading features.txt and extracting mean and SD data. 

### loading features.txt and removing cleaning the variable names
featureNames<-read.table("features.txt",stringsAsFactors = FALSE)
#### removing the parentheis from the names
cleanFeatureNames<-gsub("\\(\\)","" ,featureNames[,2])
#### removing single parenthesis by adding | between the two arguements
cleanFeatureNames<-gsub("\\(|\\)","",cleanFeatureNames)
#### removing commas
cleanFeatureNames<-gsub(",","",cleanFeatureNames)

### associating the cleanedFeatureNames as column names for X_joint data frame
colnames(X_joint)<- cleanFeatureNames

### subsetting only columns with mean and std from X_joint 
desiredColumns<-grep("mean|std",colnames(X_joint),ignore.case=TRUE)
X_desired<-X_joint[,desiredColumns]
#------------------------------------------------------------------------------
#                             run_analysis.R script
#
# Steps undertaken in the script:
# 1) Merging datasets

#------------------------------------------------------------------------------

## setting the main working directory
setwd("/Users/karan/Box Sync/Coursera-DSS/03_GetData/week3_project/cousera_get-n-clean-data_project")

## navigating to the appropriate data folder
setwd("./UCI HAR Dataset")


#------------------------------------------------------------------------------
## Step-1: Merging training and test datasets

### loading and saving data from train and test subfolders
subject_train <- read.table("./train/subject_train.txt", stringsAsFactors = FALSE)
subject_test <- read.table("./test/subject_test.txt", stringsAsFactors = FALSE)

X_train <- read.table("./train/X_train.txt", stringsAsFactors = FALSE)
X_test <- read.table("./test/X_test.txt", stringsAsFactors = FALSE)

y_train <- read.table("./train/y_train.txt", stringsAsFactors = FALSE)
y_test <- read.table("./test/y_test.txt", stringsAsFactors = FALSE)

### row binding the training and test datasets
X_joint <- rbind(X_train, X_test)
y_joint <- rbind(y_train, y_test)
subject_joint <- rbind(subject_train, subject_test)


#------------------------------------------------------------------------------
## Step-2: Loading features.txt and extracting mean and SD data. 

### loading features.txt and saving it as a data frame
feature_names <- read.table("features.txt",stringsAsFactors = FALSE)
### associating the feature_names data frame (df) as column names for X_joint df
colnames(X_joint) <- feature_names[,2]
### subsetting columns that contain "mean()" and "std()" strings in their name
desiredColumns<-grep("mean|std\\(\\)", colnames(X_joint),ignore.case = FALSE) #check README
X_desired<-X_joint[,desiredColumns] #the subsetted data frame


#------------------------------------------------------------------------------
## Step-3: Descriptive activity names to name the activities in the data set

#### removing the parentheis from the names
cleanFeatureNames<-gsub("\\(\\)","" ,featureNames[,2])
#### removing single parenthesis by adding | between the two arguements
cleanFeatureNames<-gsub("\\(|\\)","",cleanFeatureNames)
#### removing commas
cleanFeatureNames<-gsub(",","",cleanFeatureNames)

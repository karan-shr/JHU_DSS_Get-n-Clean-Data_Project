#------------------------------------------------------------------------------
#                             run_analysis.R script
#------------------------------------------------------------------------------

## setting the main working directory
setwd("/Users/karan/Box Sync/Coursera-DSS/03_GetData/week3_project/cousera_get-n-clean-data_project")

## navigating to the appropriate data folder
setwd("./UCI HAR Dataset")

## loading the data.table library
library(data.table)


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

### loading activity_labels.txt and making a new data frame
activity_labels <- read.table("activity_labels.txt")
### giving names to the columns
colnames(activity_labels) <- c("activity_no","activity_label")
### creating a new data frame (based on y_joint) based on the activity_label
y_labels <- activity_labels$activity_label[match(y_joint[,1],activity_labels$activity_no)]
y_desired <- cbind(y_labels,y_joint)
### naming the columns of the y_desired data frame
colnames(y_desired) <- c("activity_label","activity_no")


#------------------------------------------------------------------------------
## Step-4: Labelling the data and merging it into a single dataset

### subject_joint
colnames(subject_joint) <- "subject_no"

### merging the data into a dataset
data_combined <- cbind(subject_joint,y_desired,X_desired)


#------------------------------------------------------------------------------
## Step-5: Creating a tidy data set with the average of each variable for each 
## activity and each subject.

### converting the data_combined df into a data table.
setDT(data_combined)

### ordering the data in the data table based on the subject no. and then by activity no
data_combined <- data_combined[order(subject_no,activity_no)]

### making a new dataset by calculating means per subject_no and activity_label
tidy_data <- data_combined[, lapply(.SD,mean), by=.(subject_no,activity_label)]

### saving the tidy data set
write.table(tidy_data, "tidy.txt", row.names = FALSE, quote = FALSE)
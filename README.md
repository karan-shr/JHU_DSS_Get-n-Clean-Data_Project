# Getting and Cleaning Data Course Project

**About**:
This repository contains code and documentation submitted for evaluation to Coursera (and John Hopkins) Getting and Cleaning Data course.

**Author**:
Karan Sharma


### Note: Commenting scheme followed in the code:
- the no of **#** before a comment are inversaly related to that comment's importance. In same fashion like github markdown, # signifies the highest level of odering and ## e.g. signifies the next level of ordering. So in short, # signifies the main section and ## signifies a subsection...so on and so forth... 
- a gap between two # e.g."# #" signifies commented out code. 
- the hastag (#) followed by '---' is used to separate the script into different regions.



##Data Analysis Procedure:



### Pre-analysis steps:
1. Download and unzip the data folder (UCI HAR Dataset) associated with the assignment.

2. A Git repository is setup on github and is then locally cloned for working with the data.

3. README.md markdown file is created to document the steps undertaken during the data analysis.



### run_analysis.R: 
is a R script to collect, work with, and clean a data set. The basic description of the program flow is presented as follows:

1. The script first sets the working directory to the required data folder.

2. Merging training and test datasets:
  1. The *X, y* and *subject* data (text) files from **train** and **test** folders are loaded into and stored as data frames in R.
  2. Data frames *subject_joint, X_joint* and *y_joint* are created by row binding the test and train data files.

3. Loading and extracting the required (mean and SD data) using features.txt:
  1. Load *features.txt* into R and save it as *feature_names* data frame.

  2. Associate the rows from *feature_names* as the column names for the *X_joint* data frame.

  3. **Which features to extract**:
    1. The included file *features_info.txt* provides a summary of the feauture names and thier nature. According to this file "mean()" and "std()" provide the mean and standard deviation values. Also "meanFreq()" is also a mean freuquency value. However, values such as "gravityMean" are averages in a signal window sample. 
    2. Since this part of assignment i.e. choosing which values to extract is an open question [check forums]  (https://class.coursera.org/getdata-031/forum/thread?thread_id=28). I've decided to include features containing the "mean" string and none that have the string "Mean" e.g. "gravityMean" in their name. This gives me all features named having "mean()" "meanFreq()".
    3. For standard deviation, all variables with the string "std()" are extracted.

  4. The *grep* command is used to extract only the desired (i.e. mean and std) data from the *X_joint* data frame.


4. Descriptive activity names to name the activities in the data set:
  1. Load *activity_labels.txt* into R and as *activity_labels* data frame.
  
  2. The labels in this data frame correspond to the activity mentioned in the *y_joint* data frame.
  
  3. By using the *match* function a new variable *y_labels* which correponds the activity numbers (i.e. 1,2,3 etc.) with the activity labels is created. 
  
  4. A data frame *y_desired* is created by binding the *y_labels* and the *y_joint* variables.
  
  
5. Labelling the data set with descriptive variable names and merging the dataset:
    1. The dataframes *X_desired* and *y_desired* already have the appropriate column names. Other column names are given in this section:
    2. The data frame *subject_joint* has only 1 column, it's named as *subject_no*
    3. Other data frames which are not required for further analyses steps are not given names.
    4. The data is merged into a single dataset(*data_combined*), in the following order: *subject_joint*,*y_desired* and *X_desired*. 
    
6. Making the tidy data set and saving it as tidy.txt
  1. The *data_combined* data frame is converted into a data.table.
  2. The data table is then ordered firstly by the *subject_no* variable and then by the *activity_no* variable.
  3. Using the powerful subseeting features of the data.table program a tidy data set is created in one statement and saved as a new data table called *tidy_data*.
  4. The *tidy_data* is saved to a txt file.
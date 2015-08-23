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

3. Loading, cleaning and extracting the required (mean and SD data) using features.txt:
  1. Load *features.txt* into R.
  2. Remove round brackets and commas from feature names to simplify feature names.
  3. Associate cleaned feature names with the *X_joint* data frame. 
  4. Using *grep* command to extract only the desired (i.e. mean and std) data from the *X_joint* data frame.
  

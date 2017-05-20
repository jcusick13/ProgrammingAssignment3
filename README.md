# ProgrammingAssignment3

Contains the peer-graded assignment for Coursera's Getting and Cleaning Data class.

The main script of this assignment, run_analysis.R, assumes that it will be run in
the same local directory as the UCI HAR Dataset, which can be downloaded from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The script organizes and cleans the data from both the train and test datasets into
a single tidy data table. It also creates an independent summary table of selected
variables.

# Repo Contents
- code_book.txt: Contains a description of the variables included in the analysis

- run_analysis.R: Script for cleaning and processing the data

- summary_data.txt: Contains the mean value for selected variables, grouped by both subject ID and subject activity

# Methodology
The R file first combines the train and test datasets provided from the UCI HAR Dataset. This results in a single
data frame which includes the subject ID, the activity classification, and input variables used to arrive at the activity
classification.

This analysis is only interested in input variables summarized by mean and standard deviation. The script
therefore reads in the list of all input variable names and uses a regular expression to select 
only those variables of interest. The main data frame is then subsetted using these variables of interest.

Next, the text file which maps activity code to a textual activity description is used to create 
readable activity variables (i.e. WALKING instead of 1).

Now that the data frame is organized, the main objective can be acheived. Two functions from the 
dplyr package (group_by and summarize) are chained together to create the final output table, 
summary_data.txt.


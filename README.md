The data for the project can be downloaded from the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This data represents data collected from the accelerometers from the Samsung Galaxy S smartphone.
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The run_analysis.R script produces a tidy dataset from this data that shows the average of each variable for each activity and each subject.

The steps invloved are as follows:
==================================

- Merging of test and train datasets of variables.
- Melting the merged datasets of variables and then mutating them as columns to form one dataset.
- Gathering all the variable columns into one 'variable' column.
- Grouping the dataset by subject, activity, and variable.
- Summarizing the dataset to get the average of each variable.

===================================================================
			Getting and Cleaning Data Course Project
			Allen Askay
====================================================================
This project is based on data from the Human Activity Recognition 
Using Smartphones Dataset Version 1.0 by Jorge L. Reyes-Ortiz,
Davide Anguita, Alessandro Ghio, and Luca Oneto. A full description
can be found at the following site: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The R script run_analysis.R processes the data provided from the smartphone dataset
mentioned above and outputs a tidy dataset that contains the average of
each variable for each activity and each subject. The variables included
with this tidy dataset are in the file TidyData_Variables.txt. These variables
were formed by subsetting the original dataset keeping only the mean and standard 
deviation variables and then computing the average value of each of those variables
for each activity and subject.

See the CodeBook.md file for a description of the variables in the TidyDataSet.csv file.

For a further understanding of the variables in the original dataset, please see
the features_info.txt file that comes with the smartphone dataset. 
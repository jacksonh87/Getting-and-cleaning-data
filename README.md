# Getting and Cleaning Data Course Project

This repository contains the requirements for the Coursera Getting and Cleaning Data course, part of JHU Data Science Specialisation. The project concerns the tidying of a dataset on 'Human Activity Recognition Using Smartphones' from the UCI Machine Learning Repository.


The R script 'run_analysis.R' does the following:

1. Downloads the dataset if not already present, and unzips it
2. Reads the activity and features information
3. Generates a list of the features we are interested in for this assignment (means and standard deviations)
4. Pulls the features we are interested in from the 'train' data then the 'test' data
5. Combines the 'train' and 'test' data
6. Converts the 'Activity' and 'Subject' data into factors
7. Melts the data and recasts it, taking the mean of every measurement we are interested in for each of the 30 subjects and 6 activities (i.e. 6 x 30 = 180 rows of data)

The tidy data is written to 'tidy_data.txt'. To view it use:

    data <- read.table("tidy_data.txt", header = TRUE) 
    View(data)

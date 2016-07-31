#Add required packages to library
library(reshape2)

#Check whether the raw data has been downloaded or not
data_local <- "~/Coursera/Data Science JHU/003 Getting and Cleaning Data/Week 4 Course Project/data/rawdata.zip"
data_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists(data_local)){
  download.file(data_URL, data_local)
}

#Check whether the raw data has been unzipped and unzip if necessary
data_unzipped <- "~/Coursera/Data Science JHU/003 Getting and Cleaning Data/Week 4 Course Project/data/rawdata"
if(!dir.exists(data_unzipped)){
  dir.create(data_unzipped)
  unzip(data_local, exdir = data_unzipped)
}


   


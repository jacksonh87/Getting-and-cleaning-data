#Add required packages to library
library(reshape2)

#Check whether the raw data has been downloaded, and download it if necessary
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

#Read in the activity and features data
setwd(data_unzipped)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)   

#Look in the features and find names with only means but not meanFreqs
#We are only interested in mean values, not means of frequencies
features_means <- grep("*mean*", features[, 2])
features_meanFreqs <- grep("*meanFreq*", features[, 2])
features_means <- features_means[!(features_means %in% features_meanFreqs)]

#Look in the features and find names with standard deviations
features_stds <- grep("*std*", features[, 2])

#Combine the means and stds to get a full list of the features we want
features_wanted <- c(features_means, features_stds)
named_features_wanted <- features[features_wanted, 2]

#Read in the 'train' data, but only the features we are interested in
train <- read.table("UCI HAR Dataset/train/X_train.txt")[features_wanted]
train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

#Combine the activity and subject data in the main train dataset
train <- cbind(train_subjects, train_activities, train)

#Read in the 'test' data, but only the features we are interested in
test <- read.table("UCI HAR Dataset/test/X_test.txt")[features_wanted]
test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

#Combine the activity and subject data in the main test dataset
test <- cbind(test_subjects, test_activities, test)

#Combine the 'train' and 'test' datasets
combined <- rbind(test, train)
colnames(combined) <- c("Subject", "Activity", named_features_wanted)

#Run through the combined data and replace the activity number code with the actual activity,
#as a factor variable
combined$Activity <- factor(combined$Activity, levels = activity_labels[, 1], 
                            labels = activity_labels[, 2])

#Make sure that Subjects are treated as factors in the combined data so that it can be 
#melted properly
combined$Subject <- as.factor(combined$Subject)

#Melt the data so that it can be recast by Subject and Activity
combined_melted <- melt(combined, id = c("Subject", "Activity"))

#Recast the data and take the mean of each variable for each subject and activity
combined_mean <- dcast(combined_melted, Subject + Activity ~ variable, mean)

#Output the new tidy data set
setwd("~/Coursera/Data Science JHU/003 Getting and Cleaning Data/Week 4 Course Project/project/Getting-and-cleaning-data/")
write.table(combined_mean, "tidy_data.txt", row.names = FALSE, quote = FALSE)


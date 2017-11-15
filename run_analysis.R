require("dplyr")
require("plyr")

## Define the various input files.  This script assumes that there is a 
## folder called UCI HAR Dataset located in the working directory.
trainingDataFile <- 'UCI HAR Dataset/train/X_train.txt'
trainingLabelsFile <- 'UCI HAR Dataset/train/y_train.txt'
testDataFile <- 'UCI HAR Dataset/test/X_test.txt'
testLabelsFile <- 'UCI HAR Dataset/test/y_test.txt'
labelFile <- 'UCI HAR Dataset/features.txt'
activityLabelFile <- 'UCI HAR Dataset/activity_labels.txt'
subjectTrainingFile <- 'UCI HAR Dataset/train/subject_train.txt'
subjectTestFile <- 'UCI HAR Dataset/test/subject_test.txt'

# Read in the file that contains the column names (the features.txt file)
colLabels <- read.table(labelFile,sep = "",stringsAsFactors = FALSE)
colLabels <- colLabels[,2]

# Read in the training and test data files
#4 - Appropriately label the data set with descriptive variable names (using colLabels)
trainingdata <- read.table(trainingDataFile,sep = "",col.names = colLabels)
testdata <- read.table(testDataFile,sep = "",col.names = colLabels)

# Read in the the activity type id for each observation (the y_train and y_test files)
trainingLabelData <- read.table(trainingLabelsFile)
testLabelData <- read.table(testLabelsFile)

# Read in the test subjects for training and test (the subject_train and subject_test files)
trainingSubjects <- read.table(subjectTrainingFile)
testSubjects <- read.table(subjectTestFile)

# Add a column to the data frames that contain the activity type id
trainingdata$activity <- trainingLabelData[,1]
testdata$activity <- testLabelData[,1]

# Add a column to the data frames that contain the subject
trainingdata$subject <- trainingSubjects[,1]
testdata$subject <- testSubjects[,1]

# Read in the names of the activity types associated with the id's from above
activityLabelData <- read.table('UCI HAR Dataset/activity_labels.txt')
activityLabelData <- activityLabelData[,2]

#1 - Merge the training and the test sets to create one data set.
data <- rbind(trainingdata,testdata)

#2 - Extract only the measurements on the mean and standard deviation for each measurement.
data <- data %>% select(grep("mean",names(data)),grep("std",names(data)),activity,subject)

#3 Uses descriptive activity names to name the activities in the data set
data$activity[data$activity==1] <- as.character(activityLabelData[1])
data$activity[data$activity==2] <- as.character(activityLabelData[2])
data$activity[data$activity==3] <- as.character(activityLabelData[3])
data$activity[data$activity==4] <- as.character(activityLabelData[4])
data$activity[data$activity==5] <- as.character(activityLabelData[5])
data$activity[data$activity==6] <- as.character(activityLabelData[6])

#5 - From the data set in step 4, creates a second, independent tidy data set with the average
#    of each variable for each activity and each subject.
meanData <- data %>% group_by(subject,activity) %>% summarise_all(.funs = c(mean = "mean"))

#4 - Appropriately label the data set with descriptive variable names (using meanDataColumnNames)
meanDataColumnNames <- read.table('TidyData_Variables.txt',header = FALSE,stringsAsFactors = FALSE)
names(meanData) <- meanDataColumnNames[["V1"]]

# Write out the tidy data set to a csv file
write.csv(meanData, file='TidyDataSet.csv',row.names = FALSE)

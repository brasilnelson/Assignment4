### Pre Analysis###

if (!"dplyr" %in% installed.packages()) {
  install.packages("dplyr")
}
library("dplyr")

# Downloading the data

file <- "UCIdata.zip"
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"

# File download verification
if(!file.exists(file)){
  download.file(url,file, mode = "wb") 
}

# File unzip verification
if(!file.exists(dir)){
  unzip("UCIdata.zip", files = NULL, exdir=".")
}

# Read and load the data
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", sep="",row.names = NULL)
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", sep="")
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", sep="", row.names = NULL)
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", sep="")
features <- read.table("./UCI HAR Dataset/features.txt", sep="")
lbs <- read.table("./UCI HAR Dataset/activity_labels.txt", sep='')
subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep="")
subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep="")

### Merges the training and the test sets to create one data set ###

#merging xtrain and xtest
AllData <- rbind(xtrain, xtest)

#rename the columns
names(AllData) <- features$V2

### Extracts only the measurements on the mean and standard deviation
### for each measurement ###
featuresNames <- features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
name_cols <- as.character(featuresNames)
AllData <- AllData[,name_cols]

# merging also the ytrain, ytest and subject names
AllData$category <- rbind(ytrain, ytest)
AllData$subject <- rbind(subtrain, subtest)

### Uses descriptive activity names to name the activities in the data set ###
AllData$category <- lbs$V2[AllData$category[,]]

### Appropriately labels the data set with descriptive variable names ###

names(AllData) <- gsub("mean\\(\\)", "MEAN", names(AllData))
names(AllData) <- gsub("std\\(\\)", "STD", names(AllData))
names(AllData) <- gsub("^t", "Time", names(AllData))
names(AllData) <- gsub("^f", "Frequency", names(AllData))
names(AllData) <- gsub("Body", "", names(AllData))
names(AllData) <- gsub("Acc", "Accelerometer", names(AllData))
names(AllData) <- gsub("Gyro", "Gyroscope", names(AllData))
names(AllData) <- gsub("Mag", "Magnitude", names(AllData))
names(AllData) <- gsub("-MEAN-X", "-XAxisMEAN", names(AllData))
names(AllData) <- gsub("-MEAN-Y", "-YAxisMEAN", names(AllData))
names(AllData) <- gsub("-MEAN-Z", "-ZAxisMEAN", names(AllData))
names(AllData) <- gsub("-STD-X", "-XAxisSTD", names(AllData))
names(AllData) <- gsub("-STD-Y", "-YAxisSTD", names(AllData))
names(AllData) <- gsub("-STD-Z", "-ZAxisSTD", names(AllData))

### From the data set in step 4, creates a second, independent tidy data set
### with the average of each variable for each activity and each subject. ###
AllData <- as_tibble(AllData)
AllData <- AllData %>% group_by(subject, category)
tidy_data <- AllData %>% summarise_at(.vars = names(AllData[1:66]),.funs=mean)

View(tidy_data)

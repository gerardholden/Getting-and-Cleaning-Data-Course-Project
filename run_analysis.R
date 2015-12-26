# Getting and Cleaning Data
# Course Project

run_analysis <- function() {
    
    setwd("F:/Gerard/OneDrive/Documents/Education/Coursera - Data Science/3 Getting Data/project")

# Download dataset and dataset description    
        
    srcfile1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    localfile1 <- "UCI HAR Dataset.zip"
    
    srcfile2 <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names"
    localfile2 <- "UCI HAR Dataset.names.txt"
    
    if(!file.exists(localfile1)) {
        download.file(srcfile1, destfile=localfile1)
    }
    
    if(!file.exists(localfile2)) {
        download.file(srcfile2, destfile=localfile2)
    }
    
# Unzip the dataset
    
    # unzip(zipfile = localfile1, exdir = "data")
    
# List the files in the dataset
    
    # files <- list.files("data", recursive = TRUE)
    # files
    
# STEP 1: Merges the training and the test sets to create one data set    

    # Set the path to the data
    datapath <- "data/UCI HAR Dataset"    

    # Read the activity files
    activityTest  <- read.table(file.path(datapath, "test",  "Y_test.txt"), header = FALSE)
    activityTrain <- read.table(file.path(datapath, "train", "Y_train.txt"), header = FALSE)
    
    # Read the subject files
    subjectTest  <- read.table(file.path(datapath, "test",  "subject_test.txt"), header = FALSE)
    subjectTrain <- read.table(file.path(datapath, "train", "subject_train.txt"), header = FALSE)
    
    # Read the feature files
    featureTest  <- read.table(file.path(datapath, "test",  "X_test.txt"), header = FALSE)
    featureTrain <- read.table(file.path(datapath, "train", "X_train.txt"), header = FALSE)

    # print("Activities")
    # print(str(activityTest))
    # print(str(activityTrain))
    # print("Subjects")
    # print(str(subjectTest))
    # print(str(subjectTrain))
    # print("Features")
    # print(str(featureTest))
    # print(str(featureTrain))
    
    #Concatenate the data tables
    subject <- rbind(subjectTest, subjectTrain)
    activity <- rbind(activityTest, activityTrain)
    feature <- rbind(featureTest, featureTrain)
    
    # Add variable names
    names(subject)  <- c("subject")
    names(activity) <- c("activity")
    featureNames    <- read.table(file.path(datapath, "features.txt"), head = FALSE)
    names(feature)  <- featureNames$V2
    
    #Combine by columns
    humanActivity <- cbind(subject, activity)
    humanActivity <- cbind(feature, humanActivity)
    
    # print(head(humanActivity))
    
# STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement     

    # Find feature names with mean() or std()
    meanstd <- featureNames$V2[grep("mean\\(\\)|std\\(\\)", featureNames$V2)]
    # Subset the data frame
    meanstdNames <- c(as.character(meanstd), "subject", "activity")
    humanActivity <- subset(humanActivity, select = meanstdNames)
    # print(str(humanActivity))

# STEP 3: Uses descriptive activity names to name the activities in the data set

# STEP 4: Appropriately labels the data set with descriptive variable names    

    names(humanActivity) <- gsub("^t", "time", names(humanActivity))
    names(humanActivity) <- gsub("^f", "freq", names(humanActivity))
    names(humanActivity) <- gsub("Acc", "Accelerometer", names(humanActivity))
    names(humanActivity) <- gsub("Gyro", "Gyroscope", names(humanActivity))
    names(humanActivity) <- gsub("Mag", "Magnitude", names(humanActivity))
    names(humanActivity) <- gsub("BodyBody", "Body", names(humanActivity))
    # print(names(humanActivity))
    
# STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    
    library(plyr)
    
    humanActivity2 <- aggregate(. ~subject + activity, humanActivity, mean)
    humanActivity2 <- humanActivity2[order(humanActivity2$subject, humanActivity2$activity),]
    write.table(humanActivity2, file = "tidydata.txt", row.name = FALSE)
    
    # Produce codebook
    
    library(knitr)
    knit2html("codebook.Rmd")
    
    
    
    
    
}
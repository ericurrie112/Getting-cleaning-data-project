
## 1. Merging Training and Test Sets into one data set
# Reading in Files

# Reading Training Tables
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Reading Testing Tables
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Reading Features
features <- read.table("./UCI HAR Dataset/features.txt")

# Reading Activity Labels
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# 2.2 Assigning Column Names
colnames(x_train) <- features[,2] # assigning names from column 2 of "features" set
colnames(y_train) <- "activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] # assigning names from column 2 of "features" set
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId', 'activityType')

# 1.3 Merging All Data into One Set
all_train <- cbind(y_train, subject_train, x_train) # combine columns of train sets

all_test <- cbind(y_test, subject_test, x_test) # combine columns of all test sets

setAlldata <- rbind(all_train, all_test) # combine rows of all_train and all_test sets

## 2. Extracting only the measurements of mean and standard deviation for each measurement

# Reading Column Names
colNames(setAlldata)

# Subsetting mean and Standard Deviation columns

mean_and_SD_features <- grep("-(mean|std)\\(\\)", features[,2]) # finding column names with mean or std in features set

# create new data set with mean and std columns
meanSD <- setAlldata[, mean_and_SD_features]

## 3. Using Descriptive Activity Names in Dataset

SetActivityNames <- merge(meanSD, activityLabels, by='activityId', all.x=TRUE)


## 4. Create Second Independent Tidy Dataset

SecTidySet <- aggregate(. ~subjectId + activityId, SetActivityNames, mean)
SecTidySet <-SecTidySet[order(SecTidySet$subjectId, SecTidySet$activityId),]
 
# Writing Tidy Dataset in Text file
write.table(SecTidySet, "SecTidySet.txt", row.name=TRUE, sep='\t')
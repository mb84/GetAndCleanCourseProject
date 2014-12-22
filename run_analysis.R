# Load reshape2 package

library(reshape2)

# Training set data loading ... 
# 
 train.set <- read.table("train/X_train.txt")
 train.label <- read.table("train/y_train.txt")
 train.subjects <- read.table("train//subject_train.txt")
 train.data <- cbind(train.set,train.label,train.subjects)
# 
# ## Test set data loading ...
# 
 test.set <- read.table("test/X_test.txt")
 test.label <- read.table("test/y_test.txt")
 test.subjects <- read.table("test/subject_test.txt")
 test.data <- cbind(test.set,test.label,test.subjects)

## Merge training and tests datasets ...

data <- rbind(train.data, test.data)

## Extract features ... 

feat <- read.table("features.txt", colClasses = c("character")) 

# colClasses is necessary to be set as character in order to avoid 
# factors and affect rbind operation in the following steps 

# Now must be select only features that include mean and std pattern 

labels <- rbind(rbind(feat, c(562, "ActivityId")), c(563, "Subject"))[,2]

# setting colnames 

names(data) <- labels

### STEP 2 ###

# Subsetting only variables that include mean and std measurements along with Activity ID and Subject 

data_mean_std <- data[,grepl("mean|std|Subject|ActivityId", names(data))]


### STEP 3 ###

# Use descriptive activity names to name the activities in the data set
# load activity file and set colnames

activity <- read.table("activity_labels.txt", col.names = c("ActivityId", "ActivityDescr"))
data_mean_std <- merge(data_mean_std, activity) # simple merge can be used because ActivityId is the only common variable between data.frames

### STEP 4 ###

# Cleaning label names with descriptive variables

colnames(data_mean_std) <- gsub("\\(|\\)|-|,", "", names(data_mean_std))
colnames(data_mean_std) <- gsub("AccJerk", "LinearAcceleration", names(data_mean_std))
colnames(data_mean_std) <- gsub('GyroJerk',"AngularVelocity",names(data_mean_std))
colnames(data_mean_std) <- gsub("Mag", "Magnitude", names(data_mean_std))
colnames(data_mean_std) <- gsub("^t", "TimeDomain", names(data_mean_std), perl=TRUE) # perl regex compatibility
colnames(data_mean_std) <- gsub("^f", "FreqDomain", names(data_mean_std), perl=TRUE) # perl regex compatibility
colnames(data_mean_std) <- gsub('mean',"Mean",names(data_mean_std))
colnames(data_mean_std) <- gsub('freq',"Frequency",names(data_mean_std))
colnames(data_mean_std) <- gsub('std',"Stad",names(data_mean_std))

### STEP 5 ###

# Applying melt and dcast functions in reshape2 package and applying 
# mean function to calculate the average of each variable for each activity
# and for each subject

datamelt <- melt(data_mean_std, id = c("Subject", "ActivityId", "ActivityDescr"), measure.vars=setdiff(colnames(data_mean_std), c("Subject", "ActivityId", "ActivityDescr")))
finaldata <- dcast(datamelt, Subject + ActivityDescr ~ variable, mean)
write.table(finaldata, "CourseProjOutput.txt", row.names=FALSE)

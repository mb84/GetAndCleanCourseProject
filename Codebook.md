---
title: "CodeBook for Course project"
---

**Data source**

The dataset is derived from the "Human Activity Recognition Using Smartphones Data Set":

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

There are several files including:

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

**Data description**

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 


**Data Selection**

I extract only measurements on the mean and standard deviation for each measurement. Briefly after merging input data set, i ran regex on colnames in order to fetch only variables that include mean and std words. 
I used the command **gsub** for pattern match and replacement.
In "^t" an "^f" pattern match and replacement i've used the option PERL = TRUE to activate perl regex compatibility (^t) string starting with "t". 

**Cleaning data**

Once created the subset data.frame I performed data cleaning on variable names in order to better explain variable names.
To do this task i started from the features_info.txt file provided in the dataset package.
I've tried to clarify as much as possible the meaning of the variable as suggested by assignment by using descriptive variables.

**Create final tidy dataset with the average of each variable for each activity and each subject**

In this last step I used functions **melt** and **dcast** (reshape2 package) along with mean function to get the task.

Finally using write.table function the output file was produced.

**Additional informations**

More details for each steps are provided in the run_analysis.R script

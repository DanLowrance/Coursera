#Getting and Cleaning Data Assignment CodeBook
##Dan Lowrance 8/18/2016
###This is to help understand the label and data files, what they are for, and how they were manipulated by (run_analysis.R) to produce the tidy output data table

###Details about the label files:
####(activity_labels.txt) contains two columns, 6 activity numbers mapped to the 6 activity names
##### What are they for?: 
* These are the descriptive names which will be swapped out for the values in the (y_test.txt) and (y_train.txt) activity number data

#####Activity Number	Activity Name
* 1	WALKING
* 2	WALKING_UPSTAIRS
* 3	WALKING_DOWNSTAIRS
* 4	SITTING
* 5	STANDING
* 6	LAYING

####(features.txt) is a flat file which contains a single column of 561 features definitions, ordered to match the column order of the raw measurement data
###### NOTE: (features_info.txt) contains a codebook with full detail for understanding the nature of the features, measurements, and summary statistics
##### What are they for?: 
* These are the descriptive names which will become column headers for (x_test.txt) and (x_train.txt) measurement data files 

###### NOTE: Per the assignment, we are only interested in the Mean and Standard Deviation of features.txt and the measurement data

#####Here is a list of the  46 mean features and the 33 standard deviations featuress in the file which we will be using for the assignment:

####Mean Features:
*tBodyAcc-mean()-X,Y,Z (one for each X,Y,Z vectors)
*tGravityAcc-mean()-X,Y,Z (one for each X,Y,Z vectors)
*tBodyAccJerk-mean()-X,Y,Z (one for each X,Y,Z vectors)
*tBodyGyro-mean()-X,Y,Z (one for each X,Y,Z vectors)
*tBodyGyroJerk-mean()-X,Y,Z (one for each X,Y,Z vectors)
*tBodyAccMag-mean()
*tGravityAccMag-mean()
*tBodyAccJerkMag-mean()
*tBodyGyroMag-mean()
*tBodyGyroJerkMag-mean()
*fBodyAcc-mean()-X,Y,Z (one for each X,Y,Z vectors)
*fBodyAcc-meanFreq()-X,Y,Z (one for each X,Y,Z vectors)
*fBodyAccJerk-mean()-X,Y,Z (one for each X,Y,Z vectors)
*fBodyAccJerk-meanFreq()-X,Y,Z (one for each X,Y,Z vectors)
*fBodyGyro-mean()-X,Y,Z (one for each X,Y,Z vectors)
*fBodyGyro-meanFreq()-X,Y,Z (one for each X,Y,Z vectors)
*fBodyAccMag-mean()
*fBodyAccMag-meanFreq()
*fBodyBodyAccJerkMag-mean()
*fBodyBodyAccJerkMag-meanFreq()
*fBodyBodyGyroMag-mean()
*fBodyBodyGyroMag-meanFreq()
*fBodyBodyGyroJerkMag-mean()
*fBodyBodyGyroJerkMag-meanFreq()

####Standard Deviation Features:
*tBodyAcc-std()-X,Y,Z (one for each X,Y,Z vectors)
*tGravityAcc-std()-X,Y,Z (one for each X,Y,Z vectors)
*tBodyAccJerk-std()-X,Y,Z (one for each X,Y,Z vectors)
*tBodyGyro-std()-X,Y,Z (one for each X,Y,Z vectors)
*tBodyGyroJerk-std()-X,Y,Z (one for each X,Y,Z vectors)
*tBodyAccMag-std()
*tGravityAccMag-std()
*tBodyAccJerkMag-std()
*tBodyGyroMag-std()
*tBodyGyroJerkMag-std()
*fBodyAcc-std()-X,Y,Z (one for each X,Y,Z vectors)
*fBodyAccJerk-std()-X,Y,Z (one for each X,Y,Z vectors)
*fBodyGyro-std()-X,Y,Z (one for each X,Y,Z vectors)
*fBodyAccMag-std()
*fBodyBodyAccJerkMag-std()
*fBodyBodyGyroMag-std()
*fBodyBodyGyroJerkMag-std()

###Data files are broken into the two subject groups Test and Train:

####TRAIN group data (21 subjects):
* (X_train.txt) 7352 unlabeled observations of 561 feature variables, rows ordered to match the rows in both y_train.txt and subject_train.txt
* (y_train.txt) 7352 activity numbers for row-mapping which activities the measurements belong to, these are swapped for descriptive names using (activities_labels.txt)
* (subject_train.txt) 7352 subject numbers for row mapping which subjects belong to the TRAIN group

####TEST group data (9 subjects):
* (X_test.txt) 2947 7352 unlabeled observations of 561 feature variables, rows ordered to match the rows in both y_test.txt and subject_test.txt
* (y_test.txt) 2947 activity numbers for row-mapping which activities the measurements belong to, these are swapped for descriptive names using (activities_labels.txt)
* (subject_test.txt) 2947 subject codes for row mapping which subjects belong to the TEST group

##### What are they for?: 
* These are the row mapping for subject group and activities and the raw measurement data with the summary statistics

#### NOTE: "Inertial Signals" data files for Test or Train are NOT needed for this assignment

###How does the script manipulate the files

####NOTE: run_analysis.R also has structural and descriptive comments, for each line of code, to explain what is happening, step-by-step 
* 1 Read in the 2 label files and 6 data files into 8 data tables using read.table()
* 2 Prepare the subject group data:
** cbind() an additional column with the value "TRAIN" or "TEST"
** give columns names "Subject Number" and "Group" using colnames()
** rbind() to stack the sub_test and sub_train data tables into a new data table called subjects (with TEST on top of TRAIN)
* 3 Prepare the activity data:
** rbind() to stack the y_test and y_train data tables into a new table called y_test_train (with TEST on top of TRAIN)
** give y_test_train table a column name called "Activity" to prepare for swapping out with descriptive names using colnames()
** give the activites data table (created from activities_label.txt) a column header with "Activity" and "activity_key" using colnames()
** use match() to swap-out the descriptive names in "activity_key" by comparing the "Activity" columns of both y_test_train and activities tables
* 4 Prepare the measurement data:
** rbind() to stack the x_test and x_train tables into a new table called x_test_train (with TEST on top of TRAIN)
** add descriptive column names using colnames() on x_test_train from using unlist() on the features table (created from features.txt)
** use grep() to only select the columns which contain the "-mean" and "-std" in the header names and save those into two new tables
* 5 Combine the Subject, Activity and Measurement data, take the Means of the columns
** cbind() the subject table, y_test_train, mean, and std tables aligning them together in a new table called whole_table
** uses chaining to feed whole_table to dplyr functions group_by(Subject_Number, Group, Activity) and summarize(funs(mean)) to get a new table of means
*** the new table now has 30 subjects x 6 activities = 180 group-labeled rows of means for each variable with descriptive column headers
* 6 Use write.table() to create a tab-delimited output file called "final_dataset.txt"
** Here is a compressed sample of the output file:
#####Subject_Number Train_or_Test Activity  tBodyAcc-mean()-X tBodyAcc-mean()-Y    ....  angle(Z,gravityMean)
#####  1               TRAIN       LAYING      0.2215982         -0.040513953      ....    -0.93266067
#####  1               TRAIN       SITTING     0.2612376         -0.001308288      ....    -0.93266067
#####  ..              .....        ....        ......             .......         ....     .........
#####  30              TRAIN  WALKING_UPSTAIRS 0.2714156         -0.025331170      ....    -0.79134943


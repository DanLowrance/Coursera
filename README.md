#Getting and Cleaning Data Assignment README
## Dan Lowrance 8/18/2016
### The script Run_Analysis.R is intended to consolidate the 3 test and 3 train data files using the 2 label files, into a single tidy tab-delimited text file of means called final_dataset.txt

###Instructions per the assignment:
* 1 Merges the training and the test sets to create one data set.
* 2 Extracts only the measurements on the mean and standard deviation for each measurement.
* 3 Uses descriptive activity names to name the activities in the data set
* 4 Appropriately labels the data set with descriptive variable names.
* 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Details about the label files:
* (activity_labels.txt) contains the 6 activity definitions 
* (features.txt) contains the 561 features definitions

#### NOTE: Only interested in the 46 mean columns and the 33 standard deviations columns of features.txt

###Details about the data files:
####TRAIN:
* (X_train.txt) 7352 unlabeled observations of 561 feature variables - gets read, stored as x_train dataframe
* (y_train.txt) 7352 activity labels  - gets read, stored as y_train dataframe
* (subject_train.txt) 7352 subject number labels (21 train subjects x activity samples)  - gets read, stored as sub_train dataframe

####TEST:
* (X_test.txt) 2947 unlabeled observations of 561 feature variables - gets read, stored as x_test dataframe
* (y_test.txt) 2947 activity labels - gets read, stored as y_test dataframe
* (subject_test.txt) 2947 subject number labels (9 test subjects x activity samples) - gets read, stored as sub_test dataframe

#### NOTE: "Inertial Signals" data files for Test or Train are NOT needed for this assignment

###How to run this script run_analysis.R

* 1 Download and unzip to a folder the data found here https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* 2 Place the script "run_analysis.R" in the same folder as the "UCI HAR Dataset" 
 - Make this your working directory in R
* 3 Run the script and in a few seconds, you should see a new file appear called "final_dataset.txt"

###How does the script manipulate the files

####NOTE: run_analysis.R also has structural and descriptive comments, for each line of code, to explain what is happening, step-by-step 
* 1 It reads in the 2 label files and 6 data files into 8 data tables using read.table()
* 2 Prepares the subject group data:
 - cbind() an additional column with the value "TRAIN" or "TEST"
 - give columns names "Subject Number" and "Group" using colnames()
 - rbind() to stack the sub_test and sub_train data tables into a new data table called subjects (with TEST on top of TRAIN)
* 3 Prepares the activity data:
 - rbind() to stack the y_test and y_train data tables into a new table called y_test_train (with TEST on top of TRAIN)
 - give y_test_train table a column name called "Activity" to prepare for swapping out with descriptive names using colnames()
 - give the activites data table (created from activities_label.txt) a column header with "Activity" and "activity_key" using colnames()
 - use match() to swap-out the descriptive names in "activity_key" by comparing the "Activity" columns of both y_test_train and activities tables
* 4 Prepares the measurement data:
 - rbind() to stack the x_test and x_train tables into a new table called x_test_train (with TEST on top of TRAIN)
 - add descriptive column names using colnames() on x_test_train from using unlist() on the features table (created from features.txt)
 - use grep() to only select the columns which contain the "-mean" and "-std" in the header names and save those into two new tables
* 5 Combines the Subject, Activity and Measurement data, take the Means of the columns
 - cbind() the subject table, y_test_train, mean, and std tables aligning them together in a new table called whole_table
 - uses chaining to feed whole_table to dplyr functions group_by(Subject_Number, Group, Activity) and summarize(funs(mean)) to get a new table of means
  - the new table now has 30 subjects x 6 activities = 180 group-labeled rows of means for each variable with descriptive column headers
* 6 Uses write.table() to create a tab-delimited output file called "final_dataset.txt"

###Output Tidy data look like this compressed sample: 
####Subject_Number Train_or_Test Activity  tBodyAcc-mean()-X tBodyAcc-mean()-Y    ....  angle(Z,gravityMean)
* 1               TRAIN       LAYING      0.2215982         -0.040513953      ....    -0.93266067
* 1               TRAIN       SITTING     0.2612376         -0.001308288      ....    -0.93266067
* ..              .....        ....        ......             .......         ....     .........
* 30              TRAIN  WALKING_UPSTAIRS 0.2714156         -0.025331170      ....    -0.79134943


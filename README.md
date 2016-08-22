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

###Output Tidy data look like this compressed sample: 
####Subject_Number Train_or_Test Activity  tBodyAcc-mean()-X tBodyAcc-mean()-Y    ....  angle(Z,gravityMean)
* 1               TRAIN       LAYING      0.2215982         -0.040513953      ....    -0.93266067
* 1               TRAIN       SITTING     0.2612376         -0.001308288      ....    -0.93266067
* ..              .....        ....        ......             .......         ....     .........
* 30              TRAIN  WALKING_UPSTAIRS 0.2714156         -0.025331170      ....    -0.79134943


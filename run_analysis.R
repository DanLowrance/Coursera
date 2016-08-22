##Getting and Cleaning Data Assignment - Dan Lowrance (8/18/2016)
# This script is intended to consolidate the 3 test and 3 train data files using the 2 label files, into a single tidy data table of means
#
# Instructions per the assignment:
# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation for each measurement.
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive variable names.
# 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
#Details about the Label files:
# ---- (activity_labels.txt) contains the 6 activity definitions 
# ---- (features.txt) contains the 561 features definitions 
#### NOTE: Only interested in the 46 mean columns and the 33 standard deviations columns of features.txt
#
#Details about the data files:
#TRAIN:
# ---- (X_train.txt) 7352 unlabeled observations of 561 feature variables - will get read, stored as x_train dataframe
# ---- (y_train.txt) 7352 activity labels  - will get read, stored as y_train dataframe
# ---- (subject_train.txt) 7352 subject number labels (21 train subjects x activity samples)  - will get read, stored as sub_train dataframe
#TEST:
# ---- (X_test.txt) 2947 unlabeled observations of 561 feature variables - will get read, stored as x_test dataframe
# ---- (y_test.txt) 2947 activity labels - will get read, stored as y_test dataframe
# ---- (subject_test.txt) 2947 subject number labels (9 test subjects x activity samples) - will get read, stored as sub_test dataframe
#
##### NOTE: "Inertial Signals" data files for Test or Train are NOT needed for this assignment
#
######################### Output Tidy data look like this: #########################################################
#Subject_Number Train_or_Test Activity  tBodyAcc-mean()-X tBodyAcc-mean()-Y    ....  angle(Z,gravityMean)
#  1               TRAIN       LAYING      0.2215982         -0.040513953      ....    -0.93266067
#  1               TRAIN       SITTING     0.2612376         -0.001308288      ....    -0.93266067
#  ..              .....        ....        ......             .......         ....     .........
#  30              TRAIN  WALKING_UPSTAIRS 0.2714156         -0.025331170      ....    -0.79134943

library(dplyr) # Going to use group_by() and summarize() for getting the means of the final table

## Read in all of the data needed into data frames
x_test<-read.table(".//UCI HAR Dataset//test//X_test.txt") # load the test measurements (2947 obs of 561 vars)
y_test<-read.table(".//UCI HAR Dataset//test//y_test.txt") # load the test activities number (2947 obs of 1 var)
sub_test<-read.table(".//UCI HAR Dataset//test//subject_test.txt") # load the test subject number (2947 obs of 1 var)
x_train<-read.table(".//UCI HAR Dataset//train//X_train.txt") # load the train measurements (7352 obs of 561 vars)
y_train<-read.table(".//UCI HAR Dataset//train//y_train.txt") # load the train activities number (7352 obs of 1 var)
sub_train<-read.table(".//UCI HAR Dataset//train//subject_train.txt") # load the train subject number (7352 obs of 1 var)
features<-read.table(".//UCI HAR Dataset//features.txt") # load the feature label names for the X_test/train headers (561 obs of 2 vars)
activities<-read.table(".//UCI HAR Dataset//activity_labels.txt") # load the activity label names for the y_test/train values (6 obs of 2 vars) 

#################### Prepare the Subject Group portion of the table ################################################# 
sub_test <- cbind(sub_test,"TEST") #Add a new column with the subject label 'TEST'
sub_train <- cbind(sub_train,"TRAIN") #Add a new column with the subject label 'TRAIN'
colnames(sub_test) <- c("Subject_Number","Group") # add a column header for subjects of the subject number, and which group they belong
colnames(sub_train) <- c("Subject_Number","Group") # add a column header for subjects of the subject number, and which group they belong
subjects <- rbind(sub_test, sub_train) #stack the test and train subject data tables

############ Prepare the Activity portion of the table ##############################################################
y_test_train <- rbind(y_test,y_train) #stack the test and train activity numbers data
colnames(y_test_train) <- "Activity" # give y_test_train a column header
colnames(activities) <- c("Activity","activity_key") # give activities codebook column headers
y_test_train[["Activity"]] <- activities[match(y_test_train[["Activity"]], activities[["Activity"]]), 'activity_key'] #replace activity number for activity label

############ Prepare the Measurement Means and Standard Deviations data ############################################
x_test_train <- rbind(x_test, x_train) #stack the test and train measurements
colnames(x_test_train) <- unlist(features[,2], use.names = FALSE) #use the second column of features.txt to create a header for x_test_train
x_mean_cols <- x_test_train[,grep("-mean",names(x_test_train))] # Directive #2: get a table of just mean and standard deviations
x_std_cols <- x_test_train[,grep("-std",names(x_test_train))] # Directive #2: get a table of just mean and standard deviations

############ Join the data together, group by the Subject, Group, and Activity, Summarize the averages
whole_table <- cbind(subjects,y_test_train,x_mean_cols,x_std_cols) #join the subject, group, activity, and mean/sigma data
avg_data_table <- whole_table %>% group_by(Subject_Number, Group, Activity) %>% summarize_each(funs(mean)) #get the means of the columns by subject, group and activity

############ Output the final data set #############################################################################
final_dataset <- write.table(avg_data_table, file="final_dataset.txt",sep="\t", row.names=FALSE, col.names = TRUE) #write a tab-delimited text file
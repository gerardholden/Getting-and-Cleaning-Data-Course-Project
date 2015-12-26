run_analysis.R

author: Gerard Holden
course: Getting and Cleaning Data

The sctipt uses data from the Human Activity Recognition Using Smartphones Dataset Version 1.0

The data was collected from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment. 

========================================

POST - PROCESSING

From the large source dataset a smaller dataset was extracted which included only means and standard deviations. The column labels were amended to be more human readable and a tidy dataset was produced.

The script is commented with the five steps used to generate the tidy dataset.

1. Merges the training and the test sets to create one data set.

	The activity, subject and feature data for both the test and training data were read into data tables. The test and train data tables for each of activity, subject and feature were combined.
	
2. Extracts only the measurements on the mean and standard deviation for each measurement. 

	Regular expressions were used to identify the attributes that included either mean or std in the attribute name. The data tables were trimmed to include only those attributes.
	
3. Uses descriptive activity names to name the activities in the data set

	Activity names were or should have been changed to descriptive names.
	
4. Appropriately labels the data set with descriptive variable names. 

	Regular exxpressions were used to expand abbreviations; "t" to "time", "f" to "frequency", "Acc" to "Accelerometer", "BodyBody" to "Body", "Gyro" to "Gyroscope" and "Mag" to "Magnitude".

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

	A second dataset is created using the avearges of each variable, by activity and subject.
Chris Kerrigan
Course 3 Week 4

This is the codebook for the final assignment for Course 3, Week 4. The associated R code can be found in the run_analysis.R file.

Step 1: Merge the training and the test set to create one data set.
====================================================================
The files "X_train.txt" and "X_test.txt" were both read into R and saved as "train" and "test", respectively. The column headers for these
two data sets were extracted from the "features.txt" file. Two additional fields were added to both the "train" and "test" data sets.
In order to add the activity labels field, the two files "y_test.txt" and "y_train.txt" were read in and column
binded to the respective test and train data sets. Each of those columns were titled "activity_label". Similarly, the two files 
"subject_test.txt" and "subject_train.txt" were read into R, column binded to the "test" and "train" data sets, and given the column
header "subject".

The two data sets (train and test) were row binded together to create the  "merge" data set. This data set has 561 variables and 10299 observations, 
which matches the specified dimensions from the website that explains the study:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Step 2: Extract only the measurements on the mean and standard deviation for each measurement
==============================================================================================
In order to extract only the measurements on the mean and standard deviation, only variable names that contain "Mean", "mean", "std",
or "Std" were included. The two relevant lists are "meanMeasurements" and "stdDevMeasurements."
Note: the identified key words can be located anywhere in the column name, not just at the end of the name. There are 86 total variables
related to the mean and standard deviation per these criteria.

Step 3: Use descriptive activity names to name the activities in the data set
==============================================================================
In order to name the activities in the dataset using descriptive names (step 3 in the requirements), the "activity_labels.txt" file was
read into R in and stored in the "activity_labels" variable. The column names of that table were renamed "id" and "activity_labels". That 
table was then joined with the "data" table (merged test and train data) so the table would contain the activity names instead of just
the identifying numbers. "data1" is the result of outer left joining "data" with "activity_labels". Then "data2" removes the "activity_label"
field (which only contained activity numbers) and reorders all variables so the data set begins with "subject" and "activity_label".

Note: the "subject" variable and the "activity_labels" variable in the "data2" data set were both converted to factors because we will be
grouping by those two variables. 

Step 4: Appropriately label the data set with descriptive variable names.
=========================================================================
All column names of the "data2" data set other than the first two ("subject" and "activity_label") were left alone because they were adequately
descriptive. See below for an explanation of the features:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using 
a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the 
acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another 
low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and 
tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, 
tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, 
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'


Step 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
======================================================================================================================================================
"tidy" is a clean data set because it satisfies the following 5 properties:
	1) All columns are variables
	2) There are not multiple variables stored in each column
	3) There are no variables  stored in both rows and columns
	4) Multiple observations are not stored in the same table
	5) A single observational unit is not stored in multiple tables (opposite of number 4)
	
"tidy" was created by taking the aggregate mean of "data2" by both "subject" and "activity_labels". The "subject" and "activity_labels" fields themselves
returned NAs when aggregated because they were not integer fields, so those two columns were deleted after aggregation. However, the two newly created
fields "Group.1" and "Group.2" were renamed to "subject" and "activity", respectively. The result was a tidy data set that showed the mean value for each 
variable related to Mean or Std Deviation, aggregated by both subject and by activity. "tidy" contains 180 rows, as opposed to 10299 in data2.




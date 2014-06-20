# Getting And Cleaning Data

The included script run_analysis.R extracts the following information
from the input file "getdata_projectfiles_UCI HAR Dataset.zip":

* features containing the mean and standard deviation of measurements
* feature names
* activity names

and calculates the average of each feature for each activity and each subject.

This is done in the following steps:

1. Feature values, subject ids and activity ids are read from the training
and the test sets in the input file.
2. The training and the test sets are merged.
3. Feature list and activity list are read from the input file.
4. The mean and standard deviation features' positions are calculated.
5. All other features are eliminated.
6. The remaining features are renamed to more appropriate names.
7. The activity and subject numbers are converted to factors.
8. The tidy dataset containing feature averages is generated.
9. The tidy dataset is written to the file "UCI_HAR_means.txt".
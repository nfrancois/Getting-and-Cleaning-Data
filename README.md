# Getting-and-Cleaning-Data project

This project is assigment for coursea getting and cleaning data.

run_analysis.R is the requirement. 
If the dataset directory does not exists, it will be created by the script, and data will be downloaded.

The train and test are merged in merged_data.
With this data, we only extract mean and standard.

Since in the data give a id for activity, we replace them by label from the activity_label file

Finally we group data by pair (subject, activity) and give the mean for each measure by using the power of aggregation
Because, it's cool to explore this data, we write the gerenated data in a csv file
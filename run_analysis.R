
# Some constants
archive_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
archive_file <- "data_project.zip"
archive_dir <- "UCI HAR Dataset"

# 0. Download data if not exists
if(!file.exists(archive_dir)){
	if(!file.exists(archive_dir)){
		download.file(archive_url, destfile = archive_file, method = 'curl')
	}
	unzip(archive_file)
}

# 1. Merges the training and the test sets to create one data set.
# Activity and subject row first to be more readeable
training[] <- read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
training[,2] <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
training[,3] <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)

testing[] <- read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
testing[,2] <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
testing[,3] <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)

merged_data <- rbind(training, testing)

features <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE, stringsAsFactors=FALSE)
names(merged_data) <- append(c("activity", "subject"),features[,2])

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# find colums with data about mean and standard deviation
mean_and_std_columns <-  grep("mean|std", names(merged_data))
# we still need activity and subject columns
extract_data <- merged_data[, c(1,2,mean_and_std_columns)]

# 3. Uses descriptive activity names to name the activities in the data set

activity <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE, stringsAsFactors=FALSE)
extract_data$activity <- activity[extract_data$activity,2]

# 4. Appropriately labels the data set with descriptive variable names. 

# I think it's already done

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
# calculte by using aggreage on pair (activity, subject) and ignore eventual not avaible data
tidy <- aggregate(extract_data, by=list(extract_data = extract_data$activity, extract_data=extract_data$subject), FUN=mean, na.rm=TRUE)
write.table(tidy, "tidy.csv")
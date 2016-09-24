#1. Merge training and the test sets

trainSet <- read.csv(".\\UCI HAR Dataset\\X_train.txt", sep = "", header = FALSE) 
testSet <- read.csv(".\\UCI HAR Dataset\\X_test.txt", sep = "", header = FALSE)
rawSet <- rbind(trainSet, testSet) #Append datasets 

#2. Extract mean and standard deviation from features 

features <- read.csv(".\\UCI HAR Dataset\\features.txt", sep = "", header = FALSE)
selectedFeatures <- features[grep("mean\\(\\)|std\\(\\)", features[, 2]), ]
dataset <- rawSet[, selectedFeatures[, 1]]

#3. Adding descriptive activity names to data set

activityLabels <- read.csv(".\\UCI HAR Dataset\\activity_labels.txt", sep = "", header = FALSE)
activitiesTrain <- read.csv(".\\UCI HAR Dataset\\y_train.txt", sep = "", header = FALSE)
activitiesTest <- read.csv(".\\UCI HAR Dataset\\y_test.txt", sep = "", header = FALSE)

activities <- rbind(activitiesTrain, activitiesTest)
activities$id <- 1:nrow(activities)
activitiesMerged <- merge(activities, activityLabels, by.x = "V1", by.y = "V1", all = FALSE)

activitiesWithLabels <- activitiesMerged[order(activitiesMerged$id), ]

#4. Labeling data set with descriptive variable names.
subjectsTrain <- read.csv(".\\UCI HAR Dataset\\subject_train.txt", sep = "", header = FALSE)
subjectsTest <- read.csv(".\\UCI HAR Dataset\\subject_test.txt", sep = "", header = FALSE)
subjects <- rbind(subjectsTrain, subjectsTest)

datasetLabels <- gsub("  ", " ",
                      gsub("-", " ",
                           gsub("mean\\(\\)", "Mean",
                                gsub("std\\(\\)", "Std",
                                     gsub("^f", "Frequency ",
                                          gsub("^t", "Time ",
                                               gsub(
													"([A-Z])", " \\1", selectedFeatures[, 2], perl = TRUE
												)
											)
										)
									)
								)
							)
						)
						
names(dataset) <- datasetLabels
names(activitiesWithLabels) <- c("Activity Code", "Id", "Activity")
names(subjects) <- "Subject"

messy <- cbind(subjects, activitiesWithLabels, dataset)

#5. Create a second, independent tidy data set with the average of each variable

library(dplyr)
messy <- tbl_df(messy)

tidy <- messy %>%
  select(-`Activity Code`, -Id) %>%
  group_by(Subject, Activity) %>%
  summarise_each(funs(mean))

write.table(tidy, file = "tidy.txt", row.names = FALSE)

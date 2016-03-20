
#-------------------------------
# setup

setwd("C:/Users/quinn_000/Desktop/Toy Examples/Coursera/Data.Science.Specialization/getting.and.cleaning.data/week4")
library(dplyr)


#-------------------------------
# load
features <- read.table("UCI HAR Dataset/features.txt")
Activities <- read.table("UCI HAR Dataset/activity_labels.txt")

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
x_train <- read.table("UCI HAR Dataset/train/x_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt") 

y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
x_test <- read.table("UCI HAR Dataset/test/x_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt") 


#--------------------------------
# Assemble dataset
df_x <- rbind(x_train, x_test)
df_y <- rbind(y_train, y_test)
df_subjects <- rbind(subject_train, subject_test)

df<- cbind(df_x, df_y)
df<- cbind(df, df_subjects)

rm("df_x", "df_y","df_subjects", "y_train", "x_train", 
   "y_test", "x_test", "subject_train", "subject_test")

#--------------------------------
# Tidy up Dataset

# append feature names, the name for the activity catagorical,
# and the subject ID together. set as the names of the dataset
featureNames <- as.character(features[, 2])
featureNames <- append(featureNames, c("activity", "subjectid"))
names(df) <- featureNames

# find the columns that contain standard deciations or means.
# keep only these, the activity catagorical, and the subject ID
toKeepMean <- grep("\\mean\\b", names(df))
toKeepSD <- grep("std()", names(df))
toKeep <- append(toKeepMean, toKeepSD)
toKeep <- append(toKeep, c(562, 563))

df<- df[ , toKeep]

# us the activities lookup table to replace the numerical activity codes
# with thier english descriptors 
replace<- match(df$activity, Activities[, 1])
df$activity <- Activities[replace, 2]

rm("features", "featureNames", "toKeep", "toKeepMean", 
   "toKeepSD" , "replace", "Activities")

#--------------------------------
# Summarize
df_summary <- df %>% group_by(subjectid, activity) %>%
                     summarise_each(funs(mean))

write.table(df_summary, "df summary.txt", row.name=FALSE)

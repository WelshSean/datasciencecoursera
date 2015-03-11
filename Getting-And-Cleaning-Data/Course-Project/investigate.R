# df 2947 obs of 561 variables


setwd("/home/sean/DataScience/datasciencecoursera/Getting-And-Cleaning-Data/Course-Project/UCI HAR Dataset")
header <- read.table("features.txt") ### This file stores headers
df <- read.table("test/X_test.txt")  ### test data vector
subject_test <- read.table("test/subject_test.txt", col.names="subject_test")
y_test <- read.table("test/y_test.txt", col.names="y_test")
names(df) <- header[,2]
df <- cbind(subject_test, y_test, df)

library(dplyr)
library(reshape2)
library(tidyr)

#merging test and train datasets of variables.

body_acc_x_test <- tbl_df(read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt"))
body_acc_x_train <- tbl_df(read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt"))
body_acc_x <- bind_rows(body_acc_x_test, body_acc_x_train)
rm(body_acc_x_test, body_acc_x_train)

body_acc_y_test <- tbl_df(read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt"))
body_acc_y_train <- tbl_df(read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt"))
body_acc_y <- bind_rows(body_acc_y_test, body_acc_y_train)
rm(body_acc_y_test, body_acc_y_train)

body_acc_z_test <- tbl_df(read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt"))
body_acc_z_train <- tbl_df(read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt"))
body_acc_z <- bind_rows(body_acc_z_test, body_acc_z_train)
rm(body_acc_z_test, body_acc_z_train)

body_gyro_x_test <- tbl_df(read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt"))
body_gyro_x_train <- tbl_df(read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt"))
body_gyro_x <- bind_rows(body_gyro_x_test, body_gyro_x_train)
rm(body_gyro_x_test, body_gyro_x_train)

body_gyro_y_test <- tbl_df(read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt"))
body_gyro_y_train <- tbl_df(read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt"))
body_gyro_y <- bind_rows(body_gyro_y_test, body_gyro_y_train)
rm(body_gyro_y_test, body_gyro_y_train)

body_gyro_z_test <- tbl_df(read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt"))
body_gyro_z_train <- tbl_df(read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt"))
body_gyro_z <- bind_rows(body_gyro_z_test, body_gyro_z_train)
rm(body_gyro_z_test, body_gyro_z_train)

total_acc_x_test <- tbl_df(read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt"))
total_acc_x_train <- tbl_df(read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt"))
total_acc_x <- bind_rows(total_acc_x_test, total_acc_x_train)
rm(total_acc_x_test, total_acc_x_train)

total_acc_y_test <- tbl_df(read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt"))
total_acc_y_train <- tbl_df(read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt"))
total_acc_y <- bind_rows(total_acc_y_test, total_acc_y_train)
rm(total_acc_y_test, total_acc_y_train)

total_acc_z_test <- tbl_df(read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt"))
total_acc_z_train <- tbl_df(read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt"))
total_acc_z <- bind_rows(total_acc_z_test, total_acc_z_train)
rm(total_acc_z_test, total_acc_z_train)

subject_test <- tbl_df(read.table("UCI HAR Dataset/test/subject_test.txt"))
subject_train <- tbl_df(read.table("UCI HAR Dataset/train/subject_train.txt"))
subject <- bind_rows(subject_test, subject_train)
rm(subject_test, subject_train)

activity_test <- tbl_df(read.table("UCI HAR Dataset/test/y_test.txt"))
activity_train <- tbl_df(read.table("UCI HAR Dataset/train/y_train.txt"))
activity <- bind_rows(activity_test, activity_train)
rm(activity_test, activity_train)

activity_labels <- tbl_df(read.table("UCI HAR Dataset/activity_labels.txt"))
names(activity_labels) <- c("activity_code", "activity")

#merging all the variables into one dataset

merged_dataset <- mutate(body_acc_x, subject = subject$V1, activity_code = activity$V1)
merged_dataset <- inner_join(merged_dataset, activity_labels, by = "activity_code")
merged_dataset <- select(merged_dataset, -(activity_code))
merged_dataset <- melt(merged_dataset, id.vars = c("subject", "activity"))
merged_dataset <- select(merged_dataset, -(variable))
merged_dataset <- rename(merged_dataset, body_acc_x = value)
merged_dataset <- tbl_df(merged_dataset)

body_acc_y <- body_acc_y %>% melt() %>% select(value) %>% rename(body_acc_y = value) %>% tbl_df()
body_acc_z <- body_acc_z %>% melt() %>% select(value) %>% rename(body_acc_z = value) %>% tbl_df()
body_gyro_x <- body_gyro_x %>% melt() %>% select(value) %>% rename(body_gyro_x = value) %>% tbl_df()
body_gyro_y <- body_gyro_y %>% melt() %>% select(value) %>% rename(body_gyro_y = value) %>% tbl_df()
body_gyro_z <- body_gyro_z %>% melt() %>% select(value) %>% rename(body_gyro_z = value) %>% tbl_df()
total_acc_x <- total_acc_x %>% melt() %>% select(value) %>% rename(total_acc_x = value) %>% tbl_df()
total_acc_y <- total_acc_y %>% melt() %>% select(value) %>% rename(total_acc_y = value) %>% tbl_df()
total_acc_z <- total_acc_z %>% melt() %>% select(value) %>% rename(total_acc_z = value) %>% tbl_df()

merged_dataset <- mutate(merged_dataset, body_acc_y = body_acc_y$body_acc_y, body_acc_z = body_acc_z$body_acc_z, body_gyro_x = body_gyro_x$body_gyro_x, body_gyro_y = body_gyro_y$body_gyro_y, body_gyro_z = body_gyro_z$body_gyro_z, total_acc_x = total_acc_x$total_acc_x, total_acc_y = total_acc_y$total_acc_y, total_acc_z = total_acc_z$total_acc_z)

#Calculating average of each variable for each activity and each subject.

merged_dataset <- gather(merged_dataset, variable, value, -subject, -activity)
merged_dataset <- group_by(merged_dataset, subject, activity, variable)
merged_dataset <- summarise(merged_dataset, mean_value = mean(value))

#removing temporary variables
rm(activity, activity_labels, body_acc_x, body_acc_y, body_acc_z, body_gyro_x, body_gyro_y, body_gyro_z, total_acc_x, total_acc_y, total_acc_z, subject)
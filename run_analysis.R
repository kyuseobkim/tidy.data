run_analysis <- function() {
        # path variables
        main.path <- "UCI HAR Dataset"
        test.path <- paste(main.path, "test", sep = "//")
        test.inertial.path <- paste(test.path, "Inertial Signals", sep = "//")
        train.path <- paste(main.path, "train", sep = "//")
        train.inertial.path <- paste(train.path, "Inertial Signals", sep = "//")
        
        # activites and features label
        activities <- read.table("UCI HAR Dataset//activity_labels.txt", stringsAsFactors = FALSE)
        features <- read.table("UCI HAR Dataset//features.txt", stringsAsFactors = FALSE)
        
        # read test data
        x.test <- read_data(test.path, "X_test.txt")
        y.test.label <- read_data(test.path, "y_test.txt")
        test.subject <- read_data(test.path, "subject_test.txt")
        
        # read train data
        x.train <- read_data(train.path, "X_train.txt")
        y.train.label <- read_data(train.path, "y_train.txt") 
        train.subject <- read_data(train.path, "subject_train.txt")
        
        # combine test and train data
        x <- rbind(x.test, x.train)
        y <- rbind(y.test.label, y.train.label)
        subject <- rbind(test.subject, train.subject)
        
        # convert activity to human readable form 
        activity <- human_readable_activity(y, activities)
        
        produce_tidy_data(x, subject, activity, features)
        
        # only keep the fields that are mean or std
        fields <- fields_to_keep(features$V2)
        names(x) <- as.matrix(features$V2)
        x <- x[fields]
        
        x$activity <- activity
        x$subject <- subject
        
}

read_data <- function(path, file.name) {
        read.table(paste(path, file.name, sep = "//"), header = FALSE, stringsAsFactors = FALSE)
}

fields_to_keep <- function(fields) {
        names <- c()
        for (field in fields) {
                if (grepl("mean\\(\\)", field) || grepl("std\\(\\)", field)) {
                        names <- c(names, field)
                }
        }
        names
}

human_readable_activity <- function(y, activities) {
        sapply(as.matrix(y), function(x) { activities[activities$V1 == x,]$V2})
}

produce_tidy_data <- function(x, subject, activities, features) {
        names(x) <- as.matrix(features$V2)
        names(activities) <- "activity"
        names(subject) <- "subject"
        x <- cbind(x, subject, activities)
        library(data.table)
        dt <- data.table(x);
        dt <- dt[,lapply(.SD, mean), by=list(activities, subject)]
        write.table(dt, row.name = FALSE, file="answer.txt")
        
}

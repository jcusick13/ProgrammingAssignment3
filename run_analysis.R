library(dplyr)

# 1. Merge training and test sets
# -------------------------------
subject.test <- read.table("./test/subject_test.txt")
subject.train <- read.table("./train/subject_train.txt")
subject <- rbind(subject.train, subject.test)

x.test <- read.table("./test/X_test.txt")
x.train <- read.table("./train/X_train.txt")
x <- rbind(x.train, x.test)

y.test <- read.table("./test/Y_test.txt")
y.train <- read.table("./train/Y_train.txt")
y <- rbind(y.train, y.test)

dat <- data.frame(subject, y, x)


# 2. Extract only the mean and standard deviation for each measurement
# --------------------------------------------------------------------

# Determine cols with mean/stdev
x.names <- read.table("./features.txt")
x.names[2] <- lapply(x.names[2], as.character)
cols <- x.names[grep("(.*-)(mean|std)\\(", x.names$V2), 1]

# Update col numbers to reflect position in merged dataset
cols.shift <- cols + 2

# Extract selected variables
dat <- select(dat, c(1, 2, cols.shift))


# 3. Appropriately name activites in the dataset with descriptive names
# ---------------------------------------------------------------------
act.labels <- read.table("./activity_labels.txt")
rename <- function(x) {
    act.labels[x,2]
}
dat[2] <- sapply(dat[2], rename)


# 4. Label dataset with descriptive variable names
# ------------------------------------------------
x.col.names <- x.names[cols, 2]
dat.names <- c("Subject", "Activity", x.col.names)
names(dat) <- dat.names


# 5. Create second, independent tidy dataset with the average of each variable
# for each activity and subject
# -----------------------------
summary <- dat %>% group_by(Subject, Activity) %>% summarize_each(funs(mean))
write.table(summary, "./summary_data.txt", row.names = FALSE)


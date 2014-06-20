archiveName <- "getdata_projectfiles_UCI HAR Dataset.zip"

fname <- function(s) paste("UCI HAR Dataset/", s, ".txt", sep="")
ttname <- function(s, mode) fname(paste(mode, "/", s, "_", mode, sep=""))
readTable <- function(s, ...) read.table(unz(archiveName, s), ...)

readData <- function(mode) {
  list(X = readTable(ttname("X", mode)),
       y = readTable(ttname("y", mode)),
       subject = readTable(ttname("subject", mode))
  )
}

trainData <- readData("train")
testData <- readData("test")

data <- mapply(rbind, trainData, testData)

features <- readTable(fname("features"), stringsAsFactors=F)
activities <- readTable(fname("activity_labels"), stringsAsFactors=F)

r <- "(.*)-(mean|std)\\(\\)(?:-?)(.*)"
features <- features[grep(r, features$V2),]

X <- data$X[,features$V1]

colnames(X) <- sub("\\.$", "", sub(r, "\\1.\\2.\\3", features$V2))

activity <- factor(data$y$V1, activities$V1, activities$V2)
subject <- factor(data$subject$V1)
df <- data.frame(X, activity, subject)

dfmean <- aggregate(.~activity+subject, df, mean)

write.table(dfmean, "UCI_HAR_means.txt", quote=F, row.names=F)

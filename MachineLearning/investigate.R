library(caret)
library(randomForest)
library(rpart)
set.seed(1974)

 
DataDir <- "Data"
FilePathTrain <- paste(DataDir, "pml-training.csv", sep="/")
FilePathTest <- paste(DataDir, "pml-testing.csv", sep="/")
dir.create(DataDir, showWarnings=FALSE) 

## Only download if the file doesnt exist
if (! file.exists(FilePathTrain)){
  download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv",FilePathTrain , method="curl")
}
if (! file.exists(FilePathTest)){
  download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv",FilePathTest , method="curl")
}
pmltraining <- read.csv(FilePathTrain, stringsAsFactors = FALSE, na.strings = c("", "NA", "#DIV/0!"))


pmltraining <- pmltraining[-(1:7)]
pmltraining <- pmltraining[, colSums(is.na(pmltraining)) != nrow(pmltraining)]
pmltraining$classe <- factor(pmltraining$classe)

columnsToRemove <- grep("^var.*|^stddev.*|^max.*|^min.*|^avg.*|^total.*|.*timestamp.*|user_name",names(pmltraining))
pmltraining <- pmltraining[-columnsToRemove]

last <- ncol(pmltraining)
nzv <- nearZeroVar(pmltraining[,-last], saveMetrics=FALSE)
pmltraining <- pmltraining[,-nzv]

trainingb <- pmltraining
pmltraining<-pmltraining[,colSums(is.na(pmltraining)) == 0]

model1 <- rpart(classe ~ ., data=pmltraining, method="class")
prediction1 <- predict(model1, pmltraining, type = "class")

model2 <- randomForest(classe ~. , data=pmltraining, method="class")
prediction2 <- predict(model2, pmltraining, type = "class")

model3 <- train(classe ~ ., data = pmltraining, method="rpart")
prediction3 <- predict(model3, pmltraining, type = "class")

pre<-preProcess(trainingb[-73], method='bagImpute')
trainingb <- predict(pre, trainingb )
model4 <-  rpart(classe ~ ., data=trainingb, method="class")
prediction4 <- predict(model4, trainingb, type = "class")

model5 <-  randomForest(classe ~ ., data=trainingb, method="class")
prediction5 <- predict(model5, trainingb, type = "class")

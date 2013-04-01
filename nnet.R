source("ann.R")

library(caret)

pp <- preProcess(subset(trainDescr,select=-(CLASS)),
                 method="range")
train.pp <- predict(pp,subset(trainDescr,select=-(CLASS)))
test.pp <- predict(pp,subset(trainDescr,select=-(CLASS)))
train.pp$CLASS <- trainDescr$CLASS
test.pp$CLASS <- testDescr$CLASS

fitCtrl <- trainControl(method="cv",
                        number=10)
tuneGrid <- expand.grid(.decay=(1:100)*0.001,
                        .size=c(1,2,3,4,5))
print("nnfit1",quote=F)
nnfit1 <- train(CLASS ~ .,
                method="nnet",
                data=train.pp,
                trControl = fitCtrl,
                preProcess=c("range"),
                tuneGrid = tuneGrid,
                trace=F
                )

print("nnfit1.pca",quote=F)
nnfit1.pca <- train(CLASS ~ .,
                method="nnet",
                data=train.pp,
                trControl = fitCtrl,
                preProcess=c("range","pca"),
                tuneGrid = tuneGrid,
                trace=F
                )

plot(nnfit1)

# Prediction
testPred <- predict(nnfit1, testDescr)
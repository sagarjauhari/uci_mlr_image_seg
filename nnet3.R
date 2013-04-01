source("ann.R")

### Builds 7 binary output ANNs and compares them all for final values ###

library(caret)

# Make matrix of classes
cnames <- levels(trainDescr$CLASS)

train.targets <- sapply(cnames,function(cname){
  vec <- trainDescr$CLASS==cname
  class.new <- rep(0,length(vec))
  class.new[vec] = 1;
  return(class.new);
})
train.targets <- as.data.frame(train.targets)

test.targets <- sapply(cnames,function(cname){
  vec <- testDescr$Class==cname
  class.new <- rep(0,length(vec))
  class.new[vec] = 1;
  return(class.new);
})
test.targets <- as.data.frame(test.targets)

nets_all <- NULL;
for(cname in cnames){
  class_this <- train.targets[[cname]]
  
  nnfit <- nnet(subset(trainDescr,select=-(CLASS)),
                 class_this,
                 size=4,
                 decay=0.013,
                 maxit=500)
  
  print(sprintf("Calculated nn for class %s",cname),quote=F)
  nets_all[[cname]] <- nnfit
}

# Using each of the 7 ANNs above and predicting the final label
preds_all <- NULL
for(cname in cnames){
  nnpred <- predict(nets_all[[cname]], subset(testDescr,select=-(Class)))
  print(sprintf("Made predictions for class %s",cname),quote=F)
  preds_all[[cname]] <- as.double(nnpred)
}

test.cl <- function(true, pred){
  true <- max.col(true)
  pred <- max.col(pred)
  print(table(true, pred))
}

test.cl(test.targets, as.data.frame(preds_all))
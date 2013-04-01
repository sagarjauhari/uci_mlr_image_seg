source("ann.R")

### Builds a 7 output ANN ###

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

nnfit1 <- nnet(subset(trainDescr,select=-(CLASS)),
               train.targets,
               size=4,
               decay=0.013,
               maxit=500)

test.cl <- function(true, pred){
  true <- max.col(true)
  pred <- max.col(pred)
  print(table(true, pred))
}

test.cl(test.targets, predict(nnfit1, subset(testDescr,select=-(Class))))
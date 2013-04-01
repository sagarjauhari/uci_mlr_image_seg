source("ann.R")

cnames <- levels(trainDescr$CLASS)

class_all <- sapply(cnames,function(cname){
  vec <- trainDescr$CLASS==cname
  class.new <- rep(0,length(vec))
  class.new[vec] = 1;
  return(class.new);
})
class_all <- as.data.frame(class_all)

nets_all <- NULL;
for(cname in cnames){
  class_this <- class_all[[cname]]
  data <- cbind(class_this,trainDescr[,-1])
  colnames(data)[1] <- "CLASS"
  nn <- neuralnet(ff, 
                  data=data,
                  hidden=5,
                  err.fct="ce",
                  act.fct="logistic",
                  linear.output=F,
                  rep=1
  )
  print(sprintf("Calculated nn for class %s",cname),quote=F)
  nets_all[[cname]] <- nn
}


#source("ann.R")
pca1 <- prcomp(trainDescr[,-1])
plot(pca1$x,col=trainDescr[,1])

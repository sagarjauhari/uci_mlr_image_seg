library(neuralnet)
source("import.R")

print("Remove irrelevant predictors",quote=F)
irr_preds <- c("REGION.CENTROID.COL",
               "REGION.CENTROID.ROW",
               "REGION.PIXEL.COUNT"
)
for(i in irr_preds){
  trainDescr[[i]] <- NULL
  testDescr[[i]] <- NULL
}


ff <- CLASS ~
  SHORT.LINE.DENSITY.5 +
  SHORT.LINE.DENSITY.2 +
  VEDGE.MEAN +
  VEDGE.SD +
  HEDGE.MEAN +
  HEDGE.SD +
  INTENSITY.MEAN +
  RAWRED.MEAN +
  RAWBLUE.MEAN +
  RAWGREEN.MEAN +
  EXRED.MEAN +
  EXBLUE.MEAN +
  EXGREEN.MEAN +
  VALUE.MEAN +
  SATURATION.MEAN +
  HUE.MEAN;

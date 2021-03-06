rm(list = ls())
source("Global.R")

curveDir = "data/curve/select"
selectCurveNames = c(
  "GR", "AC", "RMN", "RMG", "RLLS", "RLLD"
)
wellNames = c(
  "��2-231-221��", "��2-24-25", "��2-26-27", "��2-27-27",
  "��2-28-28", "��2-29-28", "��2-30-23", "��2-32-38",
  "��2-33-20", "��2-33-28", "��2-35-27", "��2-36-26",
  "��2-36-27", "��2-37-24", "��2-38-29", "��2-40-19",
  "��2-8-17",  "��211", "��212", "��213", "��25",
  "��262", "̫108", "̫121", "̫23"
)

for (wellName in wellNames)
{
  cat(sprintf("process %s ...\n", wellName)) 
  curves = read.csv(sprintf("%s/%s.csv", curveDir, wellName), header = TRUE)
  outputDir = sprintf("data/test/%s", wellName)
  if (! file.exists(outputDir))
    dir.create(outputDir)

  depths = curves$DEPTH
  for (curveName in selectCurveNames) {
    cat(sprintf("  process %s ...\n", curveName))
    spects = CurveToSpectrum(curves[[curveName]])
    spects = cbind("DEPTH" = depths, spects)
    colnames(spects) = c("DEPTH", sprintf("%s%d", curveName, 1:(ncol(spects)-1)))
    write.csv(spects, sprintf("%s/%s.csv", outputDir, curveName), row.names = FALSE)
  }
}
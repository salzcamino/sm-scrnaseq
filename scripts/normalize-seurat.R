#!/usr/bin/env Rscript
library(Seurat)
# Redirect output and messages to log file
log <- file(snakemake@log[[1]], open = "wt")
sink(log, type = "output")
sink(log, type = "message")

data.seurat <- readRDS(snakemake@input[[1]])
data.seurat <- NormalizeData(data.seurat)

saveRDS(data.seurat, snakemake@output[[1]])

# Close log file
sink(type = "message")
sink(type = "output")

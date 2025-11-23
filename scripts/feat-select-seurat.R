#!/usr/bin/env Rscript
library(Seurat)
# Redirect output and messages to log file
log <- file(snakemake@log[[1]], open = "wt")
sink(log, type = "output")
sink(log, type = "message")

sample <- snakemake@wildcards[["sample"]]
var_features = snakemake@config[["samples"]][[sample]][["var_features"]]

data.seurat <- readRDS(snakemake@input[[1]])
data.seurat <- FindVariableFeatures(data.seurat, selection.method = "vst", nfeatures = var_features)

saveRDS(data.seurat, snakemake@output[[1]])

# Close log file
sink(type = "message")
sink(type = "output")

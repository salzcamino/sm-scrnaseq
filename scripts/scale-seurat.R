#!/usr/bin/env Rscript
library(Seurat)

data.seurat <- readRDS(snakemake@input[[1]])
data.seurat <- ScaleData(data.seurat)

saveRDS(data.seurat, snakemake@output[[1]])

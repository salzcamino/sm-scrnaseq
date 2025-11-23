#!/usr/bin/env Rscript
library(Seurat)
# Read 10X data into counts matrix
data.counts <- Read10X(data.dir = snakemake@input[[1]])
sample <- snakemake@wildcards[["sample"]]
params <- snakemake@config[["samples"]][[sample]]
# Create Seurat object
data.seurat <- CreateSeuratObject(counts = data.counts, project = sample)
# Add mitochondrial read percentage
data.seurat[["percent.mt"]] <- PercentageFeatureSet(data.seurat, pattern = "^MT-")

saveRDS(data.seurat, file = snakemake@output[[1]])
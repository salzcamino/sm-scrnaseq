#!/usr/bin/env Rscript
library(Seurat)
# Read 10X data into counts matrix
data.counts <- Read10X(data.dir = snakemake@input[[1]])
sample <- snakemake@wildcards[["sample"]]

# Create Seurat object
data.seurat <- CreateSeuratObject(counts = data.counts, project = sample)
# Add mitochondrial, ribosomal, and hemoglobin read percentage
data.seurat[["percent.mt"]] <- PercentageFeatureSet(data.seurat, pattern = "^MT-")
data.seurat[["percent.rb"]] <- PercentageFeatureSet(data.seurat, pattern = "^RPS|^RPL")
data.seurat[["percent.hb"]] <- PercentageFeatureSet(data.seurat, pattern = "^HB[^(P)]")

saveRDS(data.seurat, file = snakemake@output[[1]])
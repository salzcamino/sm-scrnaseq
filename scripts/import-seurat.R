#!/usr/bin/env Rscript
library(Seurat)
# Read 10X data into counts matrix
data.counts <- Read10X(data.dir = snakemake@input[[1]])
sample <- snakemake@wildcards[["sample"]]
params <- snakemake@config[["samples"]][[sample]]
# Create Seurat object, remove features with counts in fewer than 3 cells, remove cells with fewer than 200 features
data.seurat <- CreateSeuratObject(counts = data.counts, project = sample, min.cells = params$min_cells, min.features = params$min_genes)
# Add mitochondrial read percentage
data.seurat[["percent.mt"]] <- PercentageFeatureSet(data.seurat, pattern = "^MT-")

saveRDS(data.seurat, file = snakemake@output[[1]])
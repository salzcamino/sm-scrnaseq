#!/usr/bin/env Rscript
library(Seurat)
# Read Seurat object
data.seurat <- readRDS(snakemake@input[[1]])
sample <- snakemake@wildcards[["sample"]]
params <- snakemake@config[["samples"]][[sample]]

# Filter genes expressed in fewer than min_cells
counts <- GetAssayData(data.seurat, slot = "counts")
genes.keep <- rownames(counts)[rowSums(counts > 0) >= params$min_cells]
data.seurat <- subset(data.seurat, features = genes.keep)

# Filter cells by feature count and mitochondrial read count
data.seurat <- subset(data.seurat, subset = nFeature_RNA >= params$min_genes & nFeature_RNA < params$max_genes & percent.mt < params$max_mt_percent)

saveRDS(data.seurat, snakemake@output[[1]])

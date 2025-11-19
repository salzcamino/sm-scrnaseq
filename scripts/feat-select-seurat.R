library(Seurat)

var_features = snakemake.config["samples"][snakemake.wildcards.sample]["var_features"]

data.seurat <- readRDS(snakemake@input[[1]])
data.seurat <- FindVariableFeatures(data.seurat, selection.method = "vst", nfeatures = var_features)

saveRDS(data.seurat, snakemake@output[[1]])

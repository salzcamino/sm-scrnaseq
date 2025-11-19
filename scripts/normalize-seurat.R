library(Seurat)

data.seurat <- readRDS(snakemake@input[[1]])
data.seurat <- NormalizeData(data.seurat)

saveRDS(data.seurat, snakemake@output[[1]])

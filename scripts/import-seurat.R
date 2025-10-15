library(Seurat)
data.counts <- Read10X(data.dir = snakemake@input[[1]])
data.seurat <- CreateSeuratObject(counts = data.counts, project = "pbmc3k", min.cells = 3, min.features = 200)
saveRDS(data.seurat, file = paste0("results/seurat_import_", snakemake@wildcards[[1]], ".rds"))



library(Seurat)
# Read 10X data into counts matrix
data.counts <- Read10X(data.dir = snakemake@input[[1]])
# Create Seurat object, remove features with counts in fewer than 3 cells, remove cells with fewer than 200 features
data.seurat <- CreateSeuratObject(counts = data.counts, project = "pbmc3k", min.cells = 3, min.features = 200)
saveRDS(data.seurat, file = snakemake@output[[1]])



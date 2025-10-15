library(Seurat)
data <- readRDS(snakemake@input[[1]])
# Add mitochondrial read percentage
data[["percent.mt"]] <- PercentageFeatureSet(data, pattern = "^MT-")
# Filter object by feature count and mitochondrial read count
data <- subset(data, subset = nFeature_RNA > 200 & nFeature_RNA < 2500 & percent.mt < 5)
saveRDS(data, snakemake@output[[1]])

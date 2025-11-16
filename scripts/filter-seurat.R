library(Seurat)
# Read Seurat object
data <- readRDS(snakemake@input[[1]])
sample <- snakemake@wildcards[["sample"]]
params <- snakemake@config[["samples"]][[sample]]
# Add mitochondrial read percentage
data[["percent.mt"]] <- PercentageFeatureSet(data, pattern = "^MT-")
# Filter object by feature count and mitochondrial read count
data <- subset(data, subset = nFeature_RNA > params$min_genes & nFeature_RNA < params$max_genes & percent.mt < params$max_mt_percent)
saveRDS(data, snakemake@output[[1]])

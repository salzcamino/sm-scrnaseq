library(Seurat)
library(patchwork)
# Read Seurat object
data.seurat <- readRDS(snakemake@input[[1]])
plot1 <- VlnPlot(data.seurat, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)
plot2 <- FeatureScatter(data.seurat, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot3 <- FeatureScatter(data.seurat, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")

png(filename = snakemake@output[[1]], width = 1200, height = 1000, res = 150)
plot1 / (plot2 + plot3)
dev.off()
#!/usr/bin/snakemake

# Creates all intended outputs from the example pbmc3k dataset
rule all:
	input:
		"results/seurat_filtered_pbmc3k.rds"

# Imports matrix files into a AnnData object
rule import_scanpy:
	input:
		"data/{sample}/"
	output:
		"results/01_scanpy_import_{sample}.h5ad"
	conda:
		"envs/scanpy.yaml"
	script:
		"scripts/import-scanpy.py"

# Creates a Seurat object from the matrix, barcode, feature files
# Applies min.cell = 3, min.features = 200 
rule import_seurat:
	input:
		"data/{sample}/"
	output:
		"results/seurat_import_{sample}.rds"
	script:
		"scripts/import-seurat.R"

# Filters object after adding mitochondrial read counts
rule filter_seurat:
	input:
		"results/seurat_import_{sample}.rds"
	output:
		"results/seurat_filtered_{sample}.rds"
	script:
		"scripts/filter-seurat.R"

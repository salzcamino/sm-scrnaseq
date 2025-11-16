#!/usr/bin/snakemake

# Creates all intended outputs from the example pbmc3k dataset
rule all:
	input:
		"results/scanpy_filtered_pbmc3k.h5ad",
		"results/seurat_filtered_pbmc3k.rds"

# Imports matrix files into a AnnData object
rule import_scanpy:
	input:
		"data/{sample}/"
	output:
		"results/scanpy_import_{sample}.h5ad"
	conda:
		"envs/scanpy.yaml"
	script:
		"scripts/import-scanpy.py"

# Filters object after adding mitochondrial read counts
rule filter_scanpy:
	input:
		"results/scanpy_import_{sample}.h5ad"
	output:
		"results/scanpy_filtered_{sample}.h5ad"
	conda:
		"envs/scanpy.yaml"
	script:
		"scripts/filter-scanpy.py"

# Creates a Seurat object from the matrix, barcode, feature files
# Applies min.cell = 3, min.features = 200 
rule import_seurat:
	input:
		"data/{sample}/"
	output:
		"results/seurat_import_{sample}.rds"
	conda:
		"envs/seurat.yaml"
	script:
		"scripts/import-seurat.R"

# Filters object after adding mitochondrial read counts
rule filter_seurat:
	input:
		"results/seurat_import_{sample}.rds"
	output:
		"results/seurat_filtered_{sample}.rds"
	conda:
		"envs/seurat.yaml"
	script:
		"scripts/filter-seurat.R"


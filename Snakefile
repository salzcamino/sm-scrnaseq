#!/usr/bin/snakemake

configfile: "config.yaml"

# Creates all intended outputs from the example pbmc3k dataset
rule all:
	input:
		expand("results/scanpy_scaled_{sample}.h5ad", sample=config["samples"].keys()),
		expand("results/seurat_scaled_{sample}.rds", sample=config["samples"].keys())

# Creates QC plots for all samples
rule qc_plots:
	input:
		expand("plots/{sample}_scanpy_qc.png", sample=config["samples"].keys()),
		expand("plots/{sample}_seurat_qc.png", sample=config["samples"].keys())

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

# Creates a Seurat object from the matrix, barcode, feature files
rule import_seurat:
	input:
		"data/{sample}/"
	output:
		"results/seurat_import_{sample}.rds"
	conda:
		"envs/seurat.yaml"
	script:
		"scripts/import-seurat.R"

# Plots the QC metrics for the Scanpy object
rule qc_plots_scanpy:
	input:
		"results/scanpy_import_{sample}.h5ad"
	output:
		"plots/{sample}_scanpy_qc.png"
	conda:
		"envs/scanpy.yaml"
	script:
		"scripts/plot-qc-scanpy.py"

# Plots the QC metrics for the Seurat object
rule qc_plots_seurat:
	input:
		"results/seurat_import_{sample}.rds"
	output:
		"plots/{sample}_seurat_qc.png"
	conda:
		"envs/seurat.yaml"
	script:
		"scripts/plot-qc-seurat.R"

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

# Normalizes the Scanpy object
rule normalize_scanpy:
	input:
		"results/scanpy_filtered_{sample}.h5ad"
	output:
		"results/scanpy_normalized_{sample}.h5ad"
	conda:
		"envs/scanpy.yaml"
	script:
		"scripts/normalize-scanpy.py"

# Normalizes the Seurat object
rule normalize_seurat:
	input:
		"results/seurat_filtered_{sample}.rds"
	output:
		"results/seurat_normalized_{sample}.rds"
	conda:
		"envs/seurat.yaml"
	script:
		"scripts/normalize-seurat.R"

# Selects highly variable genes with Scanpy
rule feat_select_scanpy:
	input:
		"results/scanpy_normalized_{sample}.h5ad"
	output:
		"results/scanpy_feat_selected_{sample}.h5ad"
	conda:
		"envs/scanpy.yaml"
	script:
		"scripts/feat-select-scanpy.py"

# Selects highly variable genes with Seurat
rule feat_select_seurat:
	input:
		"results/seurat_normalized_{sample}.rds"
	output:
		"results/seurat_feat_selected_{sample}.rds"
	conda:
		"envs/seurat.yaml"
	script:
		"scripts/feat-select-seurat.R"

# Scales HVGs with Scanpy
rule scale_scanpy:
	input:
		"results/scanpy_feat_selected_{sample}.h5ad"
	output:
		"results/scanpy_scaled_{sample}.h5ad"
	conda:
		"envs/scanpy.yaml"
	script:
		"scripts/scale-scanpy.py"

# Scales HVGs with Seurat
rule scale_seurat:
	input:
		"results/seurat_feat_selected_{sample}.rds"
	output:
		"results/seurat_scaled_{sample}.rds"
	conda:
		"envs/seurat.yaml"
	script:
		"scripts/scale-seurat.R"

#!/usr/bin/snakemake
rule import_seurat:
	input:
		"data/{sample}/"
	output:
		"results/seurat_import_{sample}.rds"
	script:
		"scripts/import-seurat.R"

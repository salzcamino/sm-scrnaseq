#!/usr/bin/env python3
import scanpy as sc

adata = sc.read_h5ad(snakemake.input[0])
sample = snakemake.wildcards.sample
params = snakemake.config["samples"][sample]

sc.pp.filter_cells(adata, min_genes=params["min_genes"])
sc.pp.filter_genes(adata, min_cells=params["min_cells"])
adata = adata[adata.obs['pct_counts_mt'] < params["max_mt_percent"], :]

adata.write(snakemake.output[0])
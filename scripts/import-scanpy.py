#!/usr/bin/env python3
import scanpy as sc

adata = sc.read_10x_mtx(snakemake.input[0])
sample = snakemake.wildcards.sample
params = snakemake.config["samples"][sample]
# Create AnnData object, remove features with counts in fewer than params["min_cells"] cells, remove cells with fewer than params["min_genes"] features
adata.obs["sample"] = sample  # Add sample identity
adata.write(snakemake.output[0])
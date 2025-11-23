#!/usr/bin/env python3
import scanpy as sc

adata = sc.read_h5ad(snakemake.input[0])
sample = snakemake.wildcards.sample
params = snakemake.config["samples"][sample]

# Filter cells with fewer than min_genes
sc.pp.filter_cells(adata, min_genes=params["min_genes"])
# Filter genes with fewer than min_cells
sc.pp.filter_genes(adata, min_cells=params["min_cells"])
# Filter cells with mitchondrial read % > max_mt_percent
adata = adata[adata.obs['pct_counts_mt'] < params["max_mt_percent"], :]
# Filter cells with gene count > max_genes
adata = adata[(adata.obs['n_genes_by_counts'] < params["max_genes"]), :]

adata.write(snakemake.output[0])

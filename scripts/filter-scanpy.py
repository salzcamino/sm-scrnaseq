#!/usr/bin/env python3
import scanpy as sc

adata = sc.read_h5ad(snakemake.input[0])
sample = snakemake.wildcards.sample
params = snakemake.config["samples"][sample]
# mitochondrial genes
adata.var["mt"] = adata.var_names.str.startswith("MT-")  # "MT-" for human, "Mt-" for mouse
# ribosomal genes
adata.var["ribo"] = adata.var_names.str.startswith(("RPS", "RPL"))
# hemoglobin genes
adata.var["hb"] = adata.var_names.str.contains("^HB[^(P)]")
sc.pp.calculate_qc_metrics(adata, qc_vars=["mt", "ribo", "hb"], inplace=True, log1p=True)

sc.pp.filter_cells(adata, min_genes=params["min_genes"])
sc.pp.filter_genes(adata, min_cells=params["min_cells"])
adata = adata[adata.obs['pct_counts_mt'] < params["max_mt_percent"], :]

adata.write(snakemake.output[0])
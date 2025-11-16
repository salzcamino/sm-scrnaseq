#!/usr/bin/env python3
import scanpy as sc

adata = sc.read_10x_mtx(snakemake.input[0])
sample = snakemake.wildcards.sample
params = snakemake.config["samples"][sample]
adata.obs["sample"] = sample  # Add sample identity

# Calculate base QC metrics
adata.var["mt"] = adata.var_names.str.startswith("MT-")
adata.var["ribo"] = adata.var_names.str.startswith(("RPS", "RPL"))
adata.var["hb"] = adata.var_names.str.contains("^HB[^(P)]")
sc.pp.calculate_qc_metrics(adata, qc_vars=["mt", "ribo", "hb"], inplace=True, log1p=True)

adata.write(snakemake.output[0])
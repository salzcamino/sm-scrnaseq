#!/usr/bin/env python3
import scanpy as sc
import sys
# Redirect stderr to log file
sys.stderr = open(snakemake.log[0], "w")

adata = sc.read_h5ad(snakemake.input[0])
# Saving count data
adata.layers["counts"] = adata.X.copy()
# Normalizing to median total counts
sc.pp.normalize_total(adata)
# Logarithmize the data
sc.pp.log1p(adata)

adata.write(snakemake.output[0])

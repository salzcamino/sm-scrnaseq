#!/usr/bin/env python3
import scanpy as sc

adata = sc.read_h5ad(snakemake.input[0])
sc.pp.normalize_total(adata)
sc.pp.log1p(adata)

adata.write(snakemake.output[0])

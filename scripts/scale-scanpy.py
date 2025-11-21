#!/usr/bin/python3
import scanpy as sc

adata = sc.read_h5ad(snakemake.input[0])
sc.pp.scale(adata)

adata.write(snakemake.output[0])
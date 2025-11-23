#!/usr/bin/env python3
import scanpy as sc
import sys
# Redirect stderr to log file
sys.stderr = open(snakemake.log[0], "w")

adata = sc.read_h5ad(snakemake.input[0])
sc.pp.scale(adata)

adata.write(snakemake.output[0])
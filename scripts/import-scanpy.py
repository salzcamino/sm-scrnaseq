#!/usr/bin/env python3
import scanpy as sc

adata = sc.read_10x_mtx(snakemake.input[0])
adata.write(snakemake.output[0])
#!/usr/bin/env python3
import scanpy as sc

sample = snakemake.wildcards.sample
var_features = snakemake.config["samples"][sample]["var_features"]

adata = sc.read_h5ad(snakemake.input[0])
sc.pp.highly_variable_genes(adata, n_top_genes=var_features, batch_key="sample")
sc.pl.highly_variable_genes(adata)

adata.write(snakemake.output[0])

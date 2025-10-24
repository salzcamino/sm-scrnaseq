#!/usr/bin/env python3
import scanpy as sc

data = sc.read_10x_mtx(snakemake.input[0])
data.write(snakemake.output[0])
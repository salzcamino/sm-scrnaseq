#!/usr/bin/python3
import scanpy as sc
import matplotlib.pyplot as plt

adata = sc.read_h5ad(snakemake.input[0])

fig, axes = plt.subplots(2, 3, figsize=(15, 10))

# Top row: individual violins
sc.pl.violin(adata, "n_genes_by_counts", jitter=0.4, ax=axes[0, 0], show=False)
sc.pl.violin(adata, "total_counts", jitter=0.4, ax=axes[0, 1], show=False)
sc.pl.violin(adata, "pct_counts_mt", jitter=0.4, ax=axes[0, 2], show=False)

# Bottom row: scatter plots 
sc.pl.scatter(adata, "total_counts", "n_genes_by_counts", 
              ax=axes[1, 0], show=False)
sc.pl.scatter(adata, "total_counts", "pct_counts_mt", ax=axes[1, 1], show=False)
axes[1, 2].axis('off')  # Hide empty subplot

plt.suptitle(f"QC Metrics: {snakemake.wildcards.sample}")
plt.tight_layout()
plt.savefig(snakemake.output[0], dpi=150)

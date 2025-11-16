# sm-scrnaseq

Snakemake pipeline for scRNA-seq QC using Scanpy and Seurat.

## Pipeline DAG

```mermaid
graph LR
    A[data/sample/] --> B[import_scanpy]
    A --> C[import_seurat]

    B --> D[qc_plots_scanpy]
    B --> E[filter_scanpy]

    C --> F[qc_plots_seurat]
    C --> G[filter_seurat]

    D --> H[sample_scanpy_qc.png]
    E --> I[scanpy_filtered.h5ad]
    F --> J[sample_seurat_qc.png]
    G --> K[seurat_filtered.rds]
```

## Usage

```bash
# Generate QC plots
snakemake qc_plots --use-conda --cores 4

# Run full pipeline (import + QC plots + filtering)
snakemake --use-conda --cores 4
```

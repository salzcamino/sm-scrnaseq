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

    E --> L[normalize_scanpy]
    G --> M[normalize_seurat]

    L --> N[scanpy_normalized.h5ad]
    M --> O[seurat_normalized.rds]

    L --> P[feat_select_scanpy]
    M --> Q[feat_select_seurat]

    P --> R[scanpy_feat_selected.h5ad]
    Q --> S[seurat_feat_selected.rds]

    P --> T[scale_scanpy]
    Q --> U[scale_seurat]

    T --> V[scanpy_scaled.h5ad]
    U --> W[seurat_scaled.rds]
```

## Usage

```bash
# Generate QC plots
snakemake qc_plots --use-conda --cores 4

# Run full pipeline (import + QC plots + filtering)
snakemake --use-conda --cores 4
```

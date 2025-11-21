# sm-scrnaseq

Snakemake pipeline for scRNA-seq QC using Scanpy and Seurat.

## Pipeline DAG

```mermaid
graph TB
    subgraph Input
        DATA[("data/{sample}/")]
    end

    subgraph Scanpy["Scanpy Track"]
        IMP_SC[import_scanpy] --> QC_SC[qc_plots_scanpy]
        IMP_SC --> FILT_SC[filter_scanpy]
        FILT_SC --> NORM_SC[normalize_scanpy]
        NORM_SC --> FEAT_SC[feat_select_scanpy]
        FEAT_SC --> SCALE_SC[scale_scanpy]
    end

    subgraph Seurat["Seurat Track"]
        IMP_SR[import_seurat] --> QC_SR[qc_plots_seurat]
        IMP_SR --> FILT_SR[filter_seurat]
        FILT_SR --> NORM_SR[normalize_seurat]
        NORM_SR --> FEAT_SR[feat_select_seurat]
        FEAT_SR --> SCALE_SR[scale_seurat]
    end

    DATA --> IMP_SC
    DATA --> IMP_SR

    subgraph Outputs
        QC_SC --> QC_PNG_SC(("{sample}_scanpy_qc.png"))
        SCALE_SC --> SCALED_SC(("scanpy_scaled_{sample}.h5ad"))
        QC_SR --> QC_PNG_SR(("{sample}_seurat_qc.png"))
        SCALE_SR --> SCALED_SR(("seurat_scaled_{sample}.rds"))
    end
```

## Usage

First run the qc_plots target rule, which will produce plots of the basic QC metrics in the plots/ directory. Determine the appropriate filtering thresholds and update the config file. Proceed to run the full pipeline.

```bash
# Generate QC plots
snakemake qc_plots --use-conda --cores 4

# Run full pipeline
snakemake --use-conda --cores 4
```

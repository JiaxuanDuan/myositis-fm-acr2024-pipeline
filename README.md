# 🧠 Myositis × Fibromyalgia — Lightweight R Pipeline (ACR 2024)

**Project:** *Prevalence and Impact of Fibromyalgia in Patients with Idiopathic Inflammatory Myopathies*  
**Venue:** ACR 2024 Abstract (conference supplement)

This repository provides a **lightweight, reproducible R workflow** mirroring the statistical analysis used for the abstract.
It ships **no patient-level data** and focuses on clean structure and model logic suitable for public GitHub and hiring review.

> Run scripts under `R/models/` in order (01 → 06) after mapping your local columns in `config/config.yml` and placing a CSV in `data/`.

## Folder layout
```
R/
  functions/          # utilities (factor helpers, summarise, write CSV)
  models/             # 01_prep, 02_table1, 03_prevalence, 04_models, 05_utilization, 06_plots
config/
  config.yml          # column mappings & options
data/                 # (empty; git-ignored)
outputs/
  figures/            # generated plots
  tables/             # descriptive & model summaries
```

## Suggested dependencies
```r
install.packages(c(
  "tidyverse","yaml","janitor","table1","gtsummary","broom","broom.mixed","htmlwidgets"
))
```

## Notes
- This is a simplified skeleton for **reproducibility and code style**.
- Replace placeholder names in `config/config.yml` with your dataset's actual columns.
- No PHI or patient-level data are included.

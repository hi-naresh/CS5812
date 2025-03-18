# Framework Benchmark Performance Analysis

This repository contains an R-based data analysis project that compares and evaluates web frameworks benchmarked by [TechEmpower](https://www.techempower.com/benchmarks). The data is scraped from TechEmpower’s public results and stored in CSV files, which serve as the foundation for exploring performance, concurrency overhead, and latency characteristics of various frameworks.

---

## Data Source

All benchmark data originates from **TechEmpower’s** public benchmark results. For convenience and reproducibility, we have:
- **Scraped** the relevant performance metrics from the TechEmpower site.
- Consolidated them into **four CSV files**:
  1. `benchmark_best_performance.csv`
  2. `benchmark_data_table.csv`
  3. `benchmark_framework_overhead.csv`
  4. `benchmark_latency.csv`
  
These raw CSVs are stored in the `data/raw/` directory within the project.

---

## Motive

The primary motivation behind this project is to:
- **Practice professional data analysis** in R, following best practices for folder structure, modular code design, and reproducibility.
- **Examine framework performance** based on TechEmpower’s extensive benchmarks.
- **Identify trends and insights** regarding throughput, latency, and overhead across different frameworks and concurrency levels.

---

## Project Goals

1. **Data Cleaning & Exploration**  
   - Ingest the raw CSVs and standardize columns (e.g., converting data types, renaming inconsistent fields).  
   - Examine the distribution of throughput, concurrency levels, and framework overhead.

2. **Performance Comparison**  
   - Identify top-performing frameworks based on throughput, overhead ratios, and latency across different concurrency levels.  
   - Compare frameworks by language, platform, and other key factors documented in the CSVs.

3. **Visualization & Reporting**  
   - Use R (primarily `tidyverse` and `ggplot2`) to generate histograms, box plots, and other charts illustrating performance trends.  
   - Compile results into R Markdown reports, highlighting major findings for each metric (e.g., best performance, lowest latency).

4. **Reproducibility & Professional Workflow**  
   - Employ a clear folder structure with `data/`, `code/`, `reports/`, and `figures/`.  
   - Document functions and processes for easy collaboration and course assessment.

---

## Project Outputs

- **Cleaned Data**: After running our data-cleaning scripts, processed CSV files will be saved to `data/processed/`.
- **Figures**: All plots and visualizations produced during exploration and final reporting can be found in the `figures/` directory.
- **Reports**: 
  - **Exploratory Data Analysis** (`reports/EDA_report.Rmd`), which includes initial summary statistics and basic plots.
  - **Final Analysis** (`reports/Final_Report.Rmd`), providing a comprehensive narrative on performance rankings, latency comparisons, and overhead insights.

These outputs serve as demonstrations of analytical methods for coursework evaluation.

---

## Coursework Context

This project is developed as part of a Artificial Intelligence coursework module focusing on **real-world data pipeline practices**, from data scraping and ingestion to final reporting. By examining **TechEmpower’s real world framework benchmarks**, students gain hands-on experience with:
- Handling multiple CSVs containing interrelated performance statistics.
- Conducting exploratory data analysis and building clear results for technical and non-technical audiences.
- Employing advanced RStudio project structures and best practices (version control, environment management, markdown reporting).

## Project dir structure:

```ADSOS
├── .DS_Store
├── ADSOS.Rproj
├── README.md
├── code
│   ├── README.md
│   ├── data_cleaning.R
│   ├── helpers
│   └── main.R
├── data
│   ├── .DS_Store
│   ├── README.md
│   ├── processed
│   └── raw
│       ├── cached_queries
│       │   ├── benchmark_best_performance.csv
│       │   ├── benchmark_data_table.csv
│       │   ├── benchmark_framework_overhead.csv
│       │   └── benchmark_latency.csv
│       ├── database
│       │   ├── benchmark_best_performance.csv
│       │   ├── benchmark_data_table.csv
│       │   ├── benchmark_framework_overhead.csv
│       │   └── benchmark_latency.csv
│       ├── fortune
│       │   ├── benchmark_best_performance.csv
│       │   ├── benchmark_data_table.csv
│       │   ├── benchmark_framework_overhead.csv
│       │   └── benchmark_latency.csv
│       ├── json_serialization
│       │   ├── benchmark_best_performance.csv
│       │   ├── benchmark_data_table.csv
│       │   ├── benchmark_framework_overhead.csv
│       │   └── benchmark_latency.csv
│       ├── plaintext
│       │   ├── benchmark_best_performance.csv
│       │   ├── benchmark_data_table.csv
│       │   ├── benchmark_framework_overhead.csv
│       │   └── benchmark_latency.csv
│       ├── queries
│       │   ├── benchmark_best_performance.csv
│       │   ├── benchmark_data_table.csv
│       │   ├── benchmark_framework_overhead.csv
│       │   └── benchmark_latency.csv
│       └── updates
│           ├── benchmark_best_performance.csv
│           ├── benchmark_data_table.csv
│           ├── benchmark_framework_overhead.csv
│           └── benchmark_latency.csv
├── docs
├── figures
├── reports
│   ├── EDA_report.Rmd
│   └── Final_report.RMD
└── results
    └── README.md
```
# 01_load_data.R
# Purpose: Load and structure benchmark data from TechEmpower Framework Benchmarks

## Load Required Libraries
library(dplyr)
library(readr)
library(tidyr)
library(purrr)

## Define Data Path (relative to project root)
data_path <- file.path("data", "raw")

## List of Benchmark Test Types (Each Folder in `data/raw/`)
test_types <- c("cached_queries", "database", "fortune", 
                "json_serialization", "plaintext", "queries", "updates")

## Function to Load Data from a Specific Test Type Folder
read_benchmark_files <- function(subfolder, data_path) {
  
  # Construct folder path
  folder_path <- file.path(data_path, subfolder)
  
  # List all expected CSVs
  files <- list.files(folder_path, pattern = "*.csv", full.names = TRUE)
  
  # Read each CSV if it exists
  best_perf <- if (file.exists(file.path(folder_path, "benchmark_best_performance.csv"))) {
    read_csv(file.path(folder_path, "benchmark_best_performance.csv"), show_col_types = FALSE) %>% 
      mutate(test_type = subfolder)
  } else NULL
  
  data_table <- if (file.exists(file.path(folder_path, "benchmark_data_table.csv"))) {
    read_csv(file.path(folder_path, "benchmark_data_table.csv"), show_col_types = FALSE) %>% 
      mutate(test_type = subfolder)
  } else NULL
  
  overhead <- if (file.exists(file.path(folder_path, "benchmark_framework_overhead.csv"))) {
    read_csv(file.path(folder_path, "benchmark_framework_overhead.csv"), show_col_types = FALSE) %>% 
      mutate(test_type = subfolder)
  } else NULL
  
  latency <- if (file.exists(file.path(folder_path, "benchmark_latency.csv"))) {
    read_csv(file.path(folder_path, "benchmark_latency.csv"), show_col_types = FALSE) %>% 
      mutate(test_type = subfolder)
  } else NULL
  
  # Return a list of DataFrames
  list(
    best_perf = best_perf,
    data_table = data_table,
    overhead = overhead,
    latency = latency
  )
}

## Iterate Over Test Types & Load Data
all_data <- map(test_types, ~ read_benchmark_files(.x, data_path))

## Convert List into a Structured DataFrame
combined_best_perf <- bind_rows(map(all_data, "best_perf"))
combined_data_table <- bind_rows(map(all_data, "data_table"))
combined_overhead <- bind_rows(map(all_data, "overhead"))
combined_latency <- bind_rows(map(all_data, "latency"))


## Save Loaded Data to Processed Folder (for easy access in next steps)
write_csv(combined_best_perf, "data/processed/benchmark_best_performance.csv")
write_csv(combined_data_table, "data/processed/benchmark_data_table.csv")
write_csv(combined_overhead, "data/processed/benchmark_framework_overhead.csv")
write_csv(combined_latency, "data/processed/benchmark_latency.csv")

## Print Summary
message("✅ Data successfully loaded and saved to `data/processed/`.")



## merge performance and best performance column in combined_best_perf$Performance (higher is better) and combined_best_perf$`Best Performance (higher is better)` and rename it to only performance
df = pd.read_csv("benchmark_best_performance.csv")

df["performance"] = df[["performance (higher is better)", "best performance"]].max(axis=1)

# 3. (Optional) Drop the original two columns if you no longer need them
df.drop(columns=["performance (higher is better)", "best performance"], inplace=True)

# 4. Save the updated DataFrame to a new CSV (or overwrite the original)
df.to_csv("benchmark_combined_performance.csv", index=False)
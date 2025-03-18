# 02_clean_data.R
# Purpose: Clean and preprocess the loaded benchmark data

# 🔹 Load Required Libraries
library(dplyr)
library(readr)
library(stringr)

# 🔹 Define Processed Data Path
processed_path <- "data/processed"

# 🔹 Load Processed CSVs
best_perf <- read_csv(file.path(processed_path, "benchmark_best_performance.csv"), show_col_types = FALSE)
data_table <- read_csv(file.path(processed_path, "benchmark_data_table.csv"), show_col_types = FALSE)
overhead <- read_csv(file.path(processed_path, "benchmark_framework_overhead.csv"), show_col_types = FALSE)
latency <- read_csv(file.path(processed_path, "benchmark_latency.csv"), show_col_types = FALSE)

# 🔹 Standardize Column Names (convert to snake_case)
clean_colnames <- function(df) {
  colnames(df) <- colnames(df) %>%
    str_replace_all(" ", "_") %>%   # Replace spaces with underscores
    str_replace_all("-", "_") %>%   # Replace dashes with underscores
    str_to_lower()                  # Convert to lowercase
  return(df)
}

best_perf <- clean_colnames(best_perf)
data_table <- clean_colnames(data_table)
overhead <- clean_colnames(overhead)
latency <- clean_colnames(latency)

# 🔹 Handling Missing Values
handle_na <- function(df) {
  df %>%
    filter(complete.cases(.)) %>%  # Remove rows with NA values
    mutate_all(~ ifelse(is.na(.), "Unknown", .)) # Replace remaining NAs
}

best_perf <- handle_na(best_perf)
data_table <- handle_na(data_table)
overhead <- handle_na(overhead)
latency <- handle_na(latency)

# 🔹 Convert Numeric Columns
numeric_cols <- c("best_performance", "performance_percent", "http_500_errors", "score", "latency_percent",
                  "average_latency", "max_latency", "standard_deviation")

convert_numeric <- function(df, num_cols) {
  df %>%
    mutate(across(all_of(num_cols), as.numeric, .names = "numeric_{col}"), .keep = "all")
}

best_perf <- convert_numeric(best_perf, c("best_performance", "performance_percent", "http_500_errors"))
data_table <- convert_numeric(data_table, c("best_performance_across_all_concurrency_levels", "http_500_errors"))
overhead <- convert_numeric(overhead, c("score", "ratio"))
latency <- convert_numeric(latency, c("average_latency", "latency_percent", "max_latency", "standard_deviation"))

# 🔹 Convert Categorical Columns
categorical_cols <- c("framework", "classification", "language", "platform", "front_end_server", 
                      "database_server", "database_operating_system", "test_type")

convert_factors <- function(df, cat_cols) {
  df %>%
    mutate(across(all_of(cat_cols), as.factor, .names = "factor_{col}"), .keep = "all")
}

best_perf <- convert_factors(best_perf, categorical_cols)
data_table <- convert_factors(data_table, categorical_cols)
overhead <- convert_factors(overhead, categorical_cols)
latency <- convert_factors(latency, categorical_cols)

# # 🔹 Handle Outliers (Using IQR for Key Numeric Columns)
# remove_outliers <- function(df, col) {
#   Q1 <- quantile(df[[col]], 0.25, na.rm = TRUE)
#   Q3 <- quantile(df[[col]], 0.75, na.rm = TRUE)
#   IQR <- Q3 - Q1
#   lower_bound <- Q1 - 1.5 * IQR
#   upper_bound <- Q3 + 1.5 * IQR
#   df %>%
#     filter(df[[col]] >= lower_bound & df[[col]] <= upper_bound)
# }
# 
# # Remove outliers in key performance metrics
# best_perf <- remove_outliers(best_perf, "best_performance")
# data_table <- remove_outliers(data_table, "best_performance_across_all_concurrency_levels")
# latency <- remove_outliers(latency, "average_latency")

# 🔹 Save Cleaned Data to Processed Folder
write_csv(best_perf, file.path(processed_path, "cleaned_best_performance.csv"))
write_csv(data_table, file.path(processed_path, "cleaned_data_table.csv"))
write_csv(overhead, file.path(processed_path, "cleaned_framework_overhead.csv"))
write_csv(latency, file.path(processed_path, "cleaned_latency.csv"))

# 🔹 Print Summary
message("✅ Data successfully cleaned and saved to `data/processed/`.") 

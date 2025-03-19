# Load necessary library
library(dplyr) 

# Read the CSV files
performance_data <- read.csv("benchmark_best_performance.csv")
latency_data <- read.csv("benchmark_latency.csv")

# Merge the datasets on the 'Framework' column (assuming it's the key)
merged_data <- merge(performance_data, latency_data, by = "Framework", all = TRUE)

# View the first few rows of merged data
head(merged_data)

# Save the merged dataset to a new CSV file
write.csv(merged_data, "merged_benchmark_data.csv", row.names = FALSE)

summary(merged_data)
dim(merged_data)
dim(performance_data)
dim(latency_data)

# Check for missing values
sum(is.na(merged_data))
sum(is.na(performance_data))
sum(is.na(latency_data))

# Check for duplicated rows
duplicated_rows <- merged_data[duplicated(merged_data), ]
duplicated_rows

# sort the data by Rnk
sorted_data <- merged_data %>% arrange(Rnk)
head(sorted_data)

table(merged_data$Classification)
table(performance_data$Classification)
table(performance_data$Implementation.approach)

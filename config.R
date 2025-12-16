# Configuration for Tiger and Leopard Image Data Analysis

# Database Connection
# DSN name configured in ODBC
DB_DSN <- "leopard_db"

# File Paths
# Input files containing raw capture data
TIGER_DATA_FILE <- "Animal_cature_details.csv"
LEOPARD_DATA_FILE <- "leopard_capture_details.csv"

# Output file for cumulative analysis script (cum_animals.R)
# Changed from 'leopard_capture_details.csv' to avoid overwriting raw input data
CUMULATIVE_OUTPUT_FILE <- "cumulative_animal_counts.csv"

# Analysis Parameters
# Capture Method (CPMD) to filter for (e.g., "CT" for Camera Trap)
TARGET_CPMD <- "CT"

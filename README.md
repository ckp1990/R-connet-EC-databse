# Tiger and Leopard Image Data Analysis

This repository contains R scripts and data for analyzing camera trap images of tigers and leopards from the ExtractCompare database.

## Files

*   **`config.R`**: Configuration file storing file paths, database DSN names, and analysis parameters. Edit this file to change settings without modifying the code.
*   **`Descriptive_stat_of_tiger.Rmd`**: An R Markdown file that generates a descriptive statistical report of the tiger and leopard image data. It produces charts and tables regarding the number of images, individuals, side of capture (flank), time of capture, and site distribution.
*   **`Fetch_data_from_database.R`**: Contains a function `extract_data` to connect to an MS Access database via ODBC and fetch capture details.
*   **`cum_animals.R`**: A script that utilizes `Fetch_data_from_database.R` to fetch data from the database and calculate the cumulative number of new animals per season per site.
    *   **Output**: Writes summary data to `cumulative_animal_counts.csv` (configured in `config.R`).
*   **`Animal_cature_details.csv`**: Raw capture data for Tigers. Used as input for `Descriptive_stat_of_tiger.Rmd`.
*   **`leopard_capture_details.csv`**: Raw capture data for Leopards. Used as input for `Descriptive_stat_of_tiger.Rmd`.

## Workflow

To run the analysis and generate the report, follow these steps:

### 1. Prerequisites

Ensure you have R installed along with the following packages:
*   `dplyr`
*   `ggplot2`
*   `gridExtra`
*   `tidyr`
*   `lubridate`
*   `data.table`
*   `knitr`
*   `odbc`
*   `DBI`

If you intend to fetch fresh data from the MS Access database, you must configure an ODBC Data Source Name (DSN) matching the `DB_DSN` in `config.R` (default: `leopard_db`).

### 2. Configuration

Review and edit `config.R` to match your environment, specifically:
*   `DB_DSN`: Your ODBC Data Source Name.
*   `TIGER_DATA_FILE` & `LEOPARD_DATA_FILE`: Paths to your input CSV files.
*   `CUMULATIVE_OUTPUT_FILE`: Path for the output of the cumulative analysis script.

### 3. Data Extraction (Optional)

If you have access to the database and want to update the cumulative animal counts:

1.  Ensure your ODBC connection is set up.
2.  Run `source("cum_animals.R")` in R.
    *   This will fetch data and write the cumulative counts to the file specified in `config.R` (default: `cumulative_animal_counts.csv`).

### 4. Report Generation

To generate the descriptive statistics report:

1.  Ensure the raw data files (`Animal_cature_details.csv` and `leopard_capture_details.csv`) are present and valid.
2.  Open `Descriptive_stat_of_tiger.Rmd` in RStudio or use `rmarkdown::render`.
3.  Knit the document to your desired format (Word, HTML, PDF).

## Notes

*   The code has been updated to use a configuration file (`config.R`) to avoid hard-coding filenames and parameters.
*   The `cum_animals.R` script now outputs to a separate file by default to prevent accidental overwriting of the input data required for the R Markdown report.

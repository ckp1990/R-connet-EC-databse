# Tiger and Leopard Image Data Analysis

This repository contains R scripts and data for analyzing camera trap images of tigers and leopards from the ExtractCompare database.

## Files

*   **`Descriptive_stat_of_tiger.Rmd`**: An R Markdown file that generates a descriptive statistical report of the tiger and leopard image data. It produces charts and tables regarding the number of images, individuals, side of capture (flank), time of capture, and site distribution.
*   **`Fetch_data_from_database.R`**: Contains a function `extract_data` to connect to an MS Access database via ODBC and fetch capture details.
*   **`cum_animals.R`**: A script that utilizes `Fetch_data_from_database.R` to fetch data from the database (DSN "leopard_db") and calculate the cumulative number of new animals per season per site.
    *   **Note**: This script currently writes its output (summary data) to `leopard_capture_details.csv`.
*   **`Animal_cature_details.csv`**: Raw capture data for Tigers. Used as input for `Descriptive_stat_of_tiger.Rmd`.
*   **`leopard_capture_details.csv`**: Intended to be the raw capture data for Leopards.
    *   **Warning**: If `cum_animals.R` is run, it overwrites this file with summary data, which is incompatible with `Descriptive_stat_of_tiger.Rmd`. Ensure you have a backup of the raw leopard data or adjust the script output filename if you intend to run the analysis report.

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

If you intend to fetch fresh data from the MS Access database, you must configure an ODBC Data Source Name (DSN) named `leopard_db` pointing to your database.

### 2. Data Extraction (Optional)

If you have access to the database and want to update the cumulative animal counts:

1.  Open `cum_animals.R`.
2.  Ensure your ODBC connection is set up.
3.  Run the script.
    *   **Caution**: This script writes to `leopard_capture_details.csv`. This file is also used as input for the `Descriptive_stat_of_tiger.Rmd` report but expects a different format (raw data vs summary data). Running this script may break the report generation unless the file is renamed or restored.

### 3. Report Generation

To generate the descriptive statistics report:

1.  Ensure `Animal_cature_details.csv` (Tiger data) and `leopard_capture_details.csv` (Leopard data) are present in the directory and contain the raw capture details (columns: `id`, `dt`, `image`, `time_seen`, `location`, `site`, `CPMD`, `side`, `season`).
2.  Open `Descriptive_stat_of_tiger.Rmd` in RStudio or use `rmarkdown::render`.
3.  Knit the document to your desired format (Word, HTML, PDF).

## Known Issues

*   **File Overwriting**: `cum_animals.R` outputs summary data to `leopard_capture_details.csv`, overwriting the raw data file expected by `Descriptive_stat_of_tiger.Rmd`. Users should be careful when running `cum_animals.R` to avoid losing the input data for the report.

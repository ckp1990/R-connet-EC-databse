# Load configuration and helper functions
source("config.R")
source("Fetch_data_from_database.R")

# Check required packages
if (!requireNamespace("dplyr", quietly = TRUE)) {
  stop("Package 'dplyr' is required but not installed.")
}
library(dplyr)

# Extract data from database
# Use the configured DSN
capture_data <- tryCatch({
  extract_data(DB_DSN)
}, error = function(e) {
  warning("Could not fetch data from database. Please check ODBC connection '", DB_DSN, "'.")
  stop(e)
})

# Process data
if (!is.null(capture_data)) {
  # Filter for target capture method (e.g., "CT" for Camera Trap)
  capture_data <- capture_data[capture_data$CPMD == TARGET_CPMD, ]

  # Remove duplicates
  capture_data <- capture_data[!duplicated(capture_data), ]

  # Filter out rows with missing season
  capture_data <- capture_data[!is.na(capture_data$season), ]

  season_levels <- unique(capture_data$season)

  # Function to calculate cumulative change in individuals per site
  cumulative_change <- function(data, site) {
    required_dF <- data[data$site == site, ]
    se <- unique(data$season)
    # Ensure season is ordered correctly if possible, otherwise use appearance order
    se <- ordered(se, levels = se)

    to_fill <- rep(NA, length(se))
    ind_un <- c() # Initialize empty vector for unique individuals

    for (i in seq_along(se)) {
      n <- se[i]
      season_df <- required_dF[required_dF$season == n, ]

      if (nrow(season_df) != 0) {
        # Identify new individuals in this season
        current_season_inds <- unique(season_df$id)
        # Update list of all individuals seen so far
        ind_un_updated <- unique(c(ind_un, current_season_inds))

        # New individuals count = Total unique so far - Total unique before this season
        new_inds_count <- length(ind_un_updated) - length(ind_un)
        to_fill[i] <- new_inds_count

        # Update for next iteration
        ind_un <- ind_un_updated
      } else {
        to_fill[i] <- 0
      }
    }
    return(to_fill)
  }

  se <- unique(capture_data$season)
  sites <- unique(capture_data$site)

  site_check_data <- data.frame(season = se)

  for (n in sites) {
    add_col <- cumulative_change(capture_data, n)
    site_check_data[[n]] <- add_col
  }

  # Write summary data to output file defined in config
  write.csv(site_check_data, CUMULATIVE_OUTPUT_FILE, row.names = FALSE)
  message(paste("Cumulative animal counts written to:", CUMULATIVE_OUTPUT_FILE))
}

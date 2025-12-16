extract_data <- function(connection_name, query = NULL) {
  # Load required libraries
  if (!requireNamespace("odbc", quietly = TRUE)) {
    stop("Package 'odbc' is required but not installed.")
  }
  if (!requireNamespace("DBI", quietly = TRUE)) {
    stop("Package 'DBI' is required but not installed.")
  }

  library(odbc)
  library(DBI)

  # Default query if not provided
  if (is.null(query)) {
    query <- "SELECT id, dt, image, time_seen, location, site, CPMD, side, season FROM Capture_Details"
  }

  # Establish connection
  tryCatch({
    connectionName <- dbConnect(odbc(), connection_name)
  }, error = function(e) {
    stop(paste("Failed to connect to database DSN:", connection_name, "\nError:", e$message))
  })

  # Execute query and fetch data
  tryCatch({
    capture_TDB_OP <- dbSendQuery(connectionName, query)
    result_data <- dbFetch(capture_TDB_OP)
    dbClearResult(capture_TDB_OP)
    dbDisconnect(connectionName)
    return(result_data)
  }, error = function(e) {
    dbDisconnect(connectionName) # Ensure disconnection on error
    stop(paste("Error during query execution or data fetch:\n", e$message))
  })
}

# Figure 3.18 - Sequential CSV processing baseline
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example establishes a baseline for sequential (single-threaded)
# CSV processing. Compare the execution time with parallel processing
# in Figures 3.19-3.22 to understand the performance benefits of
# multi-threading for I/O-bound and CPU-bound operations.

# ============================================================================
# SEQUENTIAL CSV PROCESSING FUNCTION
# ============================================================================

function Process-Csv {
    param(
        [string]$CsvPath
    )

    # Import the entire CSV file into memory
    $CsvData = Import-Csv -Path $CsvPath

    # Process each row sequentially (one at a time)
    $Results = @()
    foreach ($Row in $CsvData) {
        # Extract the Name field from each row
        # This simulates some processing work per row
        $Results += $Row.Name
    }

    return $Results
}

# ============================================================================
# MEASURE EXECUTION TIME
# ============================================================================

# Measure-Command captures the time taken to execute a script block
# This is essential for performance benchmarking

# Uncomment to see the actual output:
# Process-Csv -CsvPath .\organizations-100000.csv

# Uncomment to store results:
# $Data = Process-Csv -CsvPath .\organizations-100000.csv

# Measure execution time (output only shows timing)
Measure-Command { Process-Csv -CsvPath .\organizations-100000.csv }

# ============================================================================
# EXPECTED OUTPUT AND KEY CONCEPTS
# ============================================================================

# Expected Output (timing will vary based on system):
# Days              : 0
# Hours             : 0
# Minutes           : 0
# Seconds           : 45
# Milliseconds      : 234
# Ticks             : 452340000
# TotalDays         : 0.000523541666666667
# TotalHours        : 0.012565
# TotalMinutes      : 0.7539
# TotalSeconds      : 45.234
# TotalMilliseconds : 45234

# KEY CONCEPTS:
# - Sequential processing handles one row at a time
# - All work happens on a single thread
# - Simple to understand and debug
# - No overhead from thread management
# - BUT: Cannot utilize multiple CPU cores

# PERFORMANCE CHARACTERISTICS:
# - For 100,000 rows: typically 30-60 seconds
# - CPU utilization: ~25% on a 4-core system (1 core busy)
# - Scales linearly: 2x rows = 2x time

# WHEN TO USE SEQUENTIAL:
# - Small datasets (< 10,000 rows)
# - Simple operations with no I/O wait
# - When debugging or developing logic
# - When order of processing matters

# Compare with parallel processing in Figures 3.19-3.22 to see
# how multi-threading can dramatically reduce processing time
# for large datasets.

# Recipe: JSON Logging with Compressed Output
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates creating compressed JSON log entries for structured logging.

# ============================================================================
# CREATE LOG ENTRY
# ============================================================================

# Define a log entry as a hashtable
$Log = @{
    Timestamp = "01-01-2023 10:00:00"
    Level     = "INFO"
    Message   = "This is a log message"
}

# ============================================================================
# CONVERT TO COMPRESSED JSON AND SAVE
# ============================================================================

# -Compress outputs single-line JSON without whitespace
# This is ideal for log files (one entry per line)
$Log | ConvertTo-Json -Compress | Out-File C:\Temp\JsonLog.json

# ============================================================================
# VIEW THE LOG FILE
# ============================================================================

Get-Content C:\Temp\JsonLog.json

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# {"Timestamp":"01-01-2023 10:00:00","Level":"INFO","Message":"This is a log message"}

# ============================================================================
# BENEFITS OF JSON LOGGING
# ============================================================================

# - Machine-parseable: Easy to process with tools like jq, Log Analytics
# - Structured: Each field is queryable
# - Extensible: Add new fields without breaking existing parsers
# - Line-delimited: Each log entry on its own line for streaming

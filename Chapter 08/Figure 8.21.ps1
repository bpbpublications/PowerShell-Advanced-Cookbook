# Figure 8.21 - ConvertTo-Json with Compress Parameter
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates compressed JSON output for logging and API payloads.

# ============================================================================
# LOG ENTRY OBJECT
# ============================================================================

$Log = @{
    Timestamp = "01-01-2023 10:00:00"
    Level     = "INFO"
    Message   = "This is a log message"
}

# ============================================================================
# CONVERT WITH COMPRESS PARAMETER
# ============================================================================

# -Compress removes all whitespace (spaces, newlines, indentation)
# Produces single-line JSON - ideal for log files and API requests
$Log | ConvertTo-Json -Compress | Out-File C:\Temp\JsonLog.json

# View the compressed output
Get-Content C:\Temp\JsonLog.json

# ============================================================================
# USE CASES FOR COMPRESSED JSON
# ============================================================================

# - Log files: One JSON entry per line enables easy parsing
# - API payloads: Smaller size, faster transmission
# - Streaming data: Line-delimited JSON (NDJSON/JSON Lines format)
# - Storage: Reduced file size for large datasets

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# {"Timestamp":"01-01-2023 10:00:00","Level":"INFO","Message":"This is a log message"}
#
# Note: All on one line with no extra whitespace

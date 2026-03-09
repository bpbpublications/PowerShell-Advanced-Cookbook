# Figure 5.24 - Using Functions from an Imported Module
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates using functions from a module after importing it.

# ============================================================================
# PREREQUISITES
# ============================================================================

# Navigate to the parent directory and import the module
Set-Location ".\Modules"
Import-Module .\Logging

# ============================================================================
# USE MODULE FUNCTION
# ============================================================================

# Call the exported function from the Logging module
# Parameters:
# - LogFilePath: Path to the JSON log file
# - Message: The message to log
# - LogLevel: Severity level (INFO, WARNING, ERROR, etc.)
# - Compress: Switch to output compact JSON (no whitespace)
# - Verbose: Switch to show verbose output
Add-LogToJson -LogFilePath C:\Temp\TestLog.json -Message "This is a test" -LogLevel INFO -Compress -Verbose

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# VERBOSE: Logfile created: C:\Temp\TestLog.json
# VERBOSE: Successfully written log to file: C:\Temp\TestLog.json
# VERBOSE: 12-01-2026 14:30:45,123 - INFO : This is a test

# Contents of C:\Temp\TestLog.json:
# {"timestamp":"12-01-2026 14:30:45,123","message":"This is a test","level":"INFO"}

# ============================================================================
# LOG LEVELS
# ============================================================================

# Available log levels (ValidateSet in function):
# - INFO     : Informational messages
# - WARNING  : Warning conditions
# - ERROR    : Error conditions
# - CRITICAL : Critical failures
# - DEBUG    : Debug-level messages
# - OK       : Success messages

# ============================================================================
# ADDITIONAL EXAMPLES
# ============================================================================

# Log with additional custom fields:
# Add-LogToJson -LogFilePath C:\Temp\TestLog.json `
#     -Message "User login failed" `
#     -LogLevel ERROR `
#     -Adds @{
#         "username" = "john.doe"
#         "ipaddress" = "192.168.1.100"
#         "action" = "login"
#     }

# Log multiple messages:
# @("Starting process", "Processing data", "Process complete") | ForEach-Object {
#     Add-LogToJson -LogFilePath C:\Temp\TestLog.json -Message $_ -LogLevel INFO
# }


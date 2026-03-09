# Figure 4.6 - ErrorActionPreference Stop Halts Execution
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates how "Stop" converts non-terminating errors into
# terminating errors, halting script execution at the point of failure.

# ============================================================================
# ERRORACTIONPREFERENCE = "STOP"
# ============================================================================

# Setting to "Stop" makes ALL errors terminating
$ErrorActionPreference = "Stop"

# This will throw a TERMINATING error and stop execution
Get-Content -Path "NonExistingFile.txt"

# This line will NEVER execute because the error above
# terminates the script (no try/catch to handle it)
Write-Output "Outputs error. Script execution does not continue"

# ============================================================================
# STOP BEHAVIOR ANALYSIS
# ============================================================================

# WITH STOP:
# 1. Error message is displayed
# 2. Script execution HALTS immediately
# 3. Subsequent commands do NOT run
# 4. Error can be caught with try/catch

# CONTRAST WITH CONTINUE (Figure 4.5):
# - Continue: Error shown, script continues
# - Stop: Error shown, script STOPS

# ============================================================================
# RECOMMENDED PATTERN
# ============================================================================

# In production scripts, combine "Stop" with try/catch:
#
# $ErrorActionPreference = "Stop"
# try {
#     Get-Content -Path "NonExistingFile.txt"
#     Write-Output "This only runs if file exists"
# }
# catch {
#     Write-Output "File not found: $_"
#     # Handle the error appropriately
# }
# Write-Output "This runs regardless (after try/catch)"

# This pattern gives you:
# - Reliable error detection
# - Explicit error handling
# - Continued execution after handling

# Expected Output:
# Get-Content: Cannot find path '...\NonExistingFile.txt' because it does not exist.
# (Script terminates - no further output)

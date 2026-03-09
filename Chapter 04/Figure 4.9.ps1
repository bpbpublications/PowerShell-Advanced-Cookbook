# Figure 4.9 - ErrorActionPreference Ignore
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates "Ignore" which completely suppresses errors
# and does NOT record them in the $Error variable.

# ============================================================================
# ERRORACTIONPREFERENCE = "IGNORE"
# ============================================================================

# Errors are completely ignored - not displayed, not recorded
$ErrorActionPreference = "Ignore"

# This error is completely suppressed
Get-Content -Path "NonExistingFile.txt"

# Execution continues with no trace of the error
Write-Output "Ignores all errors. Script execution continues"

# ============================================================================
# IGNORE VS SILENTLYCONTINUE
# ============================================================================

# SILENTLYCONTINUE:
# - Error NOT displayed
# - Error IS recorded in $Error variable
# - $? is set to $false
# - You can still detect the error occurred

# IGNORE:
# - Error NOT displayed
# - Error NOT recorded in $Error
# - $? is STILL set to $false
# - No trace of the error exists (except $?)

# ============================================================================
# DEMONSTRATING THE DIFFERENCE
# ============================================================================

# With SilentlyContinue:
# $Error.Clear()
# $ErrorActionPreference = "SilentlyContinue"
# Get-Content "NonExistingFile.txt"
# $Error.Count  # Returns 1 - error was recorded

# With Ignore:
# $Error.Clear()
# $ErrorActionPreference = "Ignore"
# Get-Content "NonExistingFile.txt"
# $Error.Count  # Returns 0 - no error recorded

# ============================================================================
# WHEN TO USE IGNORE
# ============================================================================

# VERY LIMITED USE CASES:
# - Truly insignificant errors you never want to see
# - Performance-critical code where $Error growth matters
# - Specific known errors that provide no value

# CAUTION:
# - You lose ALL ability to detect the error
# - Debugging becomes very difficult
# - Use sparingly and with clear justification

# BETTER ALTERNATIVES:
# - SilentlyContinue (can still check $Error)
# - -ErrorAction Ignore on specific commands
# - try/catch with empty catch block

# Expected Output:
# Ignores all errors. Script execution continues
# (No error message, no error in $Error)

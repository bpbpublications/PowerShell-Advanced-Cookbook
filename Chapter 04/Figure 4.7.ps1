# Figure 4.7 - ErrorActionPreference SilentlyContinue
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates "SilentlyContinue" which suppresses error display
# while allowing script execution to continue.

# ============================================================================
# ERRORACTIONPREFERENCE = "SILENTLYCONTINUE"
# ============================================================================

# Errors are suppressed (not displayed) but script continues
$ErrorActionPreference = "SilentlyContinue"

# This generates an error that will NOT be displayed
Get-Content -Path "NonExistingFile.txt"

# Execution continues as if nothing happened
Write-Output "No error output. Script execution continues"

# ============================================================================
# SILENTLYCONTINUE BEHAVIOR
# ============================================================================

# WITH SILENTLYCONTINUE:
# 1. Error message is NOT displayed
# 2. Error IS still recorded in $Error variable
# 3. Script continues to next statement
# 4. $? is set to $false after the error

# CHECKING FOR SILENT ERRORS:
# $ErrorActionPreference = "SilentlyContinue"
# Get-Content "NonExistingFile.txt"
# if (-not $?) {
#     Write-Output "An error occurred (check `$Error[0])"
# }

# ============================================================================
# WHEN TO USE SILENTLYCONTINUE
# ============================================================================

# GOOD USE CASES:
# - Testing if a resource exists (Test-Path is better though)
# - Optional operations where failure is acceptable
# - Suppressing expected errors in known scenarios
# - Cleanup operations where errors don't matter

# BAD USE CASES:
# - Critical operations (errors go unnoticed)
# - Debugging (can't see what failed)
# - Production scripts (prefer explicit handling)

# ============================================================================
# ACCESSING SUPPRESSED ERRORS
# ============================================================================

# Even with SilentlyContinue, you can check errors:
#
# $Error.Clear()                              # Clear error history
# $ErrorActionPreference = "SilentlyContinue"
# Get-Content "NonExistingFile.txt"
# if ($Error.Count -gt 0) {
#     Write-Output "Error was: $($Error[0].Exception.Message)"
# }

# Expected Output:
# No error output. Script execution continues
# (Note: No error message is displayed)

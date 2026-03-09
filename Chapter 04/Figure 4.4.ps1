# Figure 4.4 - Setting ErrorActionPreference to Stop
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This shows how to set $ErrorActionPreference to "Stop", which converts
# all non-terminating errors into terminating errors. This is essential
# for scripts where you need reliable error handling with try/catch.

# ============================================================================
# ERRORACTIONPREFERENCE = "STOP"
# ============================================================================

# Setting the preference variable affects ALL subsequent commands
# in the current scope (script, function, or session)
$ErrorActionPreference = "Stop"

# KEY BEHAVIOR:
# - Non-terminating errors become terminating
# - Script execution halts at the first error
# - Errors can be caught with try/catch
# - This is the RECOMMENDED setting for production scripts

# ============================================================================
# WHY USE "STOP"?
# ============================================================================

# Without "Stop", many cmdlets produce non-terminating errors that:
# 1. Display an error message
# 2. Continue executing the next command
# 3. CANNOT be caught by try/catch (by default)

# With "Stop":
# 1. All errors become terminating
# 2. Script stops at the error (unless caught)
# 3. try/catch blocks can handle the error
# 4. You have PREDICTABLE error behavior

# ============================================================================
# COMPARISON OF ERROR TYPES
# ============================================================================

# TERMINATING ERRORS (always stop execution):
# - throw statements
# - [ValidateScript] failures
# - Missing mandatory parameters
# - Syntax errors

# NON-TERMINATING ERRORS (continue by default):
# - File not found (Get-Content, Get-ChildItem)
# - Permission denied
# - Network errors
# - Most cmdlet failures

# $ErrorActionPreference = "Stop" converts the second category
# into the first, giving you consistent error handling.

# Expected Output:
# (No output - this just sets the preference)

# USAGE PATTERN:
# $ErrorActionPreference = "Stop"
# try {
#     Get-Content "NonExistentFile.txt"  # Now terminating!
# }
# catch {
#     Write-Output "Caught: $_"
# }

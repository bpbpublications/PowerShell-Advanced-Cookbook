# Figure 4.5 - ErrorActionPreference Continue (Default Behavior)
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates the default ErrorActionPreference value "Continue",
# which displays errors but allows script execution to proceed.

# ============================================================================
# ERRORACTIONPREFERENCE = "CONTINUE" (DEFAULT)
# ============================================================================

# "Continue" is PowerShell's default - errors display but don't stop execution
$ErrorActionPreference = "Continue"

# Attempt to read a file that doesn't exist
# This generates a non-terminating error
Get-Content -Path "NonExistingFile.txt"

# This line WILL execute despite the error above
Write-Output "Outputs error. Script execution continues"

# ============================================================================
# CONTINUE BEHAVIOR ANALYSIS
# ============================================================================

# WITH CONTINUE:
# 1. Error message is displayed to the console (red text)
# 2. Error is added to $Error automatic variable
# 3. Script continues to next statement
# 4. try/catch will NOT catch this error

# WHEN TO USE CONTINUE:
# - Interactive sessions (explore without stopping)
# - Scripts where some failures are acceptable
# - When you want to process as much as possible
# - Batch operations where partial success is OK

# CAUTION:
# - Errors may go unnoticed in automated scripts
# - Dependent operations may fail with confusing errors
# - $LASTEXITCODE and $? may not reflect the issue

# Expected Output:
# Get-Content: Cannot find path 'C:\...\NonExistingFile.txt' because it does not exist.
# Outputs error. Script execution continues

# ============================================================================
# KEY INSIGHT
# ============================================================================

# The default "Continue" behavior is designed for interactive use,
# NOT for production scripts. In production, prefer "Stop" with
# proper try/catch handling to ensure errors are handled explicitly.

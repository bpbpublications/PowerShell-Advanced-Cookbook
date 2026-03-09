# Figure 4.10 - Cmdlet-Level ErrorAction Overrides Global Preference
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates how the -ErrorAction parameter on individual cmdlets
# overrides the global $ErrorActionPreference setting.

# ============================================================================
# ERRORACTION PARAMETER VS ERRORACTIONPREFERENCE
# ============================================================================

# Set global preference to Stop (all errors terminate)
$ErrorActionPreference = "Stop"

try {
    # -------------------------------------------------------------------------
    # FIRST COMMAND: -ErrorAction SilentlyContinue
    # -------------------------------------------------------------------------
    # This OVERRIDES the global "Stop" setting for this command only
    # Error is suppressed, and since it's not terminating, catch doesn't trigger
    Get-Content -Path "NonExistingFile.txt" -ErrorAction SilentlyContinue
    Write-Output "Does not get caught. Overrides global behavior"

    # -------------------------------------------------------------------------
    # SECOND COMMAND: Uses global ErrorActionPreference
    # -------------------------------------------------------------------------
    # No -ErrorAction specified, so uses global "Stop"
    # This WILL terminate and be caught
    Get-Content -Path "NonExistingFile.txt"
    Write-Output "Gets caught due to ErrorActionPreference"
}
catch {
    # Only catches the second error (first was SilentlyContinue)
    Write-Output "Caught error. ErrorActionPreference=$ErrorActionPreference"
}

# ============================================================================
# KEY CONCEPTS
# ============================================================================

# PRECEDENCE (highest to lowest):
# 1. -ErrorAction parameter (cmdlet level)
# 2. $ErrorActionPreference variable (scope level)
# 3. Default value ("Continue")

# CMDLET ERRORACTION VALUES:
# - Continue        : Display error, continue
# - Stop            : Terminate, can be caught
# - SilentlyContinue: Suppress error, continue
# - Ignore          : Suppress error, don't record
# - Inquire         : Prompt user

# ============================================================================
# PRACTICAL APPLICATIONS
# ============================================================================

# PATTERN 1: Global Stop with selective Continue
# $ErrorActionPreference = "Stop"
# Remove-Item "MayNotExist.txt" -ErrorAction SilentlyContinue  # Optional cleanup
# Get-Content "MustExist.txt"                                   # Critical operation

# PATTERN 2: Global Continue with selective Stop
# $ErrorActionPreference = "Continue"
# try {
#     Invoke-WebRequest $url -ErrorAction Stop                  # Force terminating
# }
# catch { Handle-Error }

# Expected Output:
# Does not get caught. Overrides global behavior
# Caught error. ErrorActionPreference=Stop

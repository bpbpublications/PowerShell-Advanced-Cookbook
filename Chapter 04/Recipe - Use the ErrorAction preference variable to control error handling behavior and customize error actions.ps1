# Recipe: Use ErrorAction Preference Variable to Control Error Handling
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This recipe demonstrates all ErrorActionPreference values and how they
# affect error behavior, plus how -ErrorAction on individual cmdlets can
# override the global preference for fine-grained control.

# ============================================================================
# ERRORACTIONPREFERENCE VALUES OVERVIEW
# ============================================================================

# $ErrorActionPreference is a preference variable that controls how PowerShell
# responds to non-terminating errors. It can be set at any scope (session,
# script, function) and affects all subsequent commands in that scope.

# VALUES:
# - Continue        : Display error, continue execution (DEFAULT)
# - Stop            : Convert to terminating error, can catch with try/catch
# - SilentlyContinue: Suppress display, continue execution, record in $Error
# - Ignore          : Suppress display, continue, DON'T record in $Error
# - Inquire         : Prompt user for action (interactive only)

# ============================================================================
# CONTINUE (DEFAULT) - Display and Continue
# ============================================================================

$ErrorActionPreference = "Continue"

# Error is displayed but script continues
Get-Content -Path "NonExistingFile.txt"
Write-Output "Outputs error. Script execution continues"

# ============================================================================
# STOP - Convert to Terminating Error
# ============================================================================

$ErrorActionPreference = "Stop"

# This converts non-terminating error to terminating
# Script will HALT here unless in try/catch
Get-Content -Path "NonExistingFile.txt"
Write-Output "Outputs error. Script execution does not continue"

# ============================================================================
# SILENTLYCONTINUE - Suppress Display
# ============================================================================

$ErrorActionPreference = "SilentlyContinue"

# Error is NOT displayed, but IS recorded in $Error
Get-Content -Path "NonExistingFile.txt"
Write-Output "No error output. Script execution continues"

# ============================================================================
# INQUIRE - Interactive Prompting
# ============================================================================

$ErrorActionPreference = "Inquire"

# User is prompted: Yes, Yes to All, Halt, Suspend
Get-Content -Path "NonExistingFile.txt"
Write-Output "Prompts user for continuation. Shows error. Further execution depends on user answer"

# ============================================================================
# IGNORE - Complete Suppression
# ============================================================================

$ErrorActionPreference = "Ignore"

# Error is suppressed AND not recorded in $Error
Get-Content -Path "NonExistingFile.txt"
Write-Output "Ignores all errors. Script execution continues"

# ============================================================================
# CMDLET-LEVEL OVERRIDE WITH -ERRORACTION
# ============================================================================

# The -ErrorAction parameter overrides $ErrorActionPreference for one command
# This allows mixing behaviors within a single script

$ErrorActionPreference = "Stop"

try {
    # This command uses -ErrorAction to OVERRIDE the global "Stop"
    # Error is silently suppressed for this command only
    Get-Content -Path "NonExistingFile.txt" -ErrorAction SilentlyContinue
    Write-Output "Does not get caught. Overrides global behavior"

    # This command uses the global preference (Stop)
    # Error is terminating and will be caught
    Get-Content -Path "NonExistingFile.txt"
    Write-Output "Gets caught due to ErrorActionPreference"
}
catch {
    Write-Output "Caught error. ErrorActionPreference=$ErrorActionPreference"
}

# ============================================================================
# KEY CONCEPTS AND BEST PRACTICES
# ============================================================================

# PRECEDENCE (highest to lowest):
# 1. -ErrorAction parameter on cmdlet
# 2. $ErrorActionPreference in current scope
# 3. $ErrorActionPreference in parent scope
# 4. Default ("Continue")

# RECOMMENDED PATTERNS:
#
# Production scripts:
#   $ErrorActionPreference = "Stop"
#   try { ... } catch { ... }
#
# Optional operations:
#   Remove-Item $file -ErrorAction SilentlyContinue
#
# Critical operations with fallback:
#   try {
#       Invoke-WebRequest $url -ErrorAction Stop
#   }
#   catch {
#       # Fallback logic
#   }

# Expected Output (running all sections would halt at Stop):
# Get-Content: Cannot find path...
# Outputs error. Script execution continues
# (Script halts at Stop section unless commented out)

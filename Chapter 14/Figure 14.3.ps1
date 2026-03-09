# Figure 14.3 - Get Specific Service by Name
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (Microsoft.PowerShell.Management module)
# Prerequisites: None (built-in cmdlet)

# ============================================================================
# GET A SPECIFIC SERVICE BY NAME
# ============================================================================

# Use the -Name parameter to get a specific service
# WSearch is the Windows Search service
Get-Service -Name WSearch

# Expected Output:
# Status   Name    DisplayName
# ------   ----    -----------
# Running  WSearch Windows Search

# ============================================================================
# POSITIONAL PARAMETER USAGE
# ============================================================================

# The -Name parameter is at position 0, so it can be used positionally
# This is equivalent to the command above
Get-Service WSearch

# ============================================================================
# ERROR HANDLING FOR NON-EXISTENT SERVICES
# ============================================================================

# Using -Name with a non-existent service throws a terminating error
# This is different from wildcards which return nothing silently
Get-Service WSear

# Expected Error:
# Get-Service: Cannot find any service with service name 'WSear'.
#
# NOTE: Use -ErrorAction SilentlyContinue to suppress errors when checking
# if a service exists: Get-Service -Name "WSear" -ErrorAction SilentlyContinue


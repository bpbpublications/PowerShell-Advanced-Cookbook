# Figure 14.9 - Get Specific Processes
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (Microsoft.PowerShell.Management module)
# Prerequisites: None (built-in cmdlet)

# ============================================================================
# GET SPECIFIC PROCESSES BY NAME
# ============================================================================

# Method 1: Using Where-Object to filter processes
# This approach gives full control over the filter logic
Get-Process | Where-Object { $_.ProcessName -eq "pwsh" }

# Method 2: Using the -Name parameter directly
# This is more efficient as filtering happens at the cmdlet level
Get-Process -Name "pwsh"

# Expected Output:
# NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
# ------    -----      -----     ------      --  -- -----------
#     85    150.23     180.45      5.67   12345   1 pwsh
#     72    125.89     145.32      3.21   12346   1 pwsh
#
# Key Properties:
# - NPM(K): Non-paged memory in kilobytes
# - PM(M): Paged memory in megabytes
# - WS(M): Working set (physical memory) in megabytes
# - CPU(s): CPU time in seconds
# - Id: Process ID (PID)
# - SI: Session ID
#
# NOTE: Multiple instances of the same process are shown separately
# Use -Name with wildcards: Get-Process -Name "pw*"


# Figure 14.8 - Process-Related Cmdlets
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (Microsoft.PowerShell.Management module)
# Prerequisites: None (built-in module)

# ============================================================================
# LIST PROCESS-RELATED CMDLETS
# ============================================================================

# Get all cmdlets related to processes from the Management module
# These cmdlets allow you to query, start, stop, and manage processes
Get-Command -Module Microsoft.PowerShell.Management -Name "*process"

# Expected Output:
# CommandType  Name            Version    Source
# -----------  ----            -------    ------
# Cmdlet       Debug-Process   7.0.0.0    Microsoft.PowerShell.Management
# Cmdlet       Get-Process     7.0.0.0    Microsoft.PowerShell.Management
# Cmdlet       Start-Process   7.0.0.0    Microsoft.PowerShell.Management
# Cmdlet       Stop-Process    7.0.0.0    Microsoft.PowerShell.Management
# Cmdlet       Wait-Process    7.0.0.0    Microsoft.PowerShell.Management
#
# Key Cmdlets:
# - Get-Process: Query running processes and their properties
# - Start-Process: Launch new processes
# - Stop-Process: Terminate running processes
# - Wait-Process: Wait for processes to exit
# - Debug-Process: Attach debugger to a process
#
# NOTE: These cmdlets work cross-platform in PowerShell 7
# Some parameters are Windows-specific


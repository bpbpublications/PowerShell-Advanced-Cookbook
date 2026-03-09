# Figure 14.1 - Service-Related Cmdlets
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (Microsoft.PowerShell.Management module)
# Prerequisites: None (built-in module)

# ============================================================================
# LIST SERVICE-RELATED CMDLETS
# ============================================================================

# Get all cmdlets related to services from the Management module
# These cmdlets allow you to query, start, stop, and manage Windows services
Get-Command -Module Microsoft.PowerShell.Management -Name "*service"

# Expected Output:
# CommandType  Name              Version    Source
# -----------  ----              -------    ------
# Cmdlet       Get-Service       7.0.0.0    Microsoft.PowerShell.Management
# Cmdlet       New-Service       7.0.0.0    Microsoft.PowerShell.Management
# Cmdlet       Remove-Service    7.0.0.0    Microsoft.PowerShell.Management
# Cmdlet       Restart-Service   7.0.0.0    Microsoft.PowerShell.Management
# Cmdlet       Resume-Service    7.0.0.0    Microsoft.PowerShell.Management
# Cmdlet       Set-Service       7.0.0.0    Microsoft.PowerShell.Management
# Cmdlet       Start-Service     7.0.0.0    Microsoft.PowerShell.Management
# Cmdlet       Stop-Service      7.0.0.0    Microsoft.PowerShell.Management
# Cmdlet       Suspend-Service   7.0.0.0    Microsoft.PowerShell.Management
#
# Key Cmdlets:
# - Get-Service: Query service status and properties
# - Start-Service / Stop-Service: Control service state
# - New-Service: Register a new Windows service
# - Remove-Service: Unregister a Windows service (PowerShell 6+)
# - Set-Service: Modify service properties


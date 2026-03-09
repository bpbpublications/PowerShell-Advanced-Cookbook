# Figure 14.7 - Remove a Windows Service
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (Microsoft.PowerShell.Management module)
# Prerequisites: Administrator privileges

# ============================================================================
# REMOVE SERVICE IN POWERSHELL 6+
# ============================================================================

# Remove-Service cmdlet is available in PowerShell 6 and later
# This unregisters the service from the Windows Service Control Manager
Remove-Service "TestService"

# Expected Output:
# (No output on success)

# ============================================================================
# REMOVE SERVICE IN WINDOWS POWERSHELL 5.1
# ============================================================================

# In Windows PowerShell 5.1, Remove-Service doesn't exist
# Use sc.exe (Service Control) command instead
sc.exe delete "TestService"

# Expected Output:
# [SC] DeleteService SUCCESS
#
# NOTE: The service must be stopped before removal
# If the service is running, stop it first:
# Stop-Service "TestService" -Force
#
# Alternative method using WMI (works in all PowerShell versions):
# $service = Get-WmiObject -Class Win32_Service -Filter "Name='TestService'"
# $service.Delete()


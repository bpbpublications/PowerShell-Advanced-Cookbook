# Figure 15.19 - Event Viewer Application Log
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows
# Prerequisites: None
#
# This figure shows the Windows Event Viewer with service log entries.
#
# ============================================================================
# EVENT VIEWER - APPLICATION LOG
# ============================================================================
#
# Windows Services write to the Application event log. To view:
# Run: eventvwr.msc > Windows Logs > Application
#
# ┌─────────────────────────────────────────────────────────────────────────┐
# │ Event Viewer - Application                                              │
# ├─────────────────────────────────────────────────────────────────────────┤
# │ Level   │ Date/Time         │ Source              │ Event ID │ Category │
# ├─────────────────────────────────────────────────────────────────────────┤
# │ Info    │ 1/12/2024 10:00   │ WeatherLogService   │ 0        │ None     │
# │ Info    │ 1/12/2024 09:59   │ WeatherLogService   │ 0        │ None     │
# │ Error   │ 1/12/2024 09:58   │ WeatherLogService   │ 0        │ None     │
# │ Info    │ 1/12/2024 09:00   │ Service Control Mgr │ 7036     │ None     │
# └─────────────────────────────────────────────────────────────────────────┘
#
# PowerShell to query service events:
# Get-EventLog -LogName Application -Source "WeatherLogService" -Newest 10
#
# Or using Get-WinEvent (newer):
# Get-WinEvent -FilterHashtable @{LogName='Application'; ProviderName='WeatherLogService'} -MaxEvents 10
#
# Write-Host in service code writes to Application log

# No executable code - this is a screenshot figure


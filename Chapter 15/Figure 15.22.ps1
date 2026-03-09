# Figure 15.22 - Service Control with PowerShell
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows
# Prerequisites: None
#
# This figure shows PowerShell commands for service management.
#
# ============================================================================
# SERVICE MANAGEMENT WITH POWERSHELL
# ============================================================================
#
# Common service management commands:
#
# ┌─────────────────────────────────────────────────────────────────────────┐
# │ PowerShell Service Commands                                              │
# ├─────────────────────────────────────────────────────────────────────────┤
# │                                                                          │
# │ # Get service status                                                     │
# │ Get-Service -Name "WeatherLogService"                                   │
# │                                                                          │
# │ # Start the service                                                      │
# │ Start-Service -Name "WeatherLogService"                                 │
# │                                                                          │
# │ # Stop the service                                                       │
# │ Stop-Service -Name "WeatherLogService"                                  │
# │                                                                          │
# │ # Restart the service                                                    │
# │ Restart-Service -Name "WeatherLogService"                               │
# │                                                                          │
# │ # Pause the service (if supported)                                       │
# │ Suspend-Service -Name "WeatherLogService"                               │
# │                                                                          │
# │ # Resume a paused service                                                │
# │ Resume-Service -Name "WeatherLogService"                                │
# │                                                                          │
# │ # Set startup type                                                       │
# │ Set-Service -Name "WeatherLogService" -StartupType Automatic            │
# │                                                                          │
# │ # View all service properties                                            │
# │ Get-Service -Name "WeatherLogService" | Select-Object *                 │
# │                                                                          │
# └─────────────────────────────────────────────────────────────────────────┘

# No executable code - this is a screenshot figure


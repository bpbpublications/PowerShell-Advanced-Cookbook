# Figure 15.12 - Windows Services Console
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows
# Prerequisites: None
#
# This figure shows the Windows Services management console (services.msc).
#
# ============================================================================
# WINDOWS SERVICES CONSOLE
# ============================================================================
#
# To open: Run services.msc or Control Panel > Administrative Tools > Services
#
# ┌─────────────────────────────────────────────────────────────────────────┐
# │ Services (Local)                                                         │
# ├─────────────────────────────────────────────────────────────────────────┤
# │ Name                    │ Description           │ Status  │ Startup     │
# ├─────────────────────────────────────────────────────────────────────────┤
# │ ...                     │                       │         │             │
# │ Weather Log Service     │ Logs weather data...  │ Running │ Automatic   │
# │ Windows Audio           │ Manages audio...      │ Running │ Automatic   │
# │ Windows Defender...     │ Helps protect...      │ Running │ Automatic   │
# │ Windows Update          │ Enables detection...  │ Running │ Manual      │
# │ ...                     │                       │         │             │
# └─────────────────────────────────────────────────────────────────────────┘
#
# Right-click a service to:
# - Start / Stop / Restart
# - Pause / Resume (if supported)
# - View Properties
# - Configure startup type
#
# PowerShell equivalents:
# Get-Service -Name "WeatherLogService"
# Start-Service -Name "WeatherLogService"
# Stop-Service -Name "WeatherLogService"

# No executable code - this is a screenshot figure


# Figure 5.6 - Windows Event Log Access
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates accessing Windows event logs using Get-WinEvent.
# This cmdlet is Windows-only and will error on Linux/macOS.
#
# Platform: Windows only

# ============================================================================
# GET WINDOWS EVENT LOG ENTRY
# ============================================================================

# Get-WinEvent retrieves events from Windows event logs
# -LogName specifies which log to query (System, Application, Security, etc.)
# Select-Object -First 1 returns only the first matching event
Get-WinEvent -LogName System | Select-Object -First 1

# ============================================================================
# EXPECTED OUTPUT (Windows)
# ============================================================================

# ProviderName: Microsoft-Windows-Kernel-General
#
#    TimeCreated                      Id LevelDisplayName Message
#    -----------                      -- ---------------- -------
#    1/12/2026 10:15:32 AM           12 Information      The operating system started...

# ============================================================================
# KEY CONCEPTS
# ============================================================================

# GET-WINEVENT vs GET-EVENTLOG:
# - Get-WinEvent: Modern cmdlet, supports all log types including ETW
# - Get-EventLog: Legacy cmdlet, limited to classic event logs
# - Get-WinEvent is faster and more feature-rich

# COMMON LOG NAMES:
# - System: OS-level events, drivers, services
# - Application: Application-specific events
# - Security: Authentication, authorization, audit events (requires elevation)
# - Setup: Installation events
# - Microsoft-Windows-*: Provider-specific logs

# ============================================================================
# ADDITIONAL EXAMPLES
# ============================================================================

# Get last 10 system errors:
# Get-WinEvent -LogName System -MaxEvents 10 | Where-Object { $_.Level -eq 2 }

# Search for specific event ID:
# Get-WinEvent -FilterHashtable @{LogName='System'; ID=6005,6006}

# Get events from specific time range:
# $StartTime = (Get-Date).AddHours(-24)
# Get-WinEvent -FilterHashtable @{LogName='System'; StartTime=$StartTime}

# Query security log (requires elevation):
# Get-WinEvent -LogName Security -MaxEvents 5

